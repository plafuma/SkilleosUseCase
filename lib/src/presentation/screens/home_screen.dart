import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skilleos/src/presentation/commonWidgets/character_detail.dart';
import 'package:flutter_skilleos/src/presentation/providers/characters_providers.dart';
import 'package:flutter_skilleos/src/utils/color_constants.dart';
import '../commonWidgets/list_shimmer.dart';
import '../providers/bottom_navigation_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(charactersProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appTitle,
            style: TextStyle(color: ColorConstants.redSkilleos)),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  ref
                      .read(charactersProvider.notifier)
                      .sortCharacter(ref.read(isReversedProvider));
                  ref.read(isReversedProvider.notifier).state =
                      !ref.read(isReversedProvider);
                },
                child: Icon(
                  ref.watch(isReversedProvider)
                      ? Icons.text_rotate_up
                      : Icons.text_rotation_down,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(charactersProvider);
                ref.invalidate(isReversedProvider);
              },
              child: data.when(
                  data: (characterData) => ListView.builder(
                        itemCount: characterData.length,
                        itemBuilder: (_, index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, top: 20.0, right: 30.0, bottom: 0.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CharacterDetail(data: characterData[index])
                            ],
                          ),
                        ),
                      ),
                  loading: () => const ListShimmer(),
                  error: (e, __) => Center(
                          child: Column(
                        children: <Widget>[
                          Text(
                              "An error occured, try again : Error message : $e"),
                          GestureDetector(
                              onTap: () {
                                ref.invalidate(charactersProvider);
                                ref.read(charactersProvider);
                              },
                              child: const Icon(
                                Icons.refresh,
                                size: 26.0,
                              ))
                        ],
                      ))),
            ))
          ],
        ),
      ),
    );
  }
}
