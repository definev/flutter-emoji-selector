import 'package:emoji_selector/src/skin_tones.dart';
import 'package:flutter/material.dart';

class SkinDot extends StatelessWidget {
  final int? skin;

  const SkinDot({Key? key, this.skin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 14,
      height: 14,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: SkinTones.tones[skin!],
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
