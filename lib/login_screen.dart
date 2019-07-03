import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:test_sample/profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  final  _usernameController = TextEditingController();
  final  _passwordController = TextEditingController();

  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
  _animationController = new AnimationController(
    duration: new Duration(milliseconds: 500),
    vsync: this
  );
  _animation = new CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOut
  );
  _animation.addListener(()=> this.setState((){}));
  _animationController.forward();
  }

  Widget allTextWithMargin(){
    return new Container(
      margin: EdgeInsets.all(20.0),
              child: new Column(        
                      children: <Widget>[
                      new TextField(
                        style: new TextStyle(
                          color: Colors.white
                        ),
                        controller: _usernameController,
                        decoration: InputDecoration(
                          
                          labelText: "Enter email",
                          contentPadding: const EdgeInsets.fromLTRB(5.0, 5.0  , 5.0, 5.0),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      new TextField(
                        style: new TextStyle(
                          color: Colors.white
                        ),
                        controller: _passwordController,
                        decoration: InputDecoration(
                        labelText: "Enter your password",
                        contentPadding: const EdgeInsets.fromLTRB(5.0, 15.0  , 5.0, 5.0),
                        ),
                        keyboardType: TextInputType.text,
                        
                        obscureText: true,
                      ),
                      new Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      new RaisedButton(
                          child: new Text("Sign In"), 
                          onPressed:_performLogin,
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          splashColor: Colors.red,
                      ),

                    ],
                ),

    );

  }

  void _performLogin(){
       
       onBackPressed(); // for a short while 
    //   String email = _usernameController.text;
    //   String password = _passwordController.text;

    //   bool emailValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
     
    //   if(!emailValid){
    //     Fluttertoast.showToast(
    //       msg: "Email is not valid.",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIos: 5
    //     );
    //   }else if(password.length<=5){
    //     Fluttertoast.showToast(
    //       msg: "Please enter 6 digit password.",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIos: 5
    //     );
    //   }
    // if(emailValid && password.length>= 6){
    //   onBackPressed();
    // }
  }

  void onBackPressed(){
      
      FocusScope.of(context).requestFocus(new FocusNode());// to dismiss the keyboard
      Route route = MaterialPageRoute(builder: (context) => SecondRoute());
      Navigator.pushReplacement(context, route);
  }


  @override
  Widget build(BuildContext context) {
    
   return new Scaffold(
     backgroundColor: Colors.black,
     body: new Stack(
       fit: StackFit.expand,
       children: <Widget>[
         new Image(
           image: AssetImage("assets/background.png"),
           fit: BoxFit.fill,
           color: Colors.black54,
           colorBlendMode: BlendMode.darken,
         ),
        
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new FlutterLogo(
              size: _animationController.value * 100
            ),
            allTextWithMargin()
          ],
        ),

       ],
     ),
   );
  }
}

class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
bool _load = false;
  final String url = "https://swapi.co/api/people";
  List data = new List();

  @override
  void initState() {
    super.initState();
    this.getJsonData();
    setState((){ _load=true;});
  }

  Future<String> getJsonData() async {

    var response = await http.get(
      // Encodwe the URL
      Uri.encodeFull(url),
      // Header only accept the application/JSON file
      headers: {"Accept":"application/json"},
    );
   
    print(response.body);

    setState(() {
      print("State changed");
      _load=false;
     var convertDataTOJson = json.decode(response.body);
     data = convertDataTOJson['results'];
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
  Widget loadingIndicator =_load? new Container(
      color: Colors.grey[300],
      width: 70.0,
      height: 70.0,
      child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
    ):new Container();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("JSON Data"),
        actions: <Widget>[
          IconButton(
            icon: Icon(choices[0].iconData),
            onPressed:() {
              Route route = MaterialPageRoute(builder: (context) => ProfileSetting());
              Navigator.push(context, route);
            },
          ),
        ],
      ),
      body: new Stack(
          children: <Widget>[
            new Padding( padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
            child: new ListView.builder(
                itemCount: data.length == null ? 0 : data.length,
                itemBuilder: (BuildContext context, int index){
                  return new Container(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          new Card(
                            child: new Container(
                              margin: const EdgeInsets.all(20.0),
                              child: new Text(data[index]['name']),
                            ),
                          )
                        ],
                      ),    
                  );    
                },
              ), 
            ),
            new Align(child: loadingIndicator,alignment: FractionalOffset.center,),
          ],
      ),
    );
  }
}

class Choice{
 final String title;
 final IconData iconData;

const Choice({this.title, this.iconData});

}

const List<Choice>choices = const <Choice>[
  const Choice(title: "Setting", iconData : Icons.settings)

];
