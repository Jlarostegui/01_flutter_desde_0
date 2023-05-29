import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:toktik/config/helpers/human_formats.dart';
import 'package:toktik/domain/entities/video_post.dart';

class VideoButtons extends StatelessWidget {
  const VideoButtons({super.key, required this.video});

  final VideoPost video;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CustonIconButton(
          value: video.likes,
          icondata: Icons.favorite,
        ),
        const SizedBox(
          height: 20,
        ),
        _CustonIconButton(
          value: video.views,
          icondata: Icons.remove_red_eye,
        ),
        const SizedBox(
          height: 20,
        ),
        SpinPerfect(
          infinite: true,
          duration: const Duration(seconds: 5),
          child: const _CustonIconButton(
            value: 0,
            icondata: Icons.play_circle_fill_outlined,
          ),
        ),
      ],
    );
  }
}

class _CustonIconButton extends StatelessWidget {
  const _CustonIconButton(
      {required this.value, required this.icondata, iconColor})
      : color = iconColor ?? Colors.white;

  final int value;
  final IconData icondata;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            icondata,
            color: color,
            size: 30,
          ),
        ),
        if (value > 0)
          Text(
            HumanFormats.humanReadbleNumber(value.toDouble()),
          ),
      ],
    );
  }
}
