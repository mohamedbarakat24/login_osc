import 'package:flutter/material.dart';
import 'package:login_osc/Screens/HomeScreen.dart';
import 'package:login_osc/main.dart';
import 'package:login_osc/sign_in/logIn.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailcontroller = TextEditingController(text: '');
  final _passwordcontroller = TextEditingController(text: '');
  final _confirmpasswordcontroller = TextEditingController(text: '');

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isloading = false;

  final _logupformkey = GlobalKey<FormState>();

  bool _obscureText = true;
  Future SignUp() async {
    if (passwordconfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailcontroller.text.trim(),
          password: _passwordcontroller.text.trim());
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    }

    final isvalid = _logupformkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isvalid) {
      setState(() {
        _isloading = true;
      });
      try {
        if (passwordconfirmed()) {
          await _auth.createUserWithEmailAndPassword(
              email: _emailcontroller.text.toLowerCase().trim(),
              password: _confirmpasswordcontroller.text.trim());
        }

        Navigator.canPop(context)
            ? Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()))
            : null;
      } catch (e) {
        setState(() {
          _isloading = false;
        });
        _ShowerrorDialog(e.toString());
      }
    } else {
      print('form isn\'t valided');
    }
    setState(() {
      _isloading = false;
    });
  }

  bool passwordconfirmed() {
    if (_passwordcontroller.text.trim() == _passwordcontroller.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _confirmpasswordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //image
                Image.asset('assets/images/Animation_netflix.gif', height: 200)
                //title
                ,
                const Text(
                  "SIGN UP",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                //subtitle
                const Text(
                  "Welcome , Here we can sign up",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),

                //Email textfield
                const SizedBox(height: 50),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     child: Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 20),
                //       child: TextField(
                //         controller: _emailcontroller,
                //         decoration: InputDecoration(
                //             border: InputBorder.none, hintText: "Email"),
                //       ),
                //     ),
                //   ),
                // ),

                Form(
                  key: _logupformkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return 'please enter a valid Email address';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              cursorColor: Colors.black87,
                              controller: _emailcontroller,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                  hintText: 'Email',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  errorBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red))),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty ||
                                    value.length < 7 ||
                                    _passwordcontroller.text.trim() !=
                                        _passwordcontroller.text.trim()) {
                                  return 'please enter a password';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              obscureText: _obscureText,
                              cursorColor: Colors.black87,
                              controller: _passwordcontroller,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    child: Icon(
                                        _obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black45),
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                  hintText: 'Password',
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  errorBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red))),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty ||
                                    value.length < 7 ||
                                    _passwordcontroller.text.trim() !=
                                        _passwordcontroller.text.trim()) {
                                  return 'please enter a password';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              obscureText: _obscureText,
                              cursorColor: Colors.black87,
                              controller: _confirmpasswordcontroller,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    child: Icon(
                                        _obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black45),
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                  hintText: 'Confirm Password',
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  errorBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //password textfield
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     child: Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 20),
                //       child: TextField(
                //         controller: _passwordcontroller,
                //         obscureText: true,
                //         decoration: InputDecoration(
                //           border: InputBorder.none,
                //           hintText: "Password",
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // //password confirmation
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     child: Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 20),
                //       child: TextField(
                //         controller: _confirmpasswordcontroller,
                //         obscureText: true,
                //         decoration: InputDecoration(
                //           border: InputBorder.none,
                //           hintText: "Confirm Password",
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                //Sign in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: SignUp,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 3, 41, 85),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                          child: Text(
                        "SIGN UP",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
                //sign up text
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'already a member?',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: Text(
                          'SIGN IN HERE',
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _ShowerrorDialog(Error) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                const Icon(Icons.error_outline),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error Occured',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 3, 41, 85),
                        fontSize: 18),
                  ),
                )
              ],
            ),
            content:
                Text('${Error}', style: const TextStyle(color: Colors.black)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.red.shade600),
                  ))
            ],
          );
        });
  }
}
