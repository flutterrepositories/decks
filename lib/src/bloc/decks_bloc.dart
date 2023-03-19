import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:decks/src/model/deck.dart';
import 'package:decks/src/repository/deck_repository.dart';
import 'package:equatable/equatable.dart';

part 'decks_event.dart';
part 'decks_state.dart';

class DecksBloc extends Bloc<DecksEvent, DecksState> {
  DecksBloc() : super(DecksState([])) {
    on<DecksChanged>(_onDecksChanged);

    _subscription = _repository.currentDecks.listen((decks) {
      add(DecksChanged(decks));
    });
  }

  late final DeckRepository _repository = DeckRepository();
  late StreamSubscription<List<Deck>> _subscription;

  @override
  Future<void> close() {
    _subscription.cancel();
    _repository.dispose();
    return super.close();
  }

  FutureOr<void> _onDecksChanged(DecksChanged event, Emitter<DecksState> emit) {
    emit(DecksState(event.decks));
  }
}
