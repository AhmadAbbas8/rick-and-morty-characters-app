
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}
class CharactersLoadedSuccess extends CharactersState {}
class CharactersLoadedError extends CharactersState {
  final String error ;

  CharactersLoadedError(this.error);

}
class CharactersLoading extends CharactersState {}

class CharacterschangeAppBarSearch extends CharactersState {}
class CharactersSearchInAllCharacter extends CharactersState {}


