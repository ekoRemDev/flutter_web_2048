import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';
import 'package:flutter_web_2048/features/game/domain/entities/tile.dart';
import 'package:flutter_web_2048/features/game/domain/repositories/board_repository.dart';
import 'package:flutter_web_2048/features/game/domain/usecases/update_board.dart';
import 'package:mockito/mockito.dart';
import 'package:piecemeal/piecemeal.dart' as pm;
import 'package:flutter_web_2048/core/extensions/either_extensions.dart';

class MockBoardRepository extends Mock implements BoardRepository {}

void main() {
  UpdateBoard usecase;
  MockBoardRepository repository;

  setUp(() {
    repository = MockBoardRepository();
    usecase = UpdateBoard(boardRepository: repository);
  });

  test('should use the repository', () async {
    // ARRANGE
    var tiles = pm.Array2D<Tile>(4, 4);
    var board = Board(tiles);
    var direction = Direction.right;

    when(repository.updateBoard(board, direction)).thenAnswer((_) async => Board(tiles));

    // ACT
    await usecase(Params(board: board, direction: direction));

    // ASSERT
    verify(repository.updateBoard(board, direction)).called(1);
  });

  test('should return the repository output', () async {
    // ARRANGE
    var tiles = pm.Array2D<Tile>(4, 4);
    var board = Board(tiles);
    var direction = Direction.right;

    var repositoryOutput = Board(pm.Array2D<Tile>(4, 4));

    when(repository.updateBoard(board, direction)).thenAnswer((_) async => repositoryOutput);

    // ACT
    var actual = await usecase(Params(board: board, direction: direction));

    // ASSERT
    expect(actual.getRight(), repositoryOutput);
  });

  test('should throw when initialized with null argument', () async {
    // ACT & ASSERT
    expect(() => UpdateBoard(boardRepository: null), throwsA(isA<AssertionError>()));
  });

  group('Params', () {
    test('should extend Equatable', () {
      // ARRANGE
      var tiles = pm.Array2D<Tile>(4, 4);
      var board = Board(tiles);
      var direction = Direction.right;
      // ACT
      var params = Params(
        direction: direction,
        board: board,
      );
      // ASSERT
      expect(params, isA<Equatable>());
    });
    test('should have a props list with direction and board', () {
      // ARRANGE
      var tiles = pm.Array2D<Tile>(4, 4);
      var board = Board(tiles);
      var direction = Direction.right;

      var expected = <Object>[direction, board];

      // ACT
      var params = Params(
        direction: direction,
        board: board,
      );

      // ASSERT
      expect(params.props, expected);
    });
  });
}
