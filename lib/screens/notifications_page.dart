import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/app_colors.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.navyBlue,
            title: const Text('Next page'),
          ),
          body: const Center(
            child: Text(
              'This is the next page',
              style: TextStyle(fontSize: 24),
            ),
          ),
        );

  }
}
