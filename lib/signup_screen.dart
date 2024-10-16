import 'package:flutter/material.dart';

import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  double _screenHeight = 0;
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              SizedBox(
                height: _screenHeight * 0.2,
                child: Image(
                  image: AssetImage('assets/images/t_logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                'Muscle Imbalance Prediction',
                style: TextStyle(
                  fontSize: _screenHeight * 0.022,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: _screenHeight * 0.02,
              ),
              Text(
                'SIGNUP',
                style: TextStyle(
                  fontSize: _screenHeight * 0.03,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: _screenHeight * 0.02,
              ),
              Form(
                key: _globalKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: TextFormField(
                        controller: _controller1,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          hintText: 'Enter Username',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(45)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(45)),
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter username";
                          }
                          return null;
                        },
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: _screenHeight * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: TextFormField(
                        controller: _controller1,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter Email',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(45)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(45)),
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Email";
                          }
                          return null;
                        },
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: _screenHeight * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: TextFormField(
                        controller: _controller1,
                        decoration: const InputDecoration(
                          labelText: 'Enter Password',
                          hintText: 'Enter Password',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(45)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(45)),
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Password";
                          }
                          return null;
                        },
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: _screenHeight * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: TextFormField(
                        controller: _controller2,
                        obscureText: true,
                        autocorrect: false,
                        enableSuggestions: false,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Confirm Password',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(45)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(45)),
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm Password';
                          }
                          return null;
                        },
                        style: const TextStyle(fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: _screenHeight * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 125),
                child: Container(
                  height: _screenHeight * 0.06,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(45)),
                  child: TextButton(
                    onPressed: _login,
                    child: const Text(
                      'Sign UP',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _screenHeight * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already Registered?',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  TextButton(
                    onPressed: _login,
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 15, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void _login() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
