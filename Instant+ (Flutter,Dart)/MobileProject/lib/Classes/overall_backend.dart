import '../dbHelper.dart';
import 'overall.dart';

extension OverallBackend on Overall {
  // Constructor
  Overall() {
    _loadUserData();
  }

  // New methods for database integration
  void _loadUserData() async {
    final dbUser = await DatabaseHelper.instance.getUser();
    if (dbUser != null) {
      userInfo = dbUser;
      notifyListeners();
    }
  }
}