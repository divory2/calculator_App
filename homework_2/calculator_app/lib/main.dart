import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var input ='';
  int userInput = 0;

  final List <String> calculatorButtons= [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
    '(',
    ')', //list that contains all the buttons for calculator

  ];
  void solveExpression(){
    try{  
      String formatInput = input.replaceAll('x', '*').replaceAll('%', '/100'); //replacing x with * for entire string input

      Parser parser = Parser();//parser obj 
      Expression exp = parser.parse(formatInput); //parser converts String into expression 
      ContextModel cm = ContextModel(); // this is used for if expression contains variable 
      double answer = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        if(answer.isNaN){
          input = "Not a Number";
        }
        else if (answer.isInfinite){
          input ='Undefined';
        }
        else{
          input = answer.toString();

        }
      });


    }
    catch(e){
      setState(() {
        input = 'Error';
      });

    }
  }

  

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    input,
                    style: TextStyle(fontSize: 18,
                    color: Colors.black),



                  ),


                ),
                Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.centerRight,
                  child: Text(
                    input,
                    style: TextStyle(fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),


                  ),
                ),

              ],
            ),),

            // SizedBox(
            //   width: 100,
            //   child: TextField(
            //   onChanged: (value){
            //     setState(() {
            //       userInput = int.tryParse(value)!;
            //     });
               
            //   },
            //    decoration: const InputDecoration(
            //       labelText: 'Enter Number',
            //       hintText: 'Type or press desired value',
            //       border: OutlineInputBorder(),
            //     ),
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // ),

            Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                itemCount: calculatorButtons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), //define how many columns i want in grid
                itemBuilder:(BuildContext context, int index){ //mapping function this is how 
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        if(calculatorButtons[index]== '='){
                          solveExpression();

                        }
                        else if(calculatorButtons[index]=='C'){
                          input = '';

                        }
                        else if (calculatorButtons[index] == 'DEL') {
                        input = input.isNotEmpty ? input.substring(0, input.length - 1) : input; //only get the subsrring all the way to one less than the last index
                      }
                      else if(calculatorButtons[index]== '+/-'){
                        double temp = double.tryParse(input)! * -1;
                        input = temp.toString();

                      }
                      else{
                        input+= calculatorButtons[index];

                      }
                    });
                    },
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    child: Center(
                      child: Text(
                        calculatorButtons[index],
                        style: TextStyle(fontSize: 24,
                        color: Colors.white),
                      ),
                    ),
                    ),
                  );
                  
                }),
            ),
            
          ),
          ],
          
        ),
        
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
