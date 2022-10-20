import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

// declarations
  bool oTurn = true;

// 1st player is O
  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  int drawcount = 0;

 void Newgame(){
   setState(() {
   oScore = 0;
   drawcount = 0;
   xScore = 0;
   for(int i=0; i<9;i++){
     displayElement[i]='';
   }
   filledBoxes = 0;
   });
 }
 void clearBoard(){
   setState(() {
     for(int i=0; i<9;i++){
       displayElement[i]='';
     }
   });
 }

void checkWinner() {
  //check row
  if (displayElement[0] == displayElement[1] &&
      displayElement[1] == displayElement[2] &&
      displayElement[0] != '') {
    winner(displayElement[0]);
  }
  if (displayElement[3] == displayElement[4] &&
      displayElement[4] == displayElement[5] &&
      displayElement[3] != '') {
    winner(displayElement[3]);
  }
  if (displayElement[6] == displayElement[7] &&
      displayElement[7] == displayElement[8] &&
      displayElement[6] != '') {
    winner(displayElement[6]);
  }

  //check column
  if (displayElement[0] == displayElement[3] &&
      displayElement[3] == displayElement[6] &&
      displayElement[0] != '') {
    winner(displayElement[0]);
  }
  if (displayElement[1] == displayElement[4] &&
      displayElement[4] == displayElement[7] &&
      displayElement[1] != '') {
    winner(displayElement[1]);
  }

  if (displayElement[2] == displayElement[5] &&
      displayElement[5] == displayElement[8] &&
      displayElement[2] != '') {
    winner(displayElement[2]);
  }

  //check diagonal
  if (displayElement[0] == displayElement[4] &&
      displayElement[4] == displayElement[8] &&
      displayElement[0] != '') {
    winner(displayElement[0]);
  }

  if (displayElement[2] == displayElement[4] &&
      displayElement[4] == displayElement[6] &&
      displayElement[2] != '') {
    winner(displayElement[2]);
  }else if(filledBoxes==9){
    showDraw();
  }
}
   //winner show
  void winner(String win){
       showDialog(
           barrierDismissible: false,
           context: context,
           builder: (BuildContext context){
             return AlertDialog(
               title: Text('player $win  is Winner'),
               backgroundColor: Colors.grey[600],
               titleTextStyle: TextStyle(color: Colors.red[600],fontWeight: FontWeight.bold),
               actions: [
                 TextButton(onPressed: (){
                   clearBoard();
                   Navigator.of(context).pop();
                 },
                     child: Text('play again',
                         style: TextStyle(fontWeight: FontWeight.bold,color:Colors.red[400] )
                     ),
                 )
               ],
             );
           }
           );

       if(win=='X'){
         xScore++;
       }else if(win=='O'){
         oScore++;
    }
   }
   //for draw
   void showDraw(){
   showDialog(context: context,
       builder: (BuildContext){
     return AlertDialog(
       title: Text('the game is draw'),
       backgroundColor: Colors.grey[600],
       titleTextStyle: TextStyle(color: Colors.red[600],fontWeight: FontWeight.bold),
       actions: [
         TextButton(onPressed: (){
           clearBoard();
           Navigator.of(context).pop();
         },
             child: Text('play again',
             style: TextStyle(fontWeight: FontWeight.bold,color:Colors.red[400])
             ))
       ],
     );
   }
   );
 drawcount++;
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: <Widget>[
          Expanded(

            // creating the ScoreBoard
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Player X',
                          style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          xScore.toString(),
                          style: TextStyle(fontSize: 20,color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Player O', style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)
                        ),
                        Text(
                          oScore.toString(),
                          style: TextStyle(fontSize: 20,color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Draw',
                          style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          drawcount.toString(),
                          style: TextStyle(fontSize: 20,color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ),
          ),
          Expanded(

            // Creating the Board for Tic tac toe
            flex: 4,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      child: Center(
                        child: Text(
                          displayElement[index],
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(

            // Button for Clearing the board

              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(


                      onPressed: (){
                       Newgame();

                      },
                      child: Text("Play New game"),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

// filling the boxes when tapped with X
// or O respectively and then checking the winner function
  void tapped(int index) {
    setState(() {
      if (oTurn && displayElement[index] == '') {
        displayElement[index] = 'O';
        filledBoxes++;
      } else if (!oTurn && displayElement[index] == '') {
        displayElement[index] = 'X';
        filledBoxes++;
      }

      oTurn = !oTurn;
       checkWinner();
    });
  }

}



