import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe_game/constants/color.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  TextStyle customFontWhite =
      GoogleFonts.coiny(fontSize: 28, color: Colors.white, letterSpacing: 3);
  List displayXO = ['', '', '', '', '', '', '', '', ''];
  bool onTap = true;
  String finalResult = '';
  int scorePlayerX = 0;
  int scorePlayerO = 0;
  int filledBoxes = 0;
  List<int> matchedIndexes = [];

  bool winnerFound = false;

  Timer? timer;

  static const maxSeconds = 30;
  int seconds = maxSeconds;
  int attempts = 0;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() => seconds = maxSeconds;

  void containerTapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;

    if (isRunning) {
      setState(() {
        if (onTap && displayXO[index] == '') {
          displayXO[index] = 'O';
          filledBoxes++;
        } else if (!onTap && displayXO[index] == '') {
          displayXO[index] = 'X';
          filledBoxes++;
        }

        onTap = !onTap;
        checkWinner();
      });
    }
  }

  void calculateScore(String winner) {
    setState(() {
      if (winner == 'X') {
        scorePlayerX++;
        winnerFound = true;
      } else if (winner == 'O') {
        scorePlayerO++;
        winnerFound = true;
      }
    });
  }

  void checkWinner() {
    //check 1st row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      finalResult = 'Player ${displayXO[0]} Wins ';

      matchedIndexes.addAll([0, 1, 2]);
      stopTimer();
      calculateScore(displayXO[0]);
    }
    //check 2st row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      finalResult = 'Player ${displayXO[3]} Wins ';
      matchedIndexes.addAll([3, 4, 5]);
      stopTimer();
      calculateScore(displayXO[3]);
    }
    //check 3st row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      finalResult = 'Player ${displayXO[6]} Wins ';
      matchedIndexes.addAll([6, 7, 8]);
      stopTimer();
      calculateScore(displayXO[6]);
    }

    //Check Columns

    //check 1st column
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      finalResult = 'Player ${displayXO[0]} Wins ';
      matchedIndexes.addAll([0, 3, 6]);
      stopTimer();
      calculateScore(displayXO[0]);
    }
    //check 2st column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      finalResult = 'Player ${displayXO[1]} Wins ';
      matchedIndexes.addAll([1, 4, 7]);
      stopTimer();
      calculateScore(displayXO[1]);
    }
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[8] != '') {
      finalResult = 'Player ${displayXO[2]} Wins ';
      matchedIndexes.addAll([2, 5, 8]);
      stopTimer();
      calculateScore(displayXO[2]);
    }

    //Check Diagonal
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      finalResult = 'Player ${displayXO[0]} Wins ';
      matchedIndexes.addAll([0, 4, 8]);
      stopTimer();
      calculateScore(displayXO[0]);
    }
    if (displayXO[2] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[2] != '') {
      finalResult = 'Player ${displayXO[2]} Wins ';
      matchedIndexes.addAll([2, 4, 6]);
      stopTimer();
      calculateScore(displayXO[2]);
    }

    if (!winnerFound && filledBoxes == 9) {
      setState(() {
        finalResult = 'Nobody Wins';
      });
    }
  }

  // void deleteAllContainersItem() {
  //   bool isListNotFull = displayXO.any((element) => element.trim().isEmpty);
  //   if (!isListNotFull) {
  //     {
  //       setState(() {
  //         displayXO = ['', '', '', '', '', '', '', '', ''];
  //       });
  //     }
  //   }
  // }
  void clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
      finalResult = '';
      matchedIndexes = [];
    });
    filledBoxes = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MainColor.primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Player X",
                            style: customFontWhite,
                          ),
                          Text(
                            scorePlayerX.toString(),
                            style: customFontWhite,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Player O",
                            style: customFontWhite,
                          ),
                          Text(
                            scorePlayerO.toString(),
                            style: customFontWhite,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: GridView.builder(
                    shrinkWrap: true,
                    //physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 1 / 1.05),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            containerTapped(index);
                            //deleteAllContainersItem();
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: matchedIndexes.contains(index)
                                  ? MainColor.accentColor
                                  : MainColor.secondaryColor,
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                  width: 5, color: MainColor.primaryColor)),
                          child: Text(
                            displayXO[index],
                            style: GoogleFonts.coiny(
                              fontSize: 64,
                              color: matchedIndexes.contains(index)
                                  ? MainColor.secondaryColor
                                  : MainColor.primaryColor,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: 9,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      finalResult,
                      style: customFontWhite,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    _buildTimer()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;

    return isRunning
        ? SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxSeconds,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: MainColor.accentColor,
                ),
                Center(
                  child: Text(
                    '$seconds',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                ),
              ],
            ),
          )
        : SizedBox(
            width: 180,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
              onPressed: () {
                startTimer();
                clearBoard();
                attempts++;
              },
              child: Text(
                attempts == 0 ? 'Start' : 'Play Again!',
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          );
  }
}
