import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skilleos/src/data/character_repository.dart';
import '../domain/character_model.dart';

class CharacterService {
  CharacterService({required this.characterRepository});

  final CharacterRepository characterRepository;

  Future<List<CharacterModel>> getCharacters() async {
    var remoteCharacters = await characterRepository.getRemoteCharacters();
    var localFavoritesCharacters =
        await characterRepository.getLocalFavoritesCharacters();
    for (CharacterModel character in localFavoritesCharacters) {
      remoteCharacters
          .where((element) => element.id == character.id)
          .first
          .isFavorite = true;
    }
    return (remoteCharacters);
  }

  Future<void> saveFavoritesCharacters(
      List<CharacterModel> characterList) async {
    await characterRepository.saveFavoritesCharacters(characterList);
  }
}

final apiProvider = Provider<CharacterService>((ref) => CharacterService(
      characterRepository: ref.watch(characterRepositoryProvider),
    ));
