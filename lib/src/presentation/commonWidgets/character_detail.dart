import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skilleos/src/domain/character_model.dart';
import 'package:flutter_skilleos/src/presentation/providers/characters_providers.dart';
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
              color: const Color.fromARGB(255, 255, 0, 0),
              gradient:
                  const LinearGradient(colors: [Colors.red, Colors.redAccent]),
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
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Badge(badgeColor: data.status.toColor()),
                        const SizedBox(width: 8),
                        Text("${data.status}-${data.species}",
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    RichText(
                        text: TextSpan(
                      children: <TextSpan>[
                        const TextSpan(text: 'Gender : '),
                        TextSpan(
                            text: data.gender,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    )),
                    RichText(
                        text: TextSpan(
                      children: <TextSpan>[
                        const TextSpan(text: 'Origin : '),
                        TextSpan(
                            text: data.origin,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    )),
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
