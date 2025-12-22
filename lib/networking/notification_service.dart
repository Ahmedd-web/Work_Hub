import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FlutterLocalNotificationsPlugin local =
      FlutterLocalNotificationsPlugin();
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _notifSub;
  bool localInitialized = false;
  final String defaultChannelId = 'mhnty_default_channel';
  final String defaultChannelName = 'Mhnty Notifications';
  final String pushQueueCollection = 'push_queue';

  Future<void> initLocalNotifications() async {
    if (localInitialized) return;
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);
    await local.initialize(initSettings);
    localInitialized = true;
  }

  Future<void> requestPermissionIfNeeded() async {
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      debugPrint('Notification permission denied');
    }
  }

  Future<void> saveFcmToken(String uid) async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token == null) return;
      debugPrint('FCM token: $token');
      await firestore.collection('user_tokens').doc(uid).set({
        'token': token,
        'platform': defaultTargetPlatform.name,
        'updated_at': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('saveFcmToken error: $e');
    }
  }

  Future<void> ensurePermissionsAndSaveToken(String uid) async {
    await requestPermissionIfNeeded();
    await initLocalNotifications();
    FirebaseMessaging.onMessage.listen(showRemoteNotification);
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      firestore.collection('user_tokens').doc(uid).set({
        'token': newToken,
        'platform': defaultTargetPlatform.name,
        'updated_at': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    });
    await saveFcmToken(uid);
    startListeningForUser(uid);
  }

  /// Enqueue a remote push notification to be sent by backend/Cloud Function.
  Future<void> enqueueStatusNotification({
    required String targetUid,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      await firestore.collection(pushQueueCollection).add({
        'target_uid': targetUid,
        'title': title,
        'body': body,
        'data': data ?? {},
        'created_at': FieldValue.serverTimestamp(),
        'sent': false,
      });
    } catch (e) {
      debugPrint('enqueueStatusNotification error: $e');
    }
  }

  Future<void> showLocalTestNotification({
    String title = 'Test notification',
    String body = 'This is a local test',
  }) async {
    await initLocalNotifications();
    const androidDetails = AndroidNotificationDetails(
      'test_channel',
      'Test Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );
    const details = NotificationDetails(android: androidDetails);
    await local.show(0, title, body, details);
  }

  Future<void> sendJobExpiryReminder({
    required String ownerUid,
    required String jobId,
    required String jobTitle,
  }) async {
    try {
      await firestore.collection('notifications').add({
        'owner_uid': ownerUid,
        'job_id': jobId,
        'type': 'job_expiry',
        'title_ar': 'سينتهي نشر وظيفتك قريباً',
        'title_en': 'Your job post will expire soon',
        'body_ar': 'إعلان "$jobTitle" سيُزال خلال أقل من ساعة.',
        'body_en': 'Job "$jobTitle" will be removed in less than an hour.',
        'created_at': FieldValue.serverTimestamp(),
        'read': false,
      });
    } catch (_) {}
  }

  Future<void> showRemoteNotification(RemoteMessage message) async {
    await initLocalNotifications();
    final notification = message.notification;
    final android = message.notification?.android;
    final title = notification?.title ?? 'إشعار';
    final body = notification?.body ?? '';

    final androidDetails = AndroidNotificationDetails(
      android?.channelId ?? defaultChannelId,
      defaultChannelName,
      importance: Importance.high,
      priority: Priority.high,
      icon: android?.smallIcon,
    );
    final details = NotificationDetails(android: androidDetails);
    await local.show(
      notification.hashCode,
      title,
      body,
      details,
      payload: message.data.toString(),
    );
  }

  /// استمع لإشعارات المستخدم (مثل قبول/رفض الطلبات) واعرض إشعاراً محلياً عند وصولها.
  void startListeningForUser(String uid) {
    _notifSub?.cancel();
    _notifSub = firestore
        .collection('notifications')
        .where('user_uid', isEqualTo: uid)
        .where('read', isEqualTo: false)
        .snapshots()
        .listen((snap) async {
      for (final doc in snap.docs) {
        final data = doc.data();
        final status = (data['status'] as String?) ?? '';
        final jobTitle = (data['job_title'] as String?) ?? '';
        final title = status == 'accepted'
            ? 'تم قبول طلبك'
            : status == 'rejected'
                ? 'تم رفض طلبك'
                : (data['title'] as String?) ?? 'إشعار';
        final body = status == 'accepted'
            ? 'تم قبول طلبك لوظيفة $jobTitle'
            : status == 'rejected'
                ? 'تم رفض طلبك لوظيفة $jobTitle'
                : (data['body'] as String?) ?? jobTitle;

        await showLocalTestNotification(title: title, body: body);
        // نترك علامة القراءة للواجهة (قائمة الإشعارات) كي لا يختفي التنبيه مباشرة.
      }
    });
  }

  Future<void> disposeListener() async {
    await _notifSub?.cancel();
    _notifSub = null;
  }
}
