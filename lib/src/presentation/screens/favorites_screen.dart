import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skilleos/src/presentation/commonWidgets/character_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_skilleos/src/presentation/commonWidgets/list_shimmer.dart';
import 'package:flutter_skilleos/src/presentation/providers/characters_providers.dart';
import 'package:flutter_skilleos/src/utils/color_constants.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(favoritesCharactersProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).favoritesPageTabTitle,
          style: TextStyle(color: ColorConstants.redSkilleos),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child: data.when(
              data: (characterData) => characterData.isEmpty
                  ? Center(
                      child: Text(AppLocalizations.of(context).emptyFavorites))
                  : ListView.builder(
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
              error: (e, __) => Text(e.toString()),
            )),
          ],
        ),
      ),
    );
  }
}
