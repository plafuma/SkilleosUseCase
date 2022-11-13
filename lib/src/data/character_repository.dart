import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skilleos/src/domain/character_model.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CharacterRepository {
  Future<List<CharacterModel>> getRemoteCharacters();
  Future<List<CharacterModel>> getLocalFavoritesCharacters();
  Future<void> saveFavoritesCharacters(
      List<CharacterModel> favoritesCharacterList);
}

String endpoint = 'https://rickandmortyapi.com/api/character';
const _charactersKey = 'charactersKey';

class CharacterRepositoryImpl implements CharacterRepository {
  CharacterRepositoryImpl();

  @override
  Future<List<CharacterModel>> getRemoteCharacters() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['results'];
      List<CharacterModel> sortedList =
          result.map(((e) => CharacterModel.fromJson(e))).toList();
      sortedList.sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
      return (sortedList);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  @override
  Future<List<CharacterModel>> getLocalFavoritesCharacters() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> characterList =
        List<Map<String, dynamic>>.from(
            jsonDecode(prefs.getString(_charactersKey) ?? '[]'));
    return characterList.map((json) => CharacterModel.fromMap(json)).toList();
  }

  @override
  Future<void> saveFavoritesCharacters(
      List<CharacterModel> characterList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _charactersKey,
        jsonEncode(
            characterList.map((character) => character.toMap()).toList()));
  }
}

final characterRepositoryProvider =
    Provider<CharacterRepository>((ref) => CharacterRepositoryImpl());
