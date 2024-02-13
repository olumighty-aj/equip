class Paths {
  //  API ENDPOINTS
  static const baseUrl = 'https://admin.equippro.io/api/';
  static const String signUp = 'signup';
  static const String login = 'auth';
  static const String forgotPassword = 'reset_password';
  static const String forgotPasswordVerify = 'change_password';
  static const String ownerEquipment = 'owners/equipments';
  static const String equipments = 'equipments';
  static const String deleteEquipment = 'owners/equipments/delete/';
  static const String switchOwner = 'toggle_users';
  static const String searchMyEquipment = 'owners/equipments?q=';
  static const String searchEquipments = 'equipments?q=';
  static const String book = 'equip_booking';
  static const String equipmentBookingRequestById =
      'equip_booking?equipments_id=';
  static const String active_rentals = 'rentals?active_status=';
  static const String active_owner_rentals = 'owners/rentals?active_status=';
  static const String rate = 'reviews';
  static const String rate_owner = 'owners/reviews';
  static const String equipApproval = 'owners/equip_approval/';
  static const String updateBookings = 'delivery_status';
  static const String editBookings = 'equip_booking/25';
  static const String ownersEarnings = 'owners/earnings';
  static const String ownersProfile = 'owners/profile';
  static const String hirersProfile = 'profile';
  static const String profile = 'profile';
  static const String reviews = 'reviews?hirers_id=';
  static const String pickDate = 'owners/pickup_date/';
  static const String earnings = 'owners/earnings';
  static const String chatList = 'get_user_inbox';
  static const String chatDetails = 'get_chat_details?sender=';
  static const String sendChat = 'send_chat';
  static const String getNotification = 'notification';
  static const String verifyKYC = 'verify_document?hirers_id=';
  static const String logout = 'logout';
  static const String initPayment = 'init_payment';
  static const String createPayment = 'payment/create';
  static const String deliveryStatus = 'delivery_status';
  static const String review = 'reviews';
  static const String profileVisibility = 'profile_visibility';
  static const String notificationSettings = 'notification_setting';
  static const String getSettings = 'get_setting';
  static const String extendBooking = 'extend_booking';
  static const String addBank = 'owners/users_payment_details';
  static const String deleteBank = 'users_payment_details/delete/';
  static const String withdrawal = 'owners/withdrawal_request';
}
