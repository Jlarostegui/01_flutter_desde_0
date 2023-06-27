import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_app/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(const NotificationsState()) {
    on<NotificationStatusChanged>(_notificationsStatusChanged);
    _initialStatusCheck();
    _onForegroundMessage();
  }

  static Future<void> initializeFirebaseNotifications() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  void _notificationsStatusChanged(
      NotificationStatusChanged event, Emitter<NotificationsState> emit) {
    emit(
      state.copiWith(status: event.status),
    );
    _getFCMToken();
  }

  void requestPermisions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    add(NotificationStatusChanged(
      settings.authorizationStatus,
    ));
    _getFCMToken();
  }

  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    add(NotificationStatusChanged(
      settings.authorizationStatus,
    ));
    _getFCMToken();
  }

  void _getFCMToken() async {
    final settings = await messaging.getNotificationSettings();
    if (state.status != AuthorizationStatus.authorized) return;
    final token = await messaging.getToken();
    print(token);
  }

  void _handleRemoteMessage(RemoteMessage message) async {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification == null) return;
    print('Message also contained a notification: ${message.notification}');
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
  }
}
