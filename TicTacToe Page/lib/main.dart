import 'package:flutter/material.dart';

void main() => runApp(const TicTacApp());

class TicTacApp extends StatelessWidget {
  const TicTacApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TIC TAC TOE",
      home: const TicTacGame(),
    );
  }
}

class TicTacGame extends StatefulWidget {
  const TicTacGame({super.key});

  @override
  State<TicTacGame> createState() => _TicTacGameState();
}

class _TicTacGameState extends State<TicTacGame> {
  List<String> board = List.filled(9, '', growable: false);
  bool isXTurn = true; // Variable to track the turn
  String gameResult = ''; // Variable to store game result

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
        title: const Text('TIC_TAC_TOE'),
      ),
      body: gamePlan(),
    );
  }

  Widget gamePlan() {
    return Column(
      children: [
        Expanded(
          child: GridView.count(
            crossAxisCount: 3, // 3 boxes per row
            padding: const EdgeInsets.all(8),
            children: List.generate(9, (index) {
              return GestureDetector(
                onTap: () => _handleTap(index: index),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      board[index],
                      style: const TextStyle(fontSize: 40, color: Colors.red),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                gameResult,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
              ),
              ElevatedButton(
                onPressed: _resetGame,
                child: const Text("Reset Game"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleTap({required int index}) {
    if (board[index] == '' && gameResult == '') {
      setState(() {
        board[index] = isXTurn ? 'X' : 'O';
        isXTurn = !isXTurn;
        gameResult = _checkWinner();
      });
    }
  }

  String _checkWinner() {
    const winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      if (board[pattern[0]] == board[pattern[1]] &&
          board[pattern[1]] == board[pattern[2]] &&
          board[pattern[0]] != '') {
        return '${board[pattern[0]]} wins!';
      }
    }

    if (!board.contains('')) {
      return 'It\'s a Draw';
    }
    return '';
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, '', growable: false);
      gameResult = '';
      isXTurn = true;
    });
  }
}
