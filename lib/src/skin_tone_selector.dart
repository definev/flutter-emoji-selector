import 'package:design_system/design_system.dart';
import 'package:emoji_selector/src/skin_dot.dart';
import 'package:emoji_selector/src/skin_tones.dart';
import 'package:flutter/material.dart';
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
  late OverlayEntry _overlayEntry;
  bool _expanded = false;
  FocusNode focusNode = FocusNode();

  OverlayEntry createOverlay(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    final width =
        size.height * SkinTones.tones.length + SkinTones.tones.length + 1;
    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx - width + size.width,
        top: offset.dy - size.height,
        height: size.height,
        width: width,
        child: FocusableActionDetector(
          focusNode: focusNode,
          onShowFocusHighlight: (value) =>
              value ? null : _overlayEntry.remove(),
          child: DSToolbar(
            direction: Axis.horizontal,
            children: [
              for (var skin = 0; skin < SkinTones.tones.length; skin++)
                DSToolbarItem(
                  style: Style(
                    $box.height(size.height),
                    $box.width(size.height),
                  ),
                  onPressed: () {
                    _overlayEntry.remove();
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_overlayEntry.mounted) _overlayEntry.remove();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SkinDotButton(
      skin: _skin,
      onPressed: () {
        if (_expanded) {
          _overlayEntry.remove();
        } else {
          _overlayEntry = createOverlay(context);
          Overlay.of(context).insert(_overlayEntry);
        }
        setState(() {
          _expanded = !_expanded;
        });
      },
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
        $box.height(42),
        $box.width(42),
      ),
      onPressed: onPressed,
      child: SkinDot(skin: skin),
    );
  }
}
