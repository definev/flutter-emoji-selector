import 'package:emoji_selector/src/emoji_internal_data.dart';
import 'package:flutter/material.dart';

class EmojiPage extends StatelessWidget {
  final int rows;
  final int columns;
  final int skin;
  final List<EmojiInternalData> emojis;
  final Function(EmojiInternalData) onSelected;
  final TextStyle emojiTextStyle;

  const EmojiPage({
    Key? key,
    required this.rows,
    required this.columns,
    required this.skin,
    required this.emojis,
    required this.emojiTextStyle,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        padding: EdgeInsets.zero,
        crossAxisCount: columns,
        children: List.generate(
          rows * columns,
          (index) {
            if (index >= emojis.length) return SizedBox();
            var emoji = emojis[index];
            return Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(0.0),
                ),
                child: Center(
                  child: Text(
                    emoji.charForSkin(skin),
                    style: emojiTextStyle,
                  ),
                ),
                onPressed: () {
                  onSelected(emoji);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
