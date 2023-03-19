part of 'decks_bloc.dart';

abstract class DecksEvent extends Equatable {
  const DecksEvent(this.decks);

  final List<Deck> decks;

  @override
  List<Object> get props => [];
}

class DecksChanged extends DecksEvent {
  const DecksChanged(this.decks) : super(decks);

  @override
  final List<Deck> decks;

  @override
  List<Object> get props => [decks];
}
