import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/presentation/blocs/notifications/notifications_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.select((NotificationsBloc bloc) => Text(
              '${bloc.state.status}',
              style: const TextStyle(fontSize: 20),
            )),
        actions: [
          IconButton(
              onPressed: () {
                context.read<NotificationsBloc>().requestPermisions();
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final notifications =
        context.watch<NotificationsBloc>().state.notificactions;
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(notifications[index].title),
          subtitle: Text(notifications[index].body),
          leading: Image.network(notifications[index].imageUrl ?? ''),
        );
      },
    );
    // return ListView.builder(
    //   itemCount: notifications.length,
    //   itemBuilder: (context, index) {
    //     final notification = notifications[index];
    //     ListTile(
    //       title: Text('hol'),
    //       subtitle: Text(notification.body),
    //       leading: Image.network(notification.imageUrl ?? ''),
    // );
    // },
    // );
  }
}
