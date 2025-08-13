import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/survey_data.dart';

class FirebaseService {
  static const String projectId = 'cari-survey-app';
  
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Stream<List<SurveyData>> getSurveys() {
    return _firestore
        .collection('artifacts/$projectId/public/data/cari_survey')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => SurveyData.fromFirestore(doc))
            .toList());
  }

  static Stream<List<NoReasonData>> getNoReasons() {
    return _firestore
        .collection('artifacts/$projectId/public/data/cari_no_reasons')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => NoReasonData.fromFirestore(doc))
            .toList());
  }

  static Future<void> signInAnonymously() async {
    await _auth.signInAnonymously();
  }
}