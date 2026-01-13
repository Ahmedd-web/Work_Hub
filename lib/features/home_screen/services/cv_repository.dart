import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:work_hub/features/home_screen/models/cv_data.dart';

class CvRepository {
  CvRepository._();

  static final firestore = FirebaseFirestore.instance;

  static Stream<CvData?> watchCv(String uid) {
    return firestore.collection('CV').doc(uid).snapshots().map((snapshot) {
      if (!snapshot.exists) return null;
      return CvData.fromMap(snapshot.data() ?? {});
    });
  }

  static Future<CvData?> fetchCv(String uid) async {
    final doc = await firestore.collection('CV').doc(uid).get();
    if (!doc.exists) return null;
    return CvData.fromMap(doc.data() ?? {});
  }

  static Future<void> saveCv(String uid, CvData data) {
    return firestore.collection('CV').doc(uid).set(data.toMap());
  }
}
