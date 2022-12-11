import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final LogU logU = LogU();

class LogU {
  static final Logger _logger = Logger(
    filter: DevelopmentFilter(),
    printer: () {
      // Auto detecting
      //
      // With the io package you can auto detect the lineLength and colors arguments.
      // Assuming you have imported the io package with import 'dart:io' as io;
      // you can auto detect colors with io.stdout.supportsAnsiEscapes and lineLength
      // with io.stdout.terminalColumns.
      //
      // You should probably do this unless there's a good reason you don't want to import io,
      // for example when using this library on the web.
      final PrettyPrinter realPrinter = PrettyPrinter(
        stackTraceBeginIndex: 1,
        // number of method calls to be displayed
        // ignore: avoid_redundant_argument_values
        methodCount: 2,
        // number of method calls if stacktrace is provided
        errorMethodCount: 10,
        // width of the output
        lineLength: stdout.hasTerminal ? stdout.terminalColumns : 120,
        // Colorful log messages
        //
        // Colorized console output does not work in iOS builds but works for Android builds
        // https://github.com/flutter/flutter/issues/64491
        colors: !Platform.isIOS,
        // Print an emoji for each log message
        // ignore: avoid_redundant_argument_values
        printEmojis: true,
        // Should each log print contain a timestamp
        printTime: true,
      );

      // Colors
      //
      // Please note that all IDEs (VSCode, XCode, Android Studio, IntelliJ)
      // do not support ANSI escape sequences in their terminal outputs.
      // These escape sequences are used to color output.
      // If using such an IDE do not configure colored output.
      //
      // However, if you are using a JetBrains IDE (Android Studio, IntelliJ, etc.)
      // you can make use of the Grep Console Plugin and the PrefixPrinter decorator
      // to achieved colored logs for any logger:
      if (!realPrinter.colors) {
        return PrefixPrinter(realPrinter);
      }

      return realPrinter;
    }(),
    level: () {
      if (kDebugMode) {
        return Level.debug;
      } else if (kProfileMode) {
        return Level.error;
      }
      return Level.nothing;
    }(),
  );

  void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.v(message, error, stackTrace);
  }

  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error, stackTrace);
  }

  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error, stackTrace);
  }

  void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error, stackTrace);
  }

  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error, stackTrace);
  }

  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.wtf(message, error, stackTrace);
  }
}
