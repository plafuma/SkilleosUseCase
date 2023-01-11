import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skilleos/src/application/character_service.dart';
import 'package:flutter_skilleos/src/domain/character_model.dart';
import 'package:flutter_skilleos/src/utils/enum_character_sort_order.dart';

class HomeScreenController
    extends StateNotifier<AsyncValue<List<CharacterModel>>> {
  HomeScreenController(
      {required this.characterService, required this.characterSortOrder})
      : super(const AsyncLoading()) {
    getCharacters();
  }

  final CharacterService characterService;
  final CharacterSortOrder characterSortOrder;

  void getCharacters() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => characterService.getCharacters(characterSortOrder));
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
  final characterSortOrder = ref.watch(characterSortOrderProvider);
  CharacterService characterService = ref.read(characterServiceProvider);
  return HomeScreenController(
      characterService: characterService,
      characterSortOrder: characterSortOrder);
});

final favoritesCharactersProvider = StateProvider((ref) {
  final characters = ref.watch(charactersProvider);

  List<CharacterModel> favoritesList = <CharacterModel>[];
  if (characters.hasValue) {
    favoritesList =
        characters.value!.where((character) => character.isFavorite).toList();
  }

  return favoritesList;
});

final characterSortOrderProvider = StateProvider<CharacterSortOrder>(
    (ref) => CharacterSortOrder.ascendingNameOrder);
