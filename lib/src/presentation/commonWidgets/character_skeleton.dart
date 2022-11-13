import 'package:flutter/material.dart';

class CharacterSkeleton extends StatelessWidget {
  const CharacterSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        height: 150.0,
      ),
    );
  }
}
