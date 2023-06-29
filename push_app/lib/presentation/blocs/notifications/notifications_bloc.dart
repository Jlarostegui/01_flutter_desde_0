import 'package:firebase_core/firebase_core.dart';
import 'package:push_app/domain/entities/push_message.dart';
import 'package:push_app/firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

Future<void> firebaseMessagingBackGroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(const NotificationsState()) {
    on<NotificationStatusChanged>(_notificationsStatusChanged);
    on<NotificationsRecibida>(_onPushMessage);
    _initialStatusCheck();
    _onForegroundMessage();
  }

  static Future<void> initializeFirebaseNotifications() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  void _onPushMessage(
      NotificationsRecibida event, Emitter<NotificationsState> emit) {
    emit(state.copiWith(
        notificactions: [event.pushMessage, ...state.notificactions]));
  }

  void _notificationsStatusChanged(
      NotificationStatusChanged event, Emitter<NotificationsState> emit) {
    emit(
      state.copiWith(status: event.status),
    );
    _getFCMToken();
  }

  static Future<void> initializeFCM() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
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
    if (message.notification == null) return;

    final PushMessage notification = PushMessage(
        messaggeId:
            message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        sentDate: message.sentTime ?? DateTime.now(),
        imageUrl: message.notification?.android?.imageUrl,
        data: message.data);

    add(NotificationsRecibida(notification));
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
  }
}
