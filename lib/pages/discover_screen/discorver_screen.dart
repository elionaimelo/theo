import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  void _onSearchTap() {
    Navigator.of(context).pushNamed(Routes.search);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: TheoMetrics.paddingScreen,
      child: ListView(
        children: [
          BottomButton(
            text: 'Pesquisar',
            borderColor: TheoColors.primary,
            backgroundColor: TheoColors.secondary,
            primaryColor: TheoColors.primary,
            icon: FeatherIcons.filter,
            textDirection: TextDirection.rtl,
            onPressed: _onSearchTap,
          )
        ],
      ),
    );
  }
}
