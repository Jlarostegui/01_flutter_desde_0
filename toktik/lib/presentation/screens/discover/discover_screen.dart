import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/presentation/widgets/shared/video_player/video_scrollable_view.dart';
import 'package:toktik/presentation/providers/discover_provider.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final discoverProvider = context.watch<DiscoverProvider>();

    // final DiscoverProviderAntiguo =
    //     Provider.of<DiscoverProvider>(context, listen: false);

    return Scaffold(
        body: discoverProvider.initialLoading
            ? const Center(
                child: CircularProgressIndicator(
                strokeWidth: 2,
              ))
            : VideoScrollableView(
                videos: discoverProvider.videos,
              ));
  }
}
