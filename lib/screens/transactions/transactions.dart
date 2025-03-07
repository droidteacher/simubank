import 'package:flutter/material.dart';
import 'package:mt_assignment/data/remote/user_datasource.dart';
import 'package:mt_assignment/widgets/footer.dart';
import 'package:mt_assignment/widgets/screen_title.dart';

class Transactions extends StatelessWidget {
  final SBUser loggedInUser;

  const Transactions({super.key, required this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6),
      body: Stack(
        children: [
          const Positioned(
              top: 80,
              left: 40,
              right: 40,
              child: ScreenTitle(title: 'Transactions')),
          Positioned(
            top: 400,
            left: 40,
            right: 40,
            child: Text('User logged in with ID : ${loggedInUser.id}', style: Theme.of(context).textTheme.titleLarge,),
          ),
          const Positioned(bottom: 16.0, left: 32, right: 32, child: Footer())
        ],
      ),
    );
  }
}
