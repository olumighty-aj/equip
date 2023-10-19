class Paths {
  //  API ENDPOINTS
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
  static const String active_rentals = 'rentals?active_status=';
  static const String active_owner_rentals = 'owners/rentals?active_status=';
  static const String rate = 'reviews';
  static const String rate_owner = 'owners/reviews';
  static const String equipApproval = 'owners/equip_approval/';
  static const String updateBookings = 'delivery_status';
  static const String ownersEarnings = 'owners/earnings';
  static const String ownersProfile = 'owners/profile';
  static const String profile = 'profile';
  static const String reviews = 'reviews?hirers_id=';
  static const String pickDate = 'owners/pickup_date/';
  static const String  earnings = 'owners/earnings';
  static const String  chatList = 'get_user_inbox';
  static const String  chatDetails = 'get_chat_details?user_1=';
  static const String  sendChat = 'send_chat';
  static const String  getNotification = 'notification';



}
