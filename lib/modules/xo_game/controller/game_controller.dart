import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task4/modules/xo_game/utils/game_util.dart';

ChangeNotifierProvider<GameController> gameProvider =
    ChangeNotifierProvider<GameController>((ref) => GameController());

class GameController extends ChangeNotifier {
  String _userSymbol = "X";
  String _computerSymbol = "O";
  bool _isXSelected = false;
  bool _isOSelected = false;

  var player1Win = 0;
  var player2Win = 0;
  var draw = 0;

  List<int> board = List.generate(9, (index) => 0);
  int currentPlayer = GameUtil.user;
  int gameResult = GameUtil.noWinnerYet;
  bool isComputerPlaying = false;
  GameUtil ai = GameUtil();

  void reinitialize() {
    board = List.generate(9, (index) => 0);
    gameResult = GameUtil.noWinnerYet;
    currentPlayer = GameUtil.user;
     player1Win = 0;
     player2Win = 0;
     draw = 0;
    //
    notifyListeners();
  }

  void move(int index) async {
    if (GameUtil.isValidMove(board, index) && player1Win == 0 && player2Win == 0 && draw == 0) {
      board[index] = currentPlayer;
      checkGameWinner();
      togglePlayer();
      //
      notifyListeners();
      if (gameResult == GameUtil.noWinnerYet) {
        isComputerPlaying = true;
        final bestMove = ai.play(
          board,
          currentPlayer,
        );
        board[bestMove] = currentPlayer;
        isComputerPlaying = false;
        checkGameWinner();
        togglePlayer();
        //
        notifyListeners();
      }
    }
  }

  bool isEnable(int idx) => board[idx] == GameUtil.empty;

  int getDataAt(int idx) => board[idx];

  void togglePlayer() {
    currentPlayer = GameUtil.togglePlayer(currentPlayer);
    //
    notifyListeners();
  }

  void checkGameWinner() {
    gameResult = GameUtil.checkIfWinnerFound(board);
    switch (gameResult) {
      case GameUtil.user:
        player1Win++;
        //
        notifyListeners();
        break;
      case GameUtil.computer:
        player2Win++;
        //
        notifyListeners();
        break;
      case GameUtil.draw:
        draw++;
        //
        notifyListeners();
        break;
    }
  }

  String? get gameResultStatus {
    final newGameResult = gameResult;
    if (newGameResult != GameUtil.noWinnerYet) {
      if (newGameResult == GameUtil.user) {
        return "You are the winner";
      } else if (newGameResult == GameUtil.computer) {
        return "AI wins";
      } else if (newGameResult == GameUtil.draw) {
        return "Draw";
      }
    }
    return null;
  }

  String showSymbol(int index) {
    if (board[index] == 1) {
      return _userSymbol;
    }
    if (board[index] == -1) {
      return _computerSymbol;
    }
    return "";
  }

  setUserSymbol(String v) {
    if (v == "O") {
      _userSymbol = v;
      _computerSymbol = "X";
    }

    notifyListeners();
  }

  xSelected(bool v) {
    _isXSelected = v;
    notifyListeners();
  }

  oSelected(bool v) {
    _isOSelected = v;
    notifyListeners();
  }

  String get getUserSymbol => _userSymbol;
  bool get getXSelected => _isXSelected;
  bool get getOSelected => _isOSelected;
  List<int> get getBoardList => board;
}
