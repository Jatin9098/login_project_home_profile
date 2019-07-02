import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';


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
       
        String email = _usernameController.text;
        String password = _passwordController.text;

      bool emailValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
     
      if(!emailValid){
        Fluttertoast.showToast(
          msg: "Email is not valid.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 5
        );
      }else if(password.length<=5){
        Fluttertoast.showToast(
          msg: "Please enter 6 digit password.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 5
        );
      }
    if(emailValid && password.length>= 6){
      onBackPressed();
    }
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

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        
        child: new Padding(
          padding: EdgeInsets.all(10.0),
          child : new Text("Welcome to Home Screen", style: TextStyle(fontSize: 60.0),),
        ) 
        
      
      ),
    );
  }
}


// bool emailValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);