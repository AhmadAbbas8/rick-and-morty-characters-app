import 'package:flutter/material.dart';
import 'package:rick_and_morty/constatns/mycolors.dart';
import 'package:rick_and_morty/data/models/characters_model.dart';

class CharactersDetScreen extends StatelessWidget {
  CharactersDetScreen({Key? key, required this.character}) : super(key: key);
  Results character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 600,
            pinned: true,
            stretch: true,
            backgroundColor: MyColors.myGrey,
            flexibleSpace: FlexibleSpaceBar(
              // centerTitle: true,
              title: Container(
                color: MyColors.myGrey,
                child: Text(
                  character.name!,
                  style: const TextStyle(
                    color: MyColors.mtWhite,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              background: Hero(
                tag: character.id!,
                child: Image.network(
                  character.image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildCharacterInfo(
                          title: 'Origin name : ',
                          value: character.origin!.name!),
                      buildMyDivider(270),
                      buildCharacterInfo(
                          title: 'status : ', value: character.status!),
                      buildMyDivider(314),
                      buildCharacterInfo(
                          title: 'species : ', value: character.species!),
                      buildMyDivider(302),
                      buildCharacterInfo(
                          title: 'gender : ', value: character.gender!),
                      buildMyDivider(310),
                      buildCharacterInfo(
                          title: 'episodes : ',
                          value: character.episode!.length.toString()),
                      buildMyDivider(292),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                const SizedBox(height: 500),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCharacterInfo({required String title, required String value}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyColors.mtWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: MyColors.mtWhite,
              fontSize: 15,
            ),
          ),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildMyDivider(double endIndent) {
    return Divider(
      color: MyColors.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }
}
