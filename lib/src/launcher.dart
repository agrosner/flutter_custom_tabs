import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';

import 'custom_tabs_launcher.dart';
import 'custom_tabs_option.dart';
import 'url_launcher.dart';

/// Open the specified Web URL with custom tab.
///
/// Custom Tab is only supported on the Android platform.
/// Therefore, this plugin uses [url_launcher](https://pub.dartlang.org/packages/url_launcher) on iOS to launch SFSafariViewController.
/// (The specified [option] is ignored on iOS.)
///
/// When Chrome is not installed on Android device, try to start other browsers.
/// And throw [PlatformException] if browser is not installed.
///
/// Example:
///
/// ```dart
/// await launch(
///   'https://flutter.io',
///   option: new CustomTabsOption(
///     toolbarColor: Theme.of(context).primaryColor,
///     enableUrlBarHiding: true,
///     showPageTitle: true,
///     animation: new CustomTabsAnimation.slideIn()
///   ),
/// );
/// ```
Future<void> launch(
  String urlString, {
  @required CustomTabsOption option,
}) {
  assert(urlString != null);
  assert(option != null);

  return _launcher(urlString, option);
}

typedef Future<void> _PlatformLauncher(
    String urlString, CustomTabsOption option);

_PlatformLauncher get _launcher {
  if (_platformLauncher == null) {
    _platformLauncher = Platform.isAndroid ? customTabsLauncher : urlLauncher;
  }
  return _platformLauncher;
}

_PlatformLauncher _platformLauncher;
