import 'package:flutter/material.dart';
import 'package:theo/utils/assets_path.dart';

class LoadingStatus extends StatelessWidget {
  const LoadingStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: AssetImage(AssetsPath.spinnerGif),
      ),
    );
  }
}
