import 'package:flutter/material.dart';
import 'package:sound_byte/services/authentication.dart';
import 'package:sound_byte/model/user.dart';

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;

  bool _isLoginForm;
  bool _isLoading;

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
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          //widget.auth.sendEmailVerification();
          //_showVerifyEmailSentDialog();
          print('Signed up user: $userId');
        }
        User.currentUser = await User.userFromDatabase(userId);
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null && _isLoginForm) {
          _isLoading = true;
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          _callBegin(),
          //_showCircularProgress()
        ],
      ),
    );
  }

  Widget _callBegin () {
    return new Container(
      child: new Form(
          key: _formKey,
          child: new Stack( 
            children: <Widget>[
              showBackground(),
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

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }
  
  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 45.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showLogo() {
    return Container(
      child: Positioned(
        top: 210,
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

  Widget showEmailInput() {
    return SingleChildScrollView( //helps MOVE KEYBOARD
      padding: EdgeInsets.only(left: 50, right: 50, top: 300),
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
                  Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                     child: new TextFormField(
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

  Widget showSecondaryButton() {
    return Container(
      padding: _isLoginForm ? EdgeInsets.fromLTRB(100, 600, 0, 0) : EdgeInsets.fromLTRB(80, 600, 0, 0),
    
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
          padding: _isLoginForm ? EdgeInsets.fromLTRB(160, 480, 0, 100) : EdgeInsets.fromLTRB(125, 480, 0, 100),
          //padding: EdgeInsets.fromLTRB(160, 450, 0, 100),
          child: RaisedButton(
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

  Widget showBackground() {
    return Container(
          height: 683,
          decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage('assets/background.png'),
          fit: BoxFit.fill
        )
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -20,
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
}
