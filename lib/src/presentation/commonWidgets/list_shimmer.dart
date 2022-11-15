import 'package:flutter/material.dart';
import 'package:flutter_skilleos/src/presentation/commonWidgets/character_skeleton.dart';
import 'package:shimmer/shimmer.dart';

class ListShimmer extends StatelessWidget {
  const ListShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 232, 232, 232),
      highlightColor: Colors.white70,
      enabled: true,
      child: ListView.builder(
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(
              left: 30.0, top: 20.0, right: 30.0, bottom: 0.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[CharacterSkeleton()],
          ),
        ),
        itemCount: 6,
      ),
    );
  }
}
