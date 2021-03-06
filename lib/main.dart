import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Robert Corona Criollo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Robert Corona Criollo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
      BluetoothConnection connection;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Bluetooth Ligth'),
        
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.bluetooth_disabled,size: 40,),onPressed: (){
            connection.close();
          },),
            IconButton(
            icon: const Icon(Icons.bluetooth,size: 40,),
            tooltip: 'Show Snackbar',
            onPressed: () async {
              FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
         
   List<BluetoothDevice> devices = [];

    // To get the list of paired devices
    List<Widget> lista=new  List<Widget>();
   devices = await bluetooth.getBondedDevices();
for (BluetoothDevice r in devices) {
        lista.add(GestureDetector(child:Card(child: Container(child: Text("${r.name} / ${r.address}")),),onTap: ()async{print("se preciono uno");
        
        ///
        ///
        ///
    
         connection = await BluetoothConnection.toAddress(r.address);

    print('Connected to the device');
    Navigator.of(context).pop();
    connection.output.add(ascii.encode('H'));
    
    
      
          
          
        ///
        
        },));
        // lista.add(item);
        // print('${r.name} found! rssi: ${r.address}');


    }

         
        // print('${r.name} found! rssi: ${r.address}');
        
 
             

   showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text("Paired Devices"),
          content: ListView(children: lista,),
          actions: <Widget>[
            RaisedButton(color: Colors.purple,
              child: Text("CERRAR", style: TextStyle(color: Colors.white),),
              onPressed: (){ Navigator.of(context).pop(); },
            )
          ],
        );

    });
print("holiiia");

            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Welcome Text
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
             "LIGHT 1",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
              ),

              // Beginner Button
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: ButtonTheme(
                  minWidth: 200,
                  height: 60,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: FlatButton(
                    color: Colors.blue,
                    onPressed:(){
                      connection.output.add(ascii.encode('1'));
                      print("object");
                    } ,
                    child: Text(
                      'ON/OFF',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),

                  ),
                ),
              ),

              // Intermediate Button
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: ButtonTheme(
                  minWidth: 200,
                  height: 60,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child:  Text(
                    "LIGHT 2",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Advance Button
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: ButtonTheme(
                  minWidth: 200,
                  height: 60,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: FlatButton(
                    onPressed:(){
                      connection.output.add(ascii.encode('2'));
                      print("object");
                    } ,
                    color: Colors.deepPurple,
                    child: Text(
                      'ON/OFF',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
