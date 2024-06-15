import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bean_bar_v2/services/shared_pref.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;

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

                Image.asset("images/logo.png", width: 200, height: 200),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

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
                        hintStyle: TextStyle(color: Colors.grey[500])

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
                        hintStyle: TextStyle(color: Colors.grey[500])),
                  ),
                ),

                const SizedBox(height: 10),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // sign in button
                GestureDetector(
                  onTap: () async {
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email_address, password: password);
                      //get the users data (Id, wallet) from the users collection in firestore. search by the email
                      // print(await SharedPreferenceHelper().getUserId());
                      // access the collection named users, get the document with the email of the user
                      // and get the data from the document

                      final FirebaseFirestore _firestore = FirebaseFirestore.instance;

                      void getUserData(String email) async {
                        QuerySnapshot querySnapshot;

                        try {
                          querySnapshot = await _firestore.collection('users').where('email', isEqualTo: email).get();

                          if (querySnapshot.docs.isNotEmpty) {
                            for (var doc in querySnapshot.docs) {
                              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                              await SharedPreferenceHelper().saveUserName(data['name']);
                              await SharedPreferenceHelper().saveUserEmail(email_address);
                              await SharedPreferenceHelper().saveUserWallet(data['Wallet']);
                              await SharedPreferenceHelper().saveUserId(data['Id']);
                            }
                          } else {
                            print('No documents found with the provided email');
                          }
                        } catch (e) {
                          print(e);
                        }
                      }

                      getUserData(email_address);




                      if (user != null) {
                        Navigator.pushNamed(context, '/nav');
                      }
                    } catch (ex) {
                      print('User Registration Unsuccessful !!!');
                    }
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
                        "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 100),

                const SizedBox(height: 30),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        'Register now',
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
