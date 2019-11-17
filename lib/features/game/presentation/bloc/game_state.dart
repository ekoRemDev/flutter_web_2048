import 'package:equatable/equatable.dart';

import '../../domain/entities/board.dart';

abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

class InitialGame extends GameState {}

class UpdateBoardStart extends GameState {}

class UpdateBoardEnd extends GameState {
  final Board board;

  UpdateBoardEnd(this.board);

  @override
  List<Object> get props => [board];
}

class GameOver extends GameState {
  final Board board;

  GameOver(this.board);

  @override
  List<Object> get props => [board];
}

class Error extends GameState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}
