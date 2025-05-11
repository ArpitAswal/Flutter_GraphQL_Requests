import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_requets/blocs/riclk_morty_bloc/event.dart';
import 'package:graphql_requets/blocs/riclk_morty_bloc/state.dart';
import 'package:graphql_requets/infrastructures/auth_service.dart';
import 'package:graphql_requets/models/character_model.dart';

class RickMortyBloc extends Bloc<RickMortyEvent, RickMortyState> {
  final AuthService _authService =
      AuthService(); // This is the instance of AuthService

  RickMortyBloc() : super(FetchCharactersInitial()) {
    // Initial state
    on<FetchCharacters>(_onFetchCharacters); // event handler
  }

  Future<void> _onFetchCharacters(
    FetchCharacters event,
    Emitter<RickMortyState> emit,
  ) async {
    try {
      emit(FetchCharactersLoading());

      final List<dynamic> charactersData = await _authService
          .getCharacter(); // Fetch characters from AuthService

      final List<CharacterModel> characters = charactersData
          .map((characterData) => CharacterModel.fromJson(characterData))
          .toList(); // Convert to CharacterModel

      emit(FetchCharactersSuccess(characters));
    } catch (e) {
      emit(FetchCharactersError(e.toString()));
    }
  }
}
