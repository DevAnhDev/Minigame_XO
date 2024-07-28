import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictoe/game_view.dart';
import 'package:tictoe/game_view_model.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameViewModel = Provider.of<GameViewModel>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseWidth = 375.0;
    double baseHeight = 812.0;
    double scaleFactor =
        (screenWidth / baseWidth + screenHeight / baseHeight) / 2;
    double iconSize = scaleFactor * 1.5;
    double iconSpace = scaleFactor * 25;
    double fontSize = scaleFactor * 30;
    double fontSizeHead = scaleFactor * 35;
    double space = screenWidth * 0.08;
    double buttonWidth = screenWidth * 0.5;
    double buttonHeight = screenWidth * 0.15;
    Color bgColor = const Color(0xFFF3F3F3);
    Color buttonColor = const Color(0xFF412c5a);
    Color iconColor = const Color(0xFFCBA135);
    Color textColor = const Color(0xFF412c5a);

    return Scaffold(
      body: Container(
        color: bgColor,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                left: iconSpace,
                top: iconSpace,
                child: Transform.scale(
                  scale: iconSize,
                  child: CircleAvatar(
                    backgroundColor: buttonColor,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new_sharp),
                      color: iconColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: space * 3.5),
                    Text(
                      'Select Opponent',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeHead,
                          color: textColor),
                    ),
                    SizedBox(height: space),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            gameViewModel.setOpponent('Player');
                          },
                          child: Text(
                            'Player',
                            style: TextStyle(
                              color: gameViewModel.game.opponent == 'Player'
                                  ? iconColor
                                  : Colors.black,
                              fontSize: fontSize,
                            ),
                          ),
                        ),
                        SizedBox(height: space),
                        TextButton(
                          onPressed: () {
                            gameViewModel.setOpponent('AI');
                          },
                          child: Text(
                            'AI',
                            style: TextStyle(
                              color: gameViewModel.game.opponent == 'AI'
                                  ? iconColor
                                  : Colors.black,
                              fontSize: fontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: space),
                    Text(
                      'Select Grid Size',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeHead,
                          color: textColor),
                    ),
                    SizedBox(height: space),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            gameViewModel.setGridSize(3);
                          },
                          child: Text(
                            '3x3',
                            style: TextStyle(
                              color: gameViewModel.game.gridSize == 3
                                  ? iconColor
                                  : Colors.black,
                              fontSize: fontSize,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            gameViewModel.setGridSize(4);
                          },
                          child: Text(
                            '4x4',
                            style: TextStyle(
                              color: gameViewModel.game.gridSize == 4
                                  ? iconColor
                                  : Colors.black,
                              fontSize: fontSize,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            gameViewModel.setGridSize(5);
                          },
                          child: Text(
                            '5x5',
                            style: TextStyle(
                              color: gameViewModel.game.gridSize == 5
                                  ? iconColor
                                  : Colors.black,
                              fontSize: fontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: space),
                    SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: iconColor,
                          backgroundColor: buttonColor,
                          textStyle: TextStyle(
                              fontSize: fontSize, fontWeight: FontWeight.bold),
                        ),
                        child: Text('Continue'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GameScreen()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
