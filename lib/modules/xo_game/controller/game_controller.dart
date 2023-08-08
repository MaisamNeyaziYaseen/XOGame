import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task4/modules/xo_game/utils/game_util.dart';

ChangeNotifierProvider<GameController> gameProvider =
    ChangeNotifierProvider<GameController>((ref) => GameController());

class GameController extends ChangeNotifier {
  String _userSymbol = "X";
  bool _isXSelected = false;
  bool _isOSelected = false;

  int _currentPlayer = 1;
  final List<List<int>> _winPatternsList = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];
  List<int> _board = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> _userMovesIndesies = [];
  int _movesCounter = 0;
  GameState _gameState = GameState.winnerNotFound;

  void addUserMove(int index) {
    _userMovesIndesies.add(index);
    //notifyListeners
  }

  int togglePlayer(int currentPlayer) {
    return -1 * currentPlayer;
  }

  void play(int index, Function() onFullBoard, Function() onInvalidMove) {
    //check if board is full
    if (_movesCounter < 9) {
      //board is not full
      //check if move valid
      if (_board[index] == 0) {
        //valid move
        if (_currentPlayer == 1) {
          //user round
          userRound(index);
          addUserMove(index);
          _movesCounter++;
        } else {
          //computer round
          computerRound(index);
          addUserMove(index);
          _movesCounter++;
        }
      } else {
        //invalid move
        onInvalidMove();
      }
    } else {
      //board is full
      onFullBoard();
    }
    play(
        generateBestMoveIndex(),
        //on full board
        () => onFullBoard(),
        //on invalid move
        () => onInvalidMove());
  }

  void userRound(int index) {
    _board[index] = 1;
    togglePlayer(1);
    notifyListeners();
  }

  void computerRound(int index) {
    _board[index] = -1;
    togglePlayer(-1);
    notifyListeners();
  }

  int generateBestMoveIndex() {
    int maxUserMovesCount = 0;
    int userMovesCounter = 0;
    late int tempBestMoveIndex;
    late int bestMoveIndex;
    for (var pattern in _winPatternsList) {
      userMovesCounter = 0;
      for (var element in pattern) {
        if (_board[element] == 1) {
          userMovesCounter++;
        } else if (_board[element] == 0) {
          tempBestMoveIndex = element;
        }
      }
      if (userMovesCounter > maxUserMovesCount) {
        maxUserMovesCount = userMovesCounter;
        bestMoveIndex = tempBestMoveIndex;
      }
    }

    return bestMoveIndex;
  }

  void checkIfWinnerFound(List<int> board) {
    for (var list in _winPatternsList) {
      if (_board[list[0]] != 0 &&
          _board[list[0]] == _board[list[1]] &&
          _board[list[0]] == _board[list[2]]) {
        if (_board[list[0]] == 1) {
          _gameState = GameState.userWin;
        } else {
          _gameState = GameState.computerWin;
        }
      }
    }
    if (_movesCounter == 9) {
      _gameState = GameState.faiR;
    }
    _gameState = GameState.winnerNotFound;
    notifyListeners();
  }

  String showSymbol(int index) {
    if (_board[index] == 1) {
      return "X";
    }
    if (_board[index] == -1) {
      return "O";
    }
    return "";
  }

  ////////////////////////////////////////////////////////////////////////////////

  setUserSymbol(String v) {
    _userSymbol = v;
    notifyListeners();
  }

  setisXSelected(bool v) {
    _isXSelected = v;
    notifyListeners();
  }

  setisOSelected(bool v) {
    _isOSelected = v;
    notifyListeners();
  }

  setGameState(GameState v) {
    _gameState = v;
    notifyListeners();
  }

  List<int> get getBoradList => _board;
  List<List<int>> get getWinPatternList => _winPatternsList;
  String get getUserSymbol => _userSymbol;
  bool get getisXSelected => _isXSelected;
  bool get getisOSelected => _isOSelected;
  GameState get getGameState => _gameState;
  int get getCurrentPlayer => _currentPlayer;
}
