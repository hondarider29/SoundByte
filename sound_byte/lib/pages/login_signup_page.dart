
import 'package:flutter/material.dart';
import 'package:sound_byte/model/user.dart';
import 'package:sound_byte/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

final _firestore = Firestore.instance;

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;
  String _userName;
  bool _isLoginForm;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
          print("done");
        } else {
          userId = await widget.auth.signUp(_email, _password);
          await _firestore.collection("Users")
            .document(userId)
            .setData({
                'email' : _email,
                'name' : 'tempName',
                'chats' : [],
                'friends' : []               
            });
          print('Signed up user: $userId');
        }

        User.currentUser = await User.userFromDatabase(userId);

        if (userId.length > 0 && userId != null && _isLoginForm) {
          widget.loginCallback();
        }

      } catch (e) {
        print('Error: $e');
        setState(() {
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return Container(
        child: Text(
          _errorMessage,
          style: TextStyle(
              fontSize: 13.0,
              color: Colors.red,
              height: 2),
              textAlign: TextAlign.center,
        ),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showSecondaryButton() {
    return Container(
      padding: _isLoginForm ? EdgeInsets.fromLTRB(100, 600, 100, 0) : EdgeInsets.fromLTRB(80, 600, 0, 0),
        child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        color: Colors.blue,
         child: Text(_isLoginForm ? 'Create an account' : 'Have an account? Sign in',
            style: TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: toggleFormMode,
        )
    );
  }

  Widget showPrimaryButton() {
    return Container(
      child: Padding(
          padding: _isLoginForm ? EdgeInsets.fromLTRB(160, 440, 0, 100) : EdgeInsets.fromLTRB(125, 440, 0, 100),
          //padding: EdgeInsets.fromLTRB(160, 450, 0, 100),
          child: RaisedButton(
            key: Key('login'),
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: Text(_isLoginForm ? 'Login' : 'Create account',
                style: TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
      )
    );
  }

  Widget showEmailInput() {
    return SingleChildScrollView( //helps MOVE KEYBOARD
      padding: EdgeInsets.only(left: 50, right: 50, top: 265),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(143, 148, 51, 1)
                )
              ]
            ),
            child: Column(
              children : <Widget>[
                //email
                  Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                     child: new TextFormField(
                      key: Key("mail"),
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      decoration: new InputDecoration(
                          hintText: 'Email',
                          icon: new Icon(
                            Icons.mail,
                            color: Colors.grey,
                          )),
                      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                      onSaved: (value) => _email = value.trim(),
                    )
                  ),
                  //password
                  Container(
                    padding: EdgeInsets.all(7),
                     child: new TextFormField(
                       key: Key("pass"),
                       maxLines: 1,
                        obscureText: true,
                        autofocus: false,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            icon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                            )),
                        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
                        onSaved: (value) => _password = value.trim()
                    )
                  )
              ],
            ),
          )
        ],
      ),
    );
  }

   Widget showLogo() {
    return Container(
      child: Positioned(
        top: 180,
        left: 70,
        child: Text(
          "SoundByte",
          style: TextStyle(
            color: Colors.white,
            fontSize: 60,
            fontWeight: FontWeight.bold,
            fontFamily: 'Laq'
          ),
        ),
      ),
    );
  }

  Widget showBackground(Size screenSize) {
    return Container(
          height: screenSize.height,
          decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage('assets/background.png'),
          fit: BoxFit.fill
        )
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -47,
            width: 420,
            height: 350,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/waves.png')
                )
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _callBegin (Size screenSize) {
    return new Container(
      child: new Form(
          key: _formKey,
          child: new Stack( 
            children: <Widget>[
              showBackground(screenSize),
              showLogo(),
              showEmailInput(),
              showPrimaryButton(),
              showSecondaryButton(),
              showErrorMessage()
            ], 
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          _callBegin(screenSize),
          //_showCircularProgress()
        ],
      ),
    );
  }
}
