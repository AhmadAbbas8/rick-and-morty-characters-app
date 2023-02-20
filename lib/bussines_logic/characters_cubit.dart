import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/api/dio_helper.dart';
import '../data/models/characters_model.dart';
import 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit() : super(CharactersInitial());

  static CharactersCubit get(context) => BlocProvider.of(context);

   Character? character;

  bool isSearching = false;

  List<Results> allCharacters = [];
  List<Results> searchingCharacters = [];

  getAllCharacters() async {
    allCharacters.clear();
    emit(CharactersLoading());
    DioHelper.getAllCharacters().then((value) {
      character = Character.fromJson(value);
      allCharacters = character!.results!;
      print('***************${character!.results![1].name}');
      emit(CharactersLoadedSuccess());
    }).catchError((onError) {
      emit(CharactersLoadedError(onError.toString()));
      print(onError.toString());
    });


  
  }

  changeAppBarSearch() {
    isSearching = !isSearching;
    emit(CharacterschangeAppBarSearch());
  }

  void searchingInAllCharacter({required String txt}) {
    searchingCharacters = allCharacters
        .where((element) => element.name!.toLowerCase().contains(txt.toLowerCase()))
        .toList();
    emit(CharactersSearchInAllCharacter());
  }
}
