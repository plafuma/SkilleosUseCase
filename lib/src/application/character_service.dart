import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skilleos/src/data/character_repository.dart';
import 'package:flutter_skilleos/src/domain/character_model.dart';
import 'package:flutter_skilleos/src/utils/enum_character_sort_order.dart';

class CharacterService {
  CharacterService({required this.characterRepository});

  final CharacterRepository characterRepository;

  Future<List<CharacterModel>> getCharacters(
      CharacterSortOrder characterSortOrder) async {
    var remoteCharacters = await characterRepository.getRemoteCharacters();
    var localFavoritesCharacters =
        await characterRepository.getLocalFavoritesCharacters();
    for (CharacterModel character in localFavoritesCharacters) {
      remoteCharacters
          .where((element) => element.id == character.id)
          .first
          .isFavorite = true;
    }
    remoteCharacters.sort((a, b) {
      if (characterSortOrder == CharacterSortOrder.ascendingNameOrder) {
        return b.name.toLowerCase().compareTo(a.name.toLowerCase());
      } else {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      }
    });

    return (remoteCharacters);
  }

  Future<void> saveFavoritesCharacters(
      List<CharacterModel> characterList) async {
    await characterRepository.saveFavoritesCharacters(characterList);
  }
}

final characterServiceProvider =
    Provider<CharacterService>((ref) => CharacterService(
          characterRepository: ref.watch(characterRepositoryProvider),
        ));
