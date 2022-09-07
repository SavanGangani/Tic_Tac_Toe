import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tic_tac_toe/add_helper.dart';
import 'color.dart';
import 'game.dart';

Future<InitializationStatus> main() {
  runApp(const MyApp());
  return MobileAds.instance.initialize();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  //adding the necessary variables
  String lastValue = "X";
  bool gameOver = false;
  int turn = 0; // to check the draw
  String result = "";
  List<int> scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
  Game game = Game();
  AdHelper adHelper = AdHelper();

  @override
  void initState() {
    super.initState();
    AdHelper.myBanner.load();
    AdHelper.myBanner1.load();
    game.board = Game.initGameBoard();
  }
  final AdWidget adWidget = AdWidget(ad: AdHelper.myBanner);
  final AdWidget adWidget1 = AdWidget(ad: AdHelper.myBanner1);


  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: MainColor.primaryColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 38),
          scrollDirection: Axis.vertical,
    child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          child: adWidget,
        ),
        SizedBox(height: 15),

        Text(
          "It's ${lastValue} turn".toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          width: boardWidth,
          height: boardWidth,
          child: GridView.count(
            crossAxisCount: Game.boardlenth ~/ 3,
            padding: EdgeInsets.all(16.0),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            children: List.generate(Game.boardlenth, (index) {
              return InkWell(
                onTap: gameOver
                    ? null
                    : () {
                  if (game.board![index] == "") {
                    setState(() {
                      game.board![index] = lastValue;
                      turn++;
                      gameOver = game.winnerCheck(
                          lastValue, index, scoreboard, 3);

                      if (gameOver) {
                        result = "$lastValue is the Winner";
                      } else if (!gameOver && turn == 9) {
                        result = "It's a Draw!";
                        gameOver = true;
                      }
                      if (lastValue == "X")
                        lastValue = "O";
                      else
                        lastValue = "X";
                    });
                  }
                },
                child: Container(
                  width: Game.blocSize,
                  height: Game.blocSize,
                  decoration: BoxDecoration(
                    color: MainColor.secondaryColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: Text(
                      game.board![index],
                      style: TextStyle(
                        color: game.board![index] == "X"
                            ? Colors.blue
                            : Colors.pink,
                        fontSize: 50.0,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        SizedBox(
          height: 3.0,
        ),
        Text(
          result,
          style: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
        ElevatedButton.icon(
          onPressed: () {
            // adHelper.showRewardeAd();
            setState(() {
              game.board = Game.initGameBoard();
              lastValue = "X";
              gameOver = false;
              turn = 0;
              result = "";
              scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
              // adHelper.showRewardeAd();
            });
          },
          icon: Icon(Icons.replay),
          label: Text("Repeat the Game"),
        ),
        Container(
          height: 50,
          child: adWidget1,
        )
      ],
    )),
    ),
    );
  }
}
