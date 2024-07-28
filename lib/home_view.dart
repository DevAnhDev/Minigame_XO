import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tictoe/game_view.dart';
import 'package:tictoe/game_view_model.dart';
import 'package:tictoe/replay_view.dart';
import 'package:tictoe/settings_view.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
    late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    play('/bg.mp3');
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.5, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    audioPlayer.dispose();

    super.dispose();
  }
    Future<void> play(String audioPath) async {
    final response = await audioPlayer.play(AssetSource(audioPath));
  }

  @override
  Widget build(BuildContext context) {
    final gameViewModel = Provider.of<GameViewModel>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseWidth = 375.0;
    double baseHeight = 812.0;
    double scaleFactor =
        (screenWidth / baseWidth + screenHeight / baseHeight) / 2;
    double fontSizeHead = scaleFactor * 35;
    double fontSize = scaleFactor * 30;
    double space = screenWidth * 0.08;
    double buttonWidth = screenWidth * 0.5;
    double buttonHeight = screenWidth * 0.15;
    Color buttonColor = const Color(0xFF412c5a);
    Color textColor = const Color(0xFFCBA135);
    Color bgColor = const Color(0xFFF3F3F3);
    double imageSize = screenWidth * 0.6;
    Color isClor = Color.fromARGB(255, 240, 179, 250);
    return Scaffold(
      body: Container(
        color: bgColor,
        child: Stack(
          children: [
          Positioned.fill(
          child: Image.asset(
            'assets/bg.gif',
            fit: BoxFit.fill,
          )),
            Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: space * 2),
                  ScaleTransition(
                    scale: _animation,
                    child: Text(
                      "Xo Ox",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSizeHead,
                        color: textColor,
                      ),
                    ),
                  ),
                  SizedBox(height: space * 2),
                  SizedBox(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color.fromARGB(255, 2, 11, 255), width: 5.0),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 330,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                          const Text("Select Play With:", style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),),
                          const SizedBox(height: 10,),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                     InkWell(
                                      onTap: (){
                                        gameViewModel.setOpponent('Player');
                                        
                                      },
                                      child: Container(
                                        width: 140,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          color: gameViewModel.game.opponent == 'Player'? isClor: const Color.fromARGB(255, 255, 255, 255),
                                          borderRadius: BorderRadius.circular(10.0), // Độ cong của viền
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.3), // Màu và độ mờ của shadow
                                              blurRadius: 5, // Độ mờ của shadow
                                              offset: Offset(0, 2), // Độ dịch chuyển của shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/player.png',
                                              width: 80,
                                              height: 80,
                                            ),
                                            // SizedBox(height: 5),
                                            Text(
                                              "Player",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                     InkWell(
                                      onTap: (){
                                        gameViewModel.setOpponent('AI');
                                      },
                                      child: Container(
                                        width: 140,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          color: gameViewModel.game.opponent == 'AI'? isClor: const Color.fromARGB(255, 255, 255, 255),
                                          borderRadius: BorderRadius.circular(10.0), // Độ cong của viền
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.3), // Màu và độ mờ của shadow
                                              blurRadius: 5, // Độ mờ của shadow
                                              offset: Offset(0, 2), // Độ dịch chuyển của shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/ai.png',
                                              width: 80,
                                              height: 80,
                                            ),
                                            // SizedBox(height: 5),
                                            Text(
                                              "Robot",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                              ],
                            ),
                          const SizedBox(height: 10,),
                          const Text("Select Grid Size: ",  style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),),
                          const SizedBox(height: 10,),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                    InkWell(
                                      onTap: (){
                                        gameViewModel.setGridSize(3);
                                      },
                                      child: Container(
                                        width: 110,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          color: gameViewModel.game.gridSize == 3? isClor: const Color.fromARGB(255, 255, 255, 255),
                                          borderRadius: BorderRadius.circular(10.0), // Độ cong của viền
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.3), // Màu và độ mờ của shadow
                                              blurRadius: 5, // Độ mờ của shadow
                                              offset: Offset(0, 2), // Độ dịch chuyển của shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/3.png',
                                              width: 80,
                                              height: 80,
                                            ),
                                            // SizedBox(height: 5),
                                            Text(
                                              "Grid",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    InkWell(
                                      onTap: (){
                                        gameViewModel.setGridSize(4);
                                      },
                                      child: Container(
                                        width: 110,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          color: gameViewModel.game.gridSize == 4? isClor: const Color.fromARGB(255, 255, 255, 255),
                                          borderRadius: BorderRadius.circular(10.0), // Độ cong của viền
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.3), // Màu và độ mờ của shadow
                                              blurRadius: 5, // Độ mờ của shadow
                                              offset: Offset(0, 2), // Độ dịch chuyển của shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/4.png',
                                              width: 80,
                                              height: 80,
                                            ),
                                            // SizedBox(height: 5),
                                            Text(
                                              "Grid",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        gameViewModel.setGridSize(5);
                                      },
                                      child: Container(
                                        width: 110,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          color: gameViewModel.game.gridSize == 5? isClor: const Color.fromARGB(255, 255, 255, 255),
                                          borderRadius: BorderRadius.circular(10.0), // Độ cong của viền
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.3), // Màu và độ mờ của shadow
                                              blurRadius: 5, // Độ mờ của shadow
                                              offset: Offset(0, 2), // Độ dịch chuyển của shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/5.png',
                                              width: 80,
                                              height: 80,
                                            ),
                                            // SizedBox(height: 5),
                                            Text(
                                              "Grid",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ), 
                              ],
                            ),
                          

                          ],),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(padding: EdgeInsets.all(15.0),
                    child: ElevatedButton(
                              child: const Text('   PLAY GAME   ', style: TextStyle(
                                color:  Color.fromARGB(255, 3, 3, 3),
                              fontSize: 21,
                              fontWeight: FontWeight.bold
                              ),),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => GameScreen()),
                                );
                              },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: isClor,
                              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 6),
                          ),
                            ),
                  ),


                  const SizedBox(height: 10,),
                  Padding(padding: EdgeInsets.all(15.0),
                    child: ElevatedButton(
                              child: const Text('   HISTORY GAME  ', style: TextStyle(
                                color:  Color.fromARGB(255, 3, 3, 3),
                              fontSize: 21,
                              fontWeight: FontWeight.bold
                              ),),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ReplayScreen()),
                                );
                              },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: isClor,
                              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 6),
                          ),
                            ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(padding: EdgeInsets.all(15.0),
                    child: ElevatedButton(
                              child: const Text('   EXIT GAME  ', style: TextStyle(
                                color:  Color.fromARGB(255, 3, 3, 3),
                              fontSize: 21,
                              fontWeight: FontWeight.bold
                              ),),
                          onPressed: () {
                             exit(0);
                              },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: isClor,
                              padding: EdgeInsets.symmetric(horizontal: 53, vertical: 6),
                          ),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



  