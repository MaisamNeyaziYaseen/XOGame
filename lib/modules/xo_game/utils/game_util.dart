class GameUtil {
  static const user = 1;
  static const computer = -1;

  static const draw = 2;
  static const noWinnerYet = 0;
  static const empty = 0;

  static const winScore = 100;
  static const loseScore = -100;
  static const drawScore = 0;

  static const winPatternsList = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  static int togglePlayer(int currentPlayer) {
    return -1 * currentPlayer;
  }

  static bool isValidMove(List<int> board, int idx) => board[idx] == empty;

  static int checkIfWinnerFound(List<int> board) {
    for (var list in winPatternsList) {
      if (board[list[0]] != empty &&
          board[list[0]] == board[list[1]] &&
          board[list[0]] == board[list[2]]) {
        return board[list[0]];
      }
    }
    if (isBoardFull(board)) {
      return draw;
    }
    return noWinnerYet;
  }

  static bool isBoardFull(List<int> board) {
    for (var value in board) {
      if (value == empty) return false;
    }
    return true;
  }

  /////////////////////////////////////////////////////////////

  int play(List<int> board, int currentPlayer) {
    return _getAIMove(board, currentPlayer).index;
  }

  Move _getAIMove(List<int> board, int currentPlayer) {
    List<int> newBoard;
    Move bestMove = Move(score: -10000, index: -1);

    for (int currentMove = 0; currentMove < board.length; currentMove++) {
      if (!isValidMove(board, currentMove)) continue;
      newBoard = List.from(board);
      newBoard[currentMove] = currentPlayer;
      int newScore = -_getBestScore(
        newBoard,
        togglePlayer(currentPlayer),
      );
      if (newScore > bestMove.score) {
        bestMove.score = newScore;
        bestMove.index = currentMove;
      }
    }

    return bestMove;
  }

  int _getBestScore(List<int> board, int currentPlayer) {
    final winner = checkIfWinnerFound(board);
    if (winner == currentPlayer) {
      return winScore;
    } else if (winner == togglePlayer(currentPlayer)) {
      return loseScore;
    } else if (winner == draw) {
      return drawScore;
    }
    return _getAIMove(board, currentPlayer).score;
  }
}

class Move {
  int score;
  int index;

  Move({
    required this.score,
    required this.index,
  });
}
