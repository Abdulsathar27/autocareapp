import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String id;
  final String userId;
  final String vehicleId;
  final String serviceId;

  final DateTime bookingDate;
  final String bookingTime;

  final String status; // pending / confirmed / completed / cancelled
  final String? adminNote;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  BookingModel({
    required this.id,
    required this.userId,
    required this.vehicleId,
    required this.serviceId,
    required this.bookingDate,
    required this.bookingTime,
    required this.status,
    this.adminNote,
    this.createdAt,
    this.updatedAt,
  });

  // ---------------------------------------------------------
  // FROM FIRESTORE
  // ---------------------------------------------------------
  factory BookingModel.fromMap(Map<String, dynamic> map, String documentId) {
    return BookingModel(
      id: documentId,
      userId: map['userId'] ?? '',
      vehicleId: map['vehicleId'] ?? '',
      serviceId: map['serviceId'] ?? '',
      bookingDate: (map['bookingDate'] as Timestamp).toDate(),
      bookingTime: map['bookingTime'] ?? '',
      status: map['bookingStatus'] ?? 'pending',
      adminNote: map['adminNote'],
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: map['updatedAt'] != null
          ? (map['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  // ---------------------------------------------------------
  // TO FIRESTORE
  // ---------------------------------------------------------
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'vehicleId': vehicleId,
      'serviceId': serviceId,
      'bookingDate': bookingDate,
      'bookingTime': bookingTime,
      'bookingStatus': status,
      'adminNote': adminNote,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // ---------------------------------------------------------
  // COPY WITH
  // ---------------------------------------------------------
  BookingModel copyWith({
    String? status,
    String? adminNote,
    DateTime? bookingDate,
    String? bookingTime,
  }) {
    return BookingModel(
      id: id,
      userId: userId,
      vehicleId: vehicleId,
      serviceId: serviceId,
      bookingDate: bookingDate ?? this.bookingDate,
      bookingTime: bookingTime ?? this.bookingTime,
      status: status ?? this.status,
      adminNote: adminNote ?? this.adminNote,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
