import 'package:decks/src/bloc/decks_bloc.dart';
import 'package:decks/src/model/deck.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui/ui.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DeckListView extends StatelessWidget {
  Function(String) onDeckOpening;
  DeckListView({required this.onDeckOpening});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DecksBloc, DecksState>(builder: (_, state) {
      return view(state.decks);
    });
  }

  Widget view(List<Deck> list) {
    list.sort((a, b) => a.startDate.compareTo(b.startDate) > 0 ? -1 : 1);
    if (list.length == 0) {
      return Center(
        child: Text('No decks'),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        var icon = list[index].icon.endsWith('.svg')
            ? SvgPicture.network(list[index].icon)
            : Image.network(list[index].icon);
        return CardStack(
          color: list[index].enabled ? Colors.white : Colors.grey.shade200,
          content: Row(children: [
            SizedBox(width: 100, height: 100, child: icon),
            SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(list[index].name,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                  DateFormat('dd/MM/yyyy').format(list[index].startDate) +
                      ' - ' +
                      DateFormat('dd/MM/yyyy').format(list[index].endDate),
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                list[index].description.isNotEmpty
                    ? Column(
                        children: [
                          SizedBox(height: 8),
                          Text(list[index].description,
                              style: TextStyle(fontSize: 16))
                        ],
                      )
                    : Container(),
              ],
            ),
          ]),
          onTap: () {
            if (list[index].enabled == false) {
              return;
            }
            onDeckOpening(list[index].deckId);
          },
        );
      },
    );
  }
}
