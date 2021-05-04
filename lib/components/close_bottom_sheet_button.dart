import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/styles/colors.dart';

class CloseBottomSheetButton extends StatelessWidget {
  void _onCloseTap(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => _onCloseTap(context),
        child: Row(
          children: [
            Icon(
              FeatherIcons.x,
              size: 30,
              color: TheoColors.primary,
            ),
            Text(
              'Cancelar',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 14,
                    color: TheoColors.primary,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
