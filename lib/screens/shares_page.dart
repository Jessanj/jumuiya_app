import 'package:flutter/material.dart';

import '../util/app_colors.dart';

class SharesPage extends StatefulWidget {
  const SharesPage({Key? key}) : super(key: key);

  @override
  State<SharesPage> createState() => _SharesPageState();
}

class _SharesPageState extends State<SharesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
      ),
      body: Center(
        child: Text('SHARES'),
      ) ,
    );
  }
}
