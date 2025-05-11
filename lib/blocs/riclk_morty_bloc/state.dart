import 'package:equatable/equatable.dart';

import '../../models/character_model.dart';

abstract class RickMortyState extends Equatable {
  const RickMortyState();

  @override
  List<Object?> get props => [];
}

class FetchCharactersInitial extends RickMortyState {}

class FetchCharactersLoading extends RickMortyState {}

class FetchCharactersSuccess extends RickMortyState {
  const FetchCharactersSuccess(this.characters);

  final List<CharacterModel> characters;
  @override
  List<Object?> get props => [characters];
}

class FetchCharactersError extends RickMortyState {
  const FetchCharactersError(this.message);

  final String message;
  @override
  List<Object?> get props => [message];
}
