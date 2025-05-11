import 'package:equatable/equatable.dart';

abstract class RickMortyEvent extends Equatable {
  const RickMortyEvent();

  @override
  List<Object> get props => []; // Default implementation
}

class FetchCharacters extends RickMortyEvent {}
