class AppStringConstants {
  static AppStringConstants? _instance;
  static AppStringConstants? get instance {
    if (_instance == null) {
      _instance = AppStringConstants._init();
    }
    return _instance;
  }

  AppStringConstants._init();

  final String chat = "Chat";
  final String edit = "Edit";
  final String broad = "Broadcast List";
  final String newGroup = "New Group";
  final String search = "Search";
}
