import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/config/theme/theme.dart';
import 'package:toktik/infraestructure/datasources/local_video_datasource_impl.dart';
import 'package:toktik/infraestructure/respositories/video_post_repository_impl.dart';
import 'package:toktik/presentation/providers/discover_provider.dart';
import 'presentation/screens/discover/discover_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final videoPostRepository =
        VideoPostsRepositoryImpl(videosDataSource: LocalVideoDatasource());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            lazy: false,
            create: (_) =>
                DiscoverProvider(videoPostRepository: videoPostRepository)
                  ..loadNextPage())
      ],
      child: MaterialApp(
        title: 'Tok Tik',
        theme: AppTheme().getTheme(),
        home: const DiscoverScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
