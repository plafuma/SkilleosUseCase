import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skilleos/src/application/character_service.dart';
import 'package:flutter_skilleos/src/domain/character_model.dart';

class HomeScreenController
    extends StateNotifier<AsyncValue<List<CharacterModel>>> {
  HomeScreenController({required this.characterService})
      : super(const AsyncLoading()) {
    getCharacters();
  }

  final CharacterService characterService;

  void getCharacters() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => characterService.getCharacters());
  }

  void sortCharacter(bool isReversed) async {
    List<CharacterModel>? characters = state.value;
    characters?.sort((a, b) {
      if (!isReversed) {
        return b.name.toLowerCase().compareTo(a.name.toLowerCase());
      } else {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      }
    });
    state = AsyncData((characters!));
  }

  void toggleFavorite(int id, bool isFavorite) {
    List<CharacterModel>? newlist = state.value?.map(
      (character) {
        if (character.id == id) {
          return character.copyWith(isFavorite: !isFavorite);
        } else {
          return character;
        }
      },
    ).toList();

    characterService.saveFavoritesCharacters(
        newlist!.where((character) => character.isFavorite).toList());

    state = AsyncData(newlist);
  }
}

final charactersProvider = StateNotifierProvider<HomeScreenController,
    AsyncValue<List<CharacterModel>>>((ref) {
  CharacterService characterService = ref.read(apiProvider);
  return HomeScreenController(characterService: characterService);
});

final favoritesCharactersProvider = FutureProvider((ref) async {
  final characters = ref.watch(charactersProvider);

  List<CharacterModel> favoritesList = <CharacterModel>[];
  if (characters.hasValue) {
    favoritesList =
        characters.value!.where((character) => character.isFavorite).toList();
  }

  return favoritesList;
});
