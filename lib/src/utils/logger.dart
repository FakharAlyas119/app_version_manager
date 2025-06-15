/// A utility class for colorful console logging
///
/// Provides methods for displaying different types of messages
/// with appropriate colors for better readability in the terminal.
class Logger {
  // ANSI color codes for terminal output
  static const _reset = '\x1B[0m';
  static const _green = '\x1B[32m';
  static const _yellow = '\x1B[33m';
  static const _red = '\x1B[31m';
  static const _cyan = '\x1B[36m';
  static const _lightGreen = '\x1B[92m';

  /// Logs a debug message in cyan
  void debug(String message) {
    print('${_cyan}DEBUG: $message$_reset');
  }

  /// Logs an informational message in green
  void info(String message) {
    print('${_green}INFO: $message$_reset');
  }

  /// Logs a warning message in yellow
  void warning(String message) {
    print('${_yellow}WARNING: $message$_reset');
  }

  /// Logs an error message in red
  void error(String message) {
    print('${_red}ERROR: $message$_reset');
  }

  /// Logs a success message in light green
  void success(String message) {
    print('${_lightGreen}SUCCESS: $message$_reset');
  }
}
