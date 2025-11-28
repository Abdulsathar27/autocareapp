class AppLogger {
  // Enable or disable logs globally
  static const bool _enableLogs = true;

  // ---------------------------------------------------------
  // INFO LOGS
  // ---------------------------------------------------------
  static void info(String message) {
    if (_enableLogs) {
      // ignore: avoid_print
      print("[INFO] $message");
    }
  }

  // ---------------------------------------------------------
  // WARNING LOGS
  // ---------------------------------------------------------
  static void warn(String message) {
    if (_enableLogs) {
      // ignore: avoid_print
      print("[WARNING] $message");
    }
  }

  // ---------------------------------------------------------
  // ERROR LOGS
  // ---------------------------------------------------------
  static void error(String message, {Object? exception}) {
    if (_enableLogs) {
      // ignore: avoid_print
      print("[ERROR] $message");
      if (exception != null) {
        // ignore: avoid_print
        print("Exception: $exception");
      }
    }
  }

  // ---------------------------------------------------------
  // DEBUG LOGS
  // ---------------------------------------------------------
  static void debug(String message) {
    if (_enableLogs) {
      // ignore: avoid_print
      print("[DEBUG] $message");
    }
  }
}
