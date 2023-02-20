import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:rick_and_morty/bussines_logic/characters_cubit.dart';
import 'package:rick_and_morty/bussines_logic/characters_state.dart';
import 'package:rick_and_morty/constatns/mycolors.dart';
import 'package:rick_and_morty/prsentation/screens/characters_det.dart';
import '../../data/models/characters_model.dart';

class CharactersScreen extends StatelessWidget {
  CharactersScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharactersCubit()..getAllCharacters,
      child: BlocConsumer<CharactersCubit, CharactersState>(
        listener: (context, state) {},
        builder: (context, state) {
          bool isSearching = CharactersCubit.get(context).isSearching;
          List<Results> allCharacters =
              CharactersCubit.get(context).allCharacters;
          List<Results> searchedForCharacter =
              CharactersCubit.get(context).searchingCharacters;
          return Scaffold(
            backgroundColor: MyColors.myGrey,
            appBar: AppBar(
              backgroundColor: MyColors.myYellow,
              leading: leadingAppBar(isSearching, context),
              actions: actionsAppBar(isSearching, context),
              title: titleappBar(isSearching, context),
            ),
            body: OfflineBuilder(
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),
              ),
              connectivityBuilder: (
                BuildContext context,
                ConnectivityResult connectivity,
                Widget child,
              ) {
                final bool connected = connectivity != ConnectivityResult.none;
                if (connected) {
                  return ConditionalBuilder(
                    builder: (context) => SingleChildScrollView(
                      child: Container(
                        color: MyColors.myGrey,
                        child: Column(
                          children: [
                            GridView.builder(
                              itemCount: searchController.text.isNotEmpty
                                  ? searchedForCharacter.length
                                  : allCharacters.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2 / 3,
                                crossAxisSpacing: 3,
                                mainAxisSpacing: 3,
                              ),
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) => Container(
                                width: double.infinity,
                                margin: const EdgeInsetsDirectional.fromSTEB(
                                    5, 4, 3, 3),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: MyColors.mtWhite,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CharactersDetScreen(
                                        character: isSearching
                                            ? searchedForCharacter[index]
                                            : allCharacters[index],
                                      ),
                                    ),
                                  ),
                                  child: GridTile(
                                    child: Hero(
                                      tag: allCharacters[index].id!,
                                      child: Container(
                                        color: MyColors.myGrey,
                                        child: allCharacters[index]
                                                .image!
                                                .isNotEmpty
                                            ? FadeInImage.assetNetwork(
                                                placeholder:
                                                    'assets/images/2.gif',
                                                image:
                                                    searchController
                                                            .text.isNotEmpty
                                                        ? searchedForCharacter[
                                                                index]
                                                            .image!
                                                        : allCharacters[index]
                                                            .image!,
                                                width: double.infinity,
                                                height: double.infinity,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                'assets/images/3.png'),
                                      ),
                                    ),
                                    footer: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 10,
                                      ),
                                      color: Colors.black54,
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        searchController.text.isNotEmpty
                                            ? searchedForCharacter[index].name!
                                            : allCharacters[index].name!,
                                        style: const TextStyle(
                                          height: 1.3,
                                          fontSize: 16,
                                          color: MyColors.mtWhite,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    header: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 10,
                                      ),
                                      color: Colors.black54.withOpacity(.54),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        searchController.text.isNotEmpty
                                            ? searchedForCharacter[index]
                                                .status!
                                            : allCharacters[index].status!,
                                        style:
                                            const TextStyle(color: MyColors.mtWhite),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    fallback: (context) => const Center(
                      child: CircularProgressIndicator(
                        color: MyColors.myYellow,
                      ),
                    ),
                    condition:
                        CharactersCubit.get(context).allCharacters.isNotEmpty,
                  );
                } else {
                  return Center(
                    child: Container(
                      color: MyColors.mtWhite,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            'Cannot Connect ... check your connectivity',
                            style: TextStyle(
                              fontSize: 15,
                              color: MyColors.myGrey,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Image.asset('assets/images/4.png')
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget titleappBar(bool isSearching, BuildContext context) {
    return isSearching
        ? TextFormField(
            controller: searchController,
            cursorColor: MyColors.myGrey,
            decoration: const InputDecoration(
              hintText: 'Find a character',
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: MyColors.myGrey,
                fontSize: 18,
              ),
            ),
            style: const TextStyle(
              color: MyColors.myGrey,
              fontSize: 18,
            ),
            onChanged: (searched) {
              CharactersCubit.get(context)
                  .searchingInAllCharacter(txt: searched);
              // print(CharactersCubit.get(context).searchingCharacters[0].name);
            },
          )
        : const Text(
            'Characters',
            style: TextStyle(
              color: MyColors.myGrey,
            ),
          );
  }

  Widget? leadingAppBar(bool isSearching, BuildContext context) {
    return isSearching
        ? BackButton(
            color: MyColors.myGrey,
            onPressed: () {
              CharactersCubit.get(context).changeAppBarSearch();
              searchController.clear();
            },
          )
        : null;
  }

  List<Widget> actionsAppBar(bool isSearching, BuildContext context) {
    return (isSearching)
        ? [
            IconButton(
              onPressed: () {
                CharactersCubit.get(context).changeAppBarSearch();
                searchController.clear();
              },
              icon: const Icon(
                Icons.clear,
                color: MyColors.myGrey,
              ),
            )
          ]
        : [
            IconButton(
                onPressed: () {
                  CharactersCubit.get(context).changeAppBarSearch();
                  searchController.clear();
                },
                icon: const Icon(
                  Icons.search,
                  color: MyColors.myGrey,
                ))
          ];
  }
}
