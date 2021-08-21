import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  StaggeredTile.extent(1, 148.0),
  StaggeredTile.extent(1, 148.0),
];

List<Widget> _tiles = const <Widget>[
  const MyItems(Icons.app_registration_rounded, "Advance Text Analysis",
      0xff3399fe, "/fourth"),
  const MyItems(Icons.build_circle_rounded, "Real time Translation", 0xffff3266,
      "/third"),
];

class Example01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('AWS Service'),
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: StaggeredGridView.count(
              crossAxisCount: 2,
              staggeredTiles: _staggeredTiles,
              children: _tiles,
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 12.0,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            )));
  }
}

class MyItems extends StatelessWidget {
  const MyItems(this.icon, this.heading, this.color, this.routeName);

  final int color;
  final IconData icon;
  final String heading;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 12.0,
      shadowColor: Color(0xff2962ff),
      borderRadius: BorderRadius.circular(20.0),
      child: Center(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //Text here
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            heading,
                            style: TextStyle(
                              color: new Color(color),
                              fontSize: 18.0,
                            ),
                          ),
                        ), //text

                        //icon
                        Material(
                          color: new Color(color),
                          borderRadius: BorderRadius.circular(24.0),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: IconButton(
                              icon: Icon(icon),
                              iconSize: 20,
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(context, routeName);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]))),
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Service',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => Example01(),
        '/fourth': (context) => FourthScreen(),
        '/third': (context) => ThirdScreen(),
      },
    );
  }
}

class FourthScreen extends StatefulWidget {
  const FourthScreen({Key? key}) : super(key: key);

  @override
  _FourthScreen createState() => _FourthScreen();
}

class _FourthScreen extends State<FourthScreen> {
  late String output = "";
  var utext;
  web(utext) async {
    // print(utext);
    var response = await http.get(
        Uri.http("65.2.131.196", "/cgi-bin/aws_comprehend.py", {"sen": utext}));
    // print(response.body);
    setState(() {
      output = response.body;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Advance Text Analysis"),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Enter your text here: "),
            TextFormField(
              textAlign: TextAlign.center,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.brush),
                hintText: "Enter your text here...",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onChanged: (value) {
                utext = value;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  web(utext);
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: Text("Run"),
              ),
            ),
            Container(child: Text("$output"))
          ],
        ),
      ),
    );
  }
}

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  _ThirdScreen createState() => _ThirdScreen();
}

class _ThirdScreen extends State<ThirdScreen> {
  late String output = "";
  var lang, text;
  web(lang, text) async {
    // print(utext);
    var response = await http.get(Uri.http(
        "65.2.131.196", "/cgi-bin/translate.py", {"lang": lang, "text": text}));
    // print(response.body);
    setState(() {
      output = response.body;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Real time translation"),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("LANGUAGE: "),
            TextFormField(
              textAlign: TextAlign.center,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.brush),
                hintText:
                    "Enter the required language here...[English / German / Spanish / Hindi] ",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onChanged: (value) {
                lang = value;
              },
            ),
            Text("TEXT: "),
            TextFormField(
              textAlign: TextAlign.center,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.brush),
                hintText: "Enter the sentence... ",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onChanged: (value) {
                text = value;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  web(lang, text);
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: Text("Run"),
              ),
            ),
            Container(child: Text("$output"))
          ],
        ),
      ),
    );
  }
}
