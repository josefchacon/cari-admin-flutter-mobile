import 'package:cloud_firestore/cloud_firestore.dart';

class SurveyData {
  final String userId;
  final Timestamp? timestamp;
  final List<String> recipients;
  final List<String> giftDetails;
  final String? otherGiftDetail;
  final List<String> giftTypes;
  final String? otherGiftType;
  final String frequency;
  final String price;
  final String servicePrice;
  final List<String> currentMethod;
  final String? otherCurrentMethod;
  final List<String> cities;
  final String? otherCity;
  final String wantsToTryApp;
  final String? email;
  final String? phoneNumber;

  SurveyData({
    required this.userId,
    this.timestamp,
    required this.recipients,
    required this.giftDetails,
    this.otherGiftDetail,
    required this.giftTypes,
    this.otherGiftType,
    required this.frequency,
    required this.price,
    required this.servicePrice,
    required this.currentMethod,
    this.otherCurrentMethod,
    required this.cities,
    this.otherCity,
    required this.wantsToTryApp,
    this.email,
    this.phoneNumber,
  });

  factory SurveyData.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return SurveyData(
      userId: data['userId'] ?? '',
      timestamp: data['timestamp'],
      recipients: List<String>.from(data['recipients'] ?? []),
      giftDetails: List<String>.from(data['giftDetails'] ?? []),
      otherGiftDetail: data['otherGiftDetail'],
      giftTypes: List<String>.from(data['giftTypes'] ?? []),
      otherGiftType: data['otherGiftType'],
      frequency: data['frequency'] ?? '',
      price: data['price'] ?? '',
      servicePrice: data['servicePrice'] ?? '',
      currentMethod: List<String>.from(data['currentMethod'] ?? []),
      otherCurrentMethod: data['otherCurrentMethod'],
      cities: List<String>.from(data['cities'] ?? []),
      otherCity: data['otherCity'],
      wantsToTryApp: data['wantsToTryApp'] ?? '',
      email: data['email'],
      phoneNumber: data['phoneNumber'],
    );
  }
}

class NoReasonData {
  final String userId;
  final Timestamp? timestamp;
  final String reason;
  final List<String>? platforms;

  NoReasonData({
    required this.userId,
    this.timestamp,
    required this.reason,
    this.platforms,
  });

  factory NoReasonData.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return NoReasonData(
      userId: data['userId'] ?? '',
      timestamp: data['timestamp'],
      reason: data['reason'] ?? '',
      platforms: data['platforms'] != null ? List<String>.from(data['platforms']) : null,
    );
  }
}