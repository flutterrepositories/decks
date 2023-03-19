import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decks/src/model/deck.dart';
import 'package:rxdart/rxdart.dart';

class DeckRepository {
  final _decks = FirebaseFirestore.instance.collection('decks');
  final _controller = BehaviorSubject<List<Deck>>();
  DeckRepository();
  List<Deck> current = [];
  var _subscription;

  Stream<List<Deck>> get currentDecks async* {
    _subscription = _decks.snapshots().listen((event) {
      event.docs.forEach((doc) async {
        var entity = await DeckEntityParser.fromSnapshot(doc);
        current.add(entity);
        _controller.add(current);
      });
    });

    yield* _controller.stream;
  }

  void dispose() {
    _subscription.cancel();
    _controller.close();
  }
}
