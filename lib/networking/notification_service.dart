// NotificationService: manages FCM permissions, token storage, and displaying
// both local test notifications and foreground FCM notifications.
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
  bool localInitialized = false;
  final String defaultChannelId = 'mhnty_default_channel';
  final String defaultChannelName = 'Mhnty Notifications';

  Future<void> initLocalNotifications() async {
    if (localInitialized) return;
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
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
        'updated_at': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (_) {
      // Ignore token failures silently for now.
    }
  }

  Future<void> ensurePermissionsAndSaveToken(String uid) async {
    await requestPermissionIfNeeded();
    await initLocalNotifications();
    FirebaseMessaging.onMessage.listen(showRemoteNotification);
    await saveFcmToken(uid);
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
        'title_ar': 'سينتهي نشر إعلانك قريباً',
        'title_en': 'Your job post will expire soon',
        'body_ar': 'سيتم حذف إعلان "$jobTitle" خلال أقل من ساعة.',
        'body_en': 'Job "$jobTitle" will be removed in less than an hour.',
        'created_at': FieldValue.serverTimestamp(),
        'read': false,
      });
    } catch (_) {
      // Swallow errors to avoid blocking UI.
    }
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
}
