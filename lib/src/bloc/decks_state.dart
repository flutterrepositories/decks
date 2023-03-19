part of 'decks_bloc.dart';

class DecksState extends Equatable {
  DecksState(this.decks);

  final List<Deck> decks;

  @override
  List<Object> get props => [decks];
}
