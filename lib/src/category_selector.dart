import 'package:design_system/design_system.dart';
import 'package:emoji_selector/src/category_icon.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

/// Category selector
class CategorySelector extends StatelessWidget {
  final bool selected;
  final CategoryIcon icon;
  final VoidCallback onSelected;

  const CategorySelector({
    Key? key,
    required this.selected,
    required this.icon,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 42,
      child: Button(
        child: Center(
          child: StyledIcon(icon.icon,
              style: Style(
                $icon.color(
                  selected
                      ? ColorVariant.onSurface.resolve(context)
                      : ColorVariant.onSurface.resolve(context).withOpacity(
                          OpacityVariant.hightlight.resolve(context).value),
                ),
              )),
        ),
        onPressed: onSelected,
      ),
    );
  }
}
