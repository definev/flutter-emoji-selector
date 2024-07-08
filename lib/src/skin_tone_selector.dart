import 'package:design_system/design_system.dart';
import 'package:emoji_selector/src/skin_dot.dart';
import 'package:emoji_selector/src/skin_tones.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:mix/mix.dart';

class SkinToneSelector extends StatefulWidget {
  final Function(int) onSkinChanged;

  const SkinToneSelector({
    Key? key,
    required this.onSkinChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SkinToneState();
}

class _SkinToneState extends State<SkinToneSelector> {
  int _skin = 0;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return PortalTarget(
      visible: _expanded,
      anchor: Aligned(
        follower: Alignment.bottomRight,
        target: Alignment.topRight,
      ),
      portalFollower: SizedBox(
        height: 32,
        width:
            32 * SkinTones.tones.length + SkinTones.tones.length + 1,
        child: DSToolbar(
          direction: Axis.horizontal,
          children: [
            for (var skin = 0; skin < SkinTones.tones.length; skin++)
              DSToolbarItem(
                style: Style(
                  $box.height(32),
                  $box.width(32),
                ),
                onPressed: () {
                  setState(() {
                    _skin = skin;
                    widget.onSkinChanged(skin);
                    _expanded = false;
                  });
                },
                child: SkinDot(skin: skin),
              ),
          ],
        ),
      ),
      child: SkinDotButton(
        skin: _skin,
        onPressed: () {
          setState(() => _expanded = !_expanded);
        },
      ),
    );
  }
}

class SkinDotButton extends StatelessWidget {
  final int? skin;
  final Function()? onPressed;

  const SkinDotButton({Key? key, this.skin, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      style: Style(
        $box.height(32),
        $box.width(32),
      ),
      onPressed: onPressed,
      child: SkinDot(skin: skin),
    );
  }
}
