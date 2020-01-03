import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/enums/direction.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/board.dart';
import '../repositories/board_repository.dart';

class UpdateBoard implements UseCase<Board, Params> {
  final BoardRepository boardRepository;

  UpdateBoard({@required this.boardRepository}) : assert(boardRepository != null);

  @override
  Future<Either<Failure, Board>> call(Params params) async {
    return Right(await boardRepository.updateBoard(params.board, params.direction));
  }
}

class Params extends Equatable {
  final Direction direction;
  final Board board;

  Params({
    @required this.direction,
    @required this.board,
  });

  @override
  List<Object> get props => [direction, board];
}
