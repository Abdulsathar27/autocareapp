class FirebaseKeys {
  // COLLECTIONS
  static const String users = "users";
  static const String vehicles = "vehicles";
  static const String bookings = "bookings";
  static const String services = "services";
  static const String notifications = "notifications";
  static const String admins = "admins";
  
  // COMMON FIELDS
  static const String id = "id"; 
  static const String userId = "userId";
  static const String createdAt = "createdAt";
  static const String updatedAt = "updatedAt";
  static const String image = "image";
  
  // USER FIELDS
  static const String name = "name";
  static const String email = "email";
  static const String phone = "phone";
  static const String profileImage = "profileImage";

  // VEHICLE FIELDS
  static const String vehicleName = "vehicleName";
  static const String vehicleModel = "vehicleModel";
  static const String vehicleNumber = "vehicleNumber";
  static const String vehicleType = "vehicleType";
  
  // BOOKING FIELDS
  static const String vehicleId = "vehicleId";
  static const String serviceId = "serviceId";
  static const String bookingDate = "bookingDate";
  static const String bookingTime = "bookingTime";
  static const String bookingStatus = "bookingStatus";
  static const String adminNote = "adminNote";

  // BOOKING STATUS VALUES
  static const String statusPending = "pending";
  static const String statusConfirmed = "confirmed";
  static const String statusCompleted = "completed";
  static const String statusCancelled = "cancelled";

  // SERVICE FIELDS
  static const String serviceName = "serviceName";
  static const String serviceDescription = "serviceDescription";
  static const String servicePrice = "servicePrice";
  static const String serviceImage = "serviceImage";

  // STORAGE PATHS
  static const String userProfileImages = "users/profile_images/";
  static const String vehicleImages = "vehicles/images/";
  static const String serviceImages = "services/images/";
}
