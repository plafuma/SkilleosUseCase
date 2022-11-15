import 'package:badges/badges.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skilleos/src/domain/character_model.dart';
import 'package:flutter_skilleos/src/presentation/commonWidgets/text_double_grey.dart';
import 'package:flutter_skilleos/src/presentation/providers/characters_providers.dart';
import 'package:flutter_skilleos/src/utils/color_constants.dart';
import 'package:flutter_skilleos/src/utils/status_to_color.dart';

class CharacterDetail extends ConsumerWidget {
  const CharacterDetail({Key? key, required this.data}) : super(key: key);

  final CharacterModel data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
        child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorConstants.lightGrey,
            ),
            height: 165.0,
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(data.image),
                  backgroundColor: Colors.white,
                  radius: 48.0,
                ),
                const SizedBox(width: 16),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: TextStyle(
                          fontSize: 14,
                          color: ColorConstants.redSkilleos,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Badge(badgeColor: data.status.toColor()),
                        const SizedBox(width: 8),
                        Text("${data.status}-${data.species}",
                            style: TextStyle(color: ColorConstants.darkGrey)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextDoubleGrey(
                        firstValue:
                            AppLocalizations.of(context).characterDetailGender,
                        secondValue: data.gender),
                    TextDoubleGrey(
                        firstValue:
                            AppLocalizations.of(context).characterDetailOrigin,
                        secondValue: data.origin),
                  ],
                )),
                GestureDetector(
                  onTap: () {
                    ref
                        .read(charactersProvider.notifier)
                        .toggleFavorite(data.id, data.isFavorite);
                  },
                  child: Icon(
                    data.isFavorite ? Icons.favorite : Icons.favorite_outline,
                    size: 26.0,
                  ),
                )
              ],
            )));
  }
}
