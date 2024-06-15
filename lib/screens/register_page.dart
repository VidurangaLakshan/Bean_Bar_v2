import 'package:bean_bar_v2/services/database.dart';
import 'package:bean_bar_v2/services/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;

  String name = '';
  String email_address = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[300],
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // logo
                // const Icon(
                //   Icons.account_circle,
                //   size: 200,
                // ),

                Image.asset("images/logo.png", width: 200, height: 200),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                Text(
                  'Welcome to BEAN BAR!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                // name textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Name',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // username textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      email_address = value;
                    },
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Email Address',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      password = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // confirm password textfield
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: TextField(
                //     decoration: InputDecoration(
                //         enabledBorder: const OutlineInputBorder(
                //           borderSide: BorderSide(color: Colors.black),
                //         ),
                //         focusedBorder: OutlineInputBorder(
                //           borderSide: BorderSide(color: Colors.brown),
                //         ),
                //         fillColor: Colors.grey.shade200,
                //         filled: true,
                //         hintText: 'Confirm Password',
                //         hintStyle: TextStyle(color: Colors.grey[500]),
                //     ),
                //   ),
                // ),

                const SizedBox(height: 25),

                // sign in button
                GestureDetector(
                  onTap: () async {
                    try {
                      final user = await _auth.createUserWithEmailAndPassword(
                          email: email_address, password: password);

                      String Id = randomAlphaNumeric(10);
                      Map<String, dynamic> addUserInfo = {
                        'name': name,
                        'email': email_address,
                        'Wallet': 0,
                        'Id': Id,
                      };
                      await DatabaseMethods().addUserDetail(addUserInfo, Id);
                      await SharedPreferenceHelper().saveUserName(name);
                      await SharedPreferenceHelper().saveUserEmail(email_address);
                      await SharedPreferenceHelper().saveUserWallet(0);
                      await SharedPreferenceHelper().saveUserId(Id);

                      if (user != null) {
                        Navigator.pushNamed(context, '/login');
                      }
                    } catch (ex) {
                      print('User Registration Unsuccessful !!!');
                    }
                    // Navigator.pushNamed(context, '/login');
                    // print('Email Address: $email_address');
                    // print('Password: $password');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 80),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member?',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/nav');
                      },
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
