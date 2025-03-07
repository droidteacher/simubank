import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  final bool centered;
  const ScreenTitle({super.key, required this.title, this.centered = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          centered ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: const Color(0xff2563eb), fontSize: 48),
        ),
      ],
    );
  }
}