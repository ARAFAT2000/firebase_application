class SessionController {
  static final SessionController _instance = SessionController._internal();
  factory SessionController() => _instance;
  SessionController._internal();

  String? userId;

  void setUserId(String uid) {
    userId = uid;
  }
  void clearUserId() {
    userId = null;
  }
}
