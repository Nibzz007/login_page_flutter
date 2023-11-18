import 'package:flutter/material.dart';
import 'package:login_sample/main.dart';
import 'package:login_sample/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String mail = 'flutter123@gmail.com';
  String pass = 'flutter';

  //bool _isDataMatched = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Center(
                      child: Text(
                        'Hello Again!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 34,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Username';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a Password';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black38,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              checkLogin();
                            } else {
                              throw Exception('Data is empty');
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(13.0),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void checkLogin() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username == mail && password == pass) {
      //gotohome
      //print('Username and Password match');

      final sharedPrefs = await SharedPreferences.getInstance();
      sharedPrefs.setBool(SAVE_KEY_NAME, true);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ScreenHome()),
      );
    } else {
      //print('Username and Password does not match');
      // //SnackBar

      const error = 'Invalid Username Or Password';

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          margin: EdgeInsets.all(10),
          content: Text(error),
        ),
      );
    }
  }

  //shared preference

  void checkUserLoggedIn() async {
    final sharedPrefs = await SharedPreferences.getInstance();

    //_sharedPrefs.setBool(SAVE_KEY_NAME, true);

    final userLoggedIn = sharedPrefs.getBool(SAVE_KEY_NAME);

    if (userLoggedIn == null || userLoggedIn == false) {
      //goToLogin();
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ScreenHome()),
      );
    }
  }
}
