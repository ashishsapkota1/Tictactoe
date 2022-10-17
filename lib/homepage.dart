import 'package:flutter/material.dart';


class TicTac extends StatefulWidget {
  const TicTac({Key? key}) : super(key: key);

  @override
  State<TicTac> createState() => _TicTacState();
}

class _TicTacState extends State<TicTac> {
  //Icon image
  var cross = Icon(Icons.cancel,size: 80,);
  var circle = Icon(Icons.circle,size: 80,);
  var edit = Icon(Icons.edit,size: 80);

  bool isCross = true;
  late String message;
  late List<String> gameState;

  //initialize box
  @override
  void initState() {
    gameState = List.filled(9, '');
    this.message = '';
    super.initState();
  }

  // play game
  playGame(int index){
    if(this.gameState[index] =='' ){
      setState(() {
        if(isCross){
          gameState[index]=='cross';
        }else{
          gameState[index]=='circle';
        }
      });
      isCross = !isCross;
    }

}

//reset
  resetGame(){
    setState(() {
      gameState = List.filled(9, 'empty');
      this.message = "";
    });
  }

  // get icon image

  getIcon(String title){
    switch(title){
      case('empty'):
        return edit;
        break;
      case('cross'):
        return cross;
        break;
      case('circle'):
        return circle;
        break;
    }
  }

  //check for win
  checkWin(){

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child:GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3/2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: gameState.length,
                  itemBuilder: (context,i)=>SizedBox(
                    height: 100,
                    width: 100,
                    child: MaterialButton(onPressed:() {
                      playGame(i);
                    },
                    child: getIcon(gameState[i]),
                    ),

                  ),

              ),

          ),
        ],

      ),
    );
  }
}
