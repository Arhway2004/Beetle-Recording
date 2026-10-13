import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

/// Abstraction over the OS notification scheduler (iOS
/// UNUserNotificationCenter / Android AlarmManager via flutter_local_notifications).
abstract class NotificationGateway {
  Future<void> initialize();
  Future<bool> hasPermission();

  /// Asks the user. Call only in context (e.g. when confirming a reminder).
  Future<bool> requestPermission();
  Future<bool> canScheduleExact();
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime at,
    required bool exact,
    String? payload,
  });
  Future<void> cancel(int id);
  Future<Set<int>> pendingIds();

  /// Re-reads the device time zone (after resume / time-zone change).
  Future<void> refreshTimeZone();
}

class LocalNotificationGateway implements NotificationGateway {
  LocalNotificationGateway([FlutterLocalNotificationsPlugin? plugin])
      : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  bool _initialized = false;

  static const _channel = AndroidNotificationDetails(
    'beetle_reminders',
    'Breeding reminders',
    channelDescription: 'Reminders you confirmed in Beetle Keeper',
    importance: Importance.high,
    priority: Priority.high,
  );

  @override
  Future<void> initialize() async {
    if (_initialized) return;
    tzdata.initializeTimeZones();
    await refreshTimeZone();
    await _plugin.initialize(const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      // Do not prompt at launch; permission is requested contextually.
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    ));
    _initialized = true;
  }

  @override
  Future<void> refreshTimeZone() async {
    try {
      final identifier = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(identifier));
    } catch (e) {
      // Unknown identifier: instants are scheduled absolutely (UTC), so only
      // display is affected.
      debugPrint('time zone lookup failed: $e');
      tz.setLocalLocation(tz.UTC);
    }
  }

  @override
  Future<bool> hasPermission() async {
    if (Platform.isAndroid) {
      final a = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      return await a?.areNotificationsEnabled() ?? false;
    }
    if (Platform.isIOS) {
      final i = _plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
      final opts = await i?.checkPermissions();
      return opts?.isEnabled ?? false;
    }
    return false;
  }

  @override
  Future<bool> requestPermission() async {
    if (Platform.isAndroid) {
      final a = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      return await a?.requestNotificationsPermission() ?? false;
    }
    if (Platform.isIOS) {
      final i = _plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
      return await i?.requestPermissions(alert: true, badge: true, sound: true) ?? false;
    }
    return false;
  }

  @override
  Future<bool> canScheduleExact() async {
    if (!Platform.isAndroid) return true;
    final a = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    return await a?.canScheduleExactNotifications() ?? false;
  }

  @override
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime at,
    required bool exact,
    String? payload,
  }) =>
      _plugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(at.toUtc(), tz.local),
        const NotificationDetails(android: _channel, iOS: DarwinNotificationDetails()),
        androidScheduleMode:
            exact ? AndroidScheduleMode.exactAllowWhileIdle : AndroidScheduleMode.inexactAllowWhileIdle,
        payload: payload,
      );

  @override
  Future<void> cancel(int id) => _plugin.cancel(id);

  @override
  Future<Set<int>> pendingIds() async =>
      (await _plugin.pendingNotificationRequests()).map((r) => r.id).toSet();
}
