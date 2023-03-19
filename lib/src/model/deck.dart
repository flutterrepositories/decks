import 'package:cloud_firestore/cloud_firestore.dart';

class Deck {
  String name;
  DateTime startDate;
  DateTime endDate;
  String deckId;
  String icon;
  String description;
  bool enabled;

  Deck(
      {required this.name,
      required this.startDate,
      required this.endDate,
      required this.deckId,
      required this.icon,
      required this.description,
      required this.enabled});
}

extension DeckEntityParser on Deck {
  static Deck fromSnapshot(DocumentSnapshot snap) {
    var d = snap.data() as Map<String, dynamic>;
    var b = d['enabled'] as bool;
    return Deck(
        deckId: snap.id,
        name: d['name'],
        startDate: d['startDate'].toDate(),
        endDate: d['endDate'].toDate(),
        icon: d['icon'],
        description: d['description'] ?? '',
        enabled: b);
  }
}
