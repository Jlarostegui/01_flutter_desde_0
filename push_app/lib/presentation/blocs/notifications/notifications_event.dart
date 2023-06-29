part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class NotificationStatusChanged extends NotificationsEvent {
  final AuthorizationStatus status;

  const NotificationStatusChanged(this.status);
}

class NotificationsRecibida extends NotificationsEvent {
  final PushMessage pushMessage;
  const NotificationsRecibida(this.pushMessage);
}
