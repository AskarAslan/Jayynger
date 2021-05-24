import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_app/domain/user.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthorizationPage extends StatefulWidget {
  AuthorizationPage({Key key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _email;
  String _password;
  bool showLogin = true;

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Padding(
          padding: EdgeInsets.only(top: 40),
          child: Container(
              child: Align(
                  child: Text('Zhekpe-Zhek',
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )
                  )
              )
          )
      );
    }

    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obscure) {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          style: TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
              hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white30),
              hintText: hint,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 3)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54, width: 1)),
              prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: IconTheme(
                      data: IconThemeData(color: Colors.white), child: icon)
              )
          ),
        ),
      );
    }

    Widget _button(String text, void func()) {
      return RaisedButton(
        splashColor: Theme.of(context).primaryColor,
        highlightColor: Theme.of(context).primaryColor,
        color: Colors.white,
        child: Text(text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 20)),
        onPressed: () {
          func();
        },
      );
    }

    Widget _form(String label, void func()) {
      return Container(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: _input(
                    Icon(Icons.email), "EMAIL", _emailController, false)),
            Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: _input(
                    Icon(Icons.lock), "PASSWORD", _passwordController, true)),
            SizedBox(
              height:10,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: _button(label, func))),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 374,
              child: RaisedButton(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.thumb_up, size: 30),
                    Text(
                      '  Sign up with Facebook',
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                ),
                textColor: Colors.black,
                color: Colors.white,
                padding: EdgeInsets.all(10),
                onPressed: () {
                  signUpWithFacebook();
                },
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 374,
              child: RaisedButton(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.toys, size: 30),
                    Text(
                      '  Sign up with Google',
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                ),
                textColor: Colors.black,
                color: Colors.white,
                padding: EdgeInsets.all(10),
                onPressed: () {
                  _googleSignUp();
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                child: RaisedButton(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.phone, size: 30),
                        Text(
                          ' Sign up with Phone',
                          style: TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                    textColor: Colors.black,
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => _SignUpWithPhone()));
                    }),
              ),
            ),
          ],
        ),
      );
    }

    void _loginButtonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;

      if (_email.isEmpty || _password.isEmpty) return;

      User user = await _authService.signInWithEmailAndPassword(
          _email.trim(), _password.trim());
      if (user == null) {
        Fluttertoast.showToast(
            msg: "Can't SignIn you! Please check your email/password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        _emailController.clear();
        _passwordController.clear();
      }
    }

    void _registerButtonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;

      if (_email.isEmpty || _password.isEmpty) return;

      User user = await _authService.registerWithEmailAndPassword(
          _email.trim(), _password.trim());
      if (user == null) {
        Fluttertoast.showToast(
            msg: "Can't Register you! Please check your email/password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        _emailController.clear();
        _passwordController.clear();
      }
    }

    Widget _bottomWave() {
      return Expanded(
        child: Align(
          child: ClipPath(
            child: Container(
              color: Colors.white,
              height: 300,
            ),
            clipper: BottomWaveClipper(),
          ),
          alignment: Alignment.bottomCenter,
        ),
      );
    }

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: <Widget>[
            _logo(),
            SizedBox(height: 20),
            if (showLogin)
              Column(
                children: <Widget>[
                  _form('LOGIN', _loginButtonAction),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                        child: Text('Not registered yet? Register!',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        onTap: () {
                          setState(() {
                            showLogin = false;
                          });
                        }),
                  )
                ],
              )
            else
              Column(
                children: <Widget>[
                  _form('REGISTER', _registerButtonAction),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                        child: Text('Already registered? Login!',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        onTap: () {
                          setState(() {
                            showLogin = true;
                          });
                        }),
                  )
                ],
              ),
            SizedBox(
              height: 1,
            ),
            GestureDetector(
              child: Container(
                  alignment: Alignment.center,
                  child: Text("Forgot Password?",
                      style: TextStyle(fontSize: 20, color: Colors.white))),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ForgotPasswordScreen()));
              },
            ),
            _bottomWave()
          ],
        ));
  }

  Future<void> _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.displayName);

      return user;
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> signUpWithFacebook() async {
    try {
      var facebookLogin = new FacebookLogin();
      var result = await facebookLogin.logIn(['email']);

      if (result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        );
        final FirebaseUser user =
            (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        print('signed in ' + user.displayName);
        return user;
      }
    } catch (e) {
      print(e.message);
    }
  }
}

enum InputType { phone, sms }

class _SignUpWithPhone extends StatefulWidget {
  _SignUpWithPhone({Key key}) : super(key: key);

  @override
  _SignUpWithPhoneState createState() => _SignUpWithPhoneState();
}

class _SignUpWithPhoneState extends State<_SignUpWithPhone> {
  final _phoneTextController = TextEditingController();
  final _smsCodeTextController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Sign up with Phone'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _signUpTextFormField(InputType.phone),
            AnimatedContainer(
                height: _verificationId == null ? 0 : 80,
                duration: const Duration(milliseconds: 400),
                child: _verificationId != null
                    ? _signUpTextFormField(InputType.sms)
                    : Container()),
            _signUpButton(InputType.phone),
            AnimatedContainer(
                height: _verificationId == null ? 0 : 74,
                duration: const Duration(milliseconds: 400),
                child: _signUpButton(InputType.sms)),
          ],
        ),
      ),
    );
  }

  Widget _signUpTextFormField(InputType type) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        keyboardType: type == InputType.phone
            ? TextInputType.phone
            : TextInputType.number,
        decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(type == InputType.phone ? Icons.phone : Icons.sms),
            labelText: type == InputType.phone ? 'Phone' : 'SMS Code',
            hintText:
                type == InputType.phone ? '(+7) Phone number' : 'SMS Code'),
        validator: (String value) => value.trim().isEmpty
            ? type == InputType.phone
                ? 'Phone is required'
                : 'SMS Code is required'
            : null,
        controller: type == InputType.phone
            ? _phoneTextController
            : _smsCodeTextController,
      ),
    );
  }

  Widget _signUpButton(InputType type) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.all(16),
        textColor: type == InputType.phone ? Colors.black : Colors.white,
        color: type == InputType.phone ? Colors.white : Colors.blue[900],
        onPressed: () => type == InputType.phone
            ? _requestSMSCodeUsingPhoneNumber()
            : _signInWithPhoneNumberAndSMSCode(),
        child: Text(
          type == InputType.phone
              ? 'Request SMS Code'
              : 'Sign in with SMS Code',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void _requestSMSCodeUsingPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _phoneTextController.text,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential phoneAuthCredential) =>
            print('Sign up with phone complete'),
        verificationFailed: (AuthException error) =>
            print('error message is ${error.message}'),
        codeSent: (String verificationId, [int forceResendingToken]) {
          print('verificationId is $verificationId');
          setState(() => _verificationId = verificationId);
        },
        codeAutoRetrievalTimeout: null);
  }

  void _signInWithPhoneNumberAndSMSCode() async {
    final AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: _smsCodeTextController.text);
    final FirebaseUser user =
        (await FirebaseAuth.instance.signInWithCredential(authCreds)).user;
    print("User Phone number is" + user.phoneNumber);
    Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  TextEditingController editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot password"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        color: Color.fromRGBO(50, 65, 85, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: editController,
              style: TextStyle(fontSize: 22, color: Colors.white),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white30),
                hintText: "Enter Email",
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 3)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54, width: 1)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 374,
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  resetPassword(context);
                },
                child: Text(
                  "Reset password",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void resetPassword(BuildContext context) async {
    if (editController.text.length == 0 || !editController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Enter valid email");
      return;
    }

    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: editController.text);
    Fluttertoast.showToast(
        msg:
            "Reset password link has sent your mail please use it to change the password.");
    Navigator.pop(context);
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height + 1);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
