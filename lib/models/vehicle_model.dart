import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleModel {
  final String id;
  final String userId;
  final String vehicleName;
  final String vehicleModel;
  final String vehicleNumber;
  final String vehicleType;
  final String? image; 
  final DateTime createdAt;
  final DateTime updatedAt;

  VehicleModel({
    required this.id,
    required this.userId,
    required this.vehicleName,
    required this.vehicleModel,
    required this.vehicleNumber,
    required this.vehicleType,
    this.image,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

 
  // FROM FIRESTORE
  factory VehicleModel.fromMap(Map<String, dynamic> map, String documentId) {
    return VehicleModel(
      id: documentId,
      userId: map['userId'] ?? '',
      vehicleName: map['vehicleName'] ?? '',
      vehicleModel: map['vehicleModel'] ?? '',
      vehicleNumber: map['vehicleNumber'] ?? '',
      vehicleType: map['vehicleType'] ?? '',
      image: map['image'],
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  
  // TO FIRESTORE
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'vehicleName': vehicleName,
      'vehicleModel': vehicleModel,
      'vehicleNumber': vehicleNumber,
      'vehicleType': vehicleType,
      'image': image,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  
  // COPY WITH   
  
  VehicleModel copyWith({
    String? vehicleName,
    String? vehicleModel,
    String? vehicleNumber,
    String? vehicleType,
    String? image,
  }) {
    return VehicleModel(
      id: id,
      userId: userId,
      vehicleName: vehicleName ?? this.vehicleName,
      vehicleModel: vehicleModel ?? this.vehicleModel,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      vehicleType: vehicleType ?? this.vehicleType,
      image: image ?? this.image,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
