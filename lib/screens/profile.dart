// import 'dart:io';
//
// import 'package:bean_bar_v2/services/auth.dart';
// import 'package:bean_bar_v2/services/shared_pref.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:bean_bar_v2/screens/home.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:random_string/random_string.dart';
//
// class Profile extends StatefulWidget {
//   const Profile({super.key});
//
//   @override
//   State<Profile> createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//   String? profile, name, email;
//   final ImagePicker _picker = ImagePicker();
//   File? selectedImage;
//
//   Future getImage() async {
//     var image = await _picker.pickImage(source: ImageSource.camera);
//
//     selectedImage = File(image!.path);
//     setState(() {
//       uploadItem();
//     });
//   }
//
//   uploadItem() async {
//     if (selectedImage != null) {
//       String addId = randomAlphaNumeric(10);
//
//       Reference firebaseStorageRef =
//           FirebaseStorage.instance.ref().child("profileImages").child(addId);
//       final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
//
//       var downloadUrl = await (await task).ref.getDownloadURL();
//       await SharedPreferenceHelper().saveUserProfile(downloadUrl);
//       setState(() {});
//     }
//   }
//
//   getthesharedpref() async {
//     profile = await SharedPreferenceHelper().getUserProfile();
//     name = await SharedPreferenceHelper().getUserName();
//     email = await SharedPreferenceHelper().getUserEmail();
//     setState(() {});
//   }
//
//   onthisload() async {
//     await getthesharedpref();
//     setState(() {});
//   }
//
//   @override
//   void initState() {
//     onthisload();
//     super.initState();
//   }
//
//   // print(await SharedPreferenceHelper().getUserName());
//
//   @override
//   Widget build(BuildContext context) {
//     final Brightness brightnessValue =
//         MediaQuery.of(context).platformBrightness;
//     bool isDark = brightnessValue == Brightness.dark;
//
//     return Scaffold(
//       body: Container(
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           physics: BouncingScrollPhysics(),
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.only(top: 45, left: 20, right: 20),
//                     height: MediaQuery.of(context).size.height / 4.3,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                       color: isDark ? Colors.white70 : Colors.black,
//                       borderRadius: BorderRadius.vertical(
//                           bottom: Radius.elliptical(
//                               MediaQuery.of(context).size.width, 105)),
//                     ),
//                   ),
//                   Center(
//                     child: Container(
//                       margin: EdgeInsets.only(
//                           top: MediaQuery.of(context).size.height / 6.5),
//                       child: Material(
//                         elevation: 10,
//                         borderRadius: BorderRadius.circular(60),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(60),
//                           child: selectedImage == null
//                               ? GestureDetector(
//                                   onTap: () {
//                                     getImage();
//                                   },
//                                   child: profile == null
//                                       ? Image.asset(
//                                           'images/boy.jpg',
//                                           height: 120,
//                                           width: 120,
//                                           fit: BoxFit.cover,
//                                         )
//                                       : Image.network(
//                                           profile!,
//                                           height: 120,
//                                           width: 120,
//                                           fit: BoxFit.cover,
//                                         ),
//                                 )
//                               : Image.file(
//                                   selectedImage!,
//                                   height: 120,
//                                   width: 120,
//                                   fit: BoxFit.cover,
//                                 ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 70),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('Name',
//                             style: TextStyle(
//                                 fontSize: 25,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white)),
//                       ],
//                     ),
//                   ),
//
//                   SizedBox(height: 20),
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 20),
//                     child: Material(
//                       borderRadius: BorderRadius.circular(10),
//                       elevation: 2,
//                       child: Container(
//                         padding:
//                             EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.person,
//                               color: Colors.black,
//                             ),
//                             SizedBox(width: 20),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Name',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 Text(
//                                   'Viduranga Lakshan',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 20),
//                     child: Material(
//                       borderRadius: BorderRadius.circular(10),
//                       elevation: 2,
//                       child: Container(
//                         padding:
//                             EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.email,
//                               color: Colors.black,
//                             ),
//                             SizedBox(width: 20),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Email',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 Text(
//                                   'vidurangalakshan2020@gmail.com',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 20),
//                     child: Material(
//                       borderRadius: BorderRadius.circular(10),
//                       elevation: 2,
//                       child: Container(
//                         padding:
//                             EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.description,
//                               color: Colors.black,
//                             ),
//                             SizedBox(width: 20),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Terms and Conditions',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   // Container(
//                   //   margin: EdgeInsets.symmetric(horizontal: 20),
//                   //   child: Material(
//                   //     borderRadius: BorderRadius.circular(10),
//                   //     elevation: 2,
//                   //     child: Container(
//                   //       padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//                   //       decoration: BoxDecoration(
//                   //         color: Colors.white,
//                   //         borderRadius: BorderRadius.circular(10),
//                   //       ),
//                   //       child: Row(
//                   //         children: [
//                   //           Icon(
//                   //             Icons.dark_mode,
//                   //             color: Colors.black,
//                   //           ),
//                   //           SizedBox(width: 20),
//                   //           Column(
//                   //             crossAxisAlignment: CrossAxisAlignment.start,
//                   //             children: [
//                   //               Text(
//                   //                 'Dark Mode',
//                   //                 style: TextStyle(
//                   //                   fontSize: 20,
//                   //                   fontWeight: FontWeight.w600,
//                   //                   color: Colors.black,
//                   //                 ),
//                   //               ),
//                   //             ],
//                   //           ),
//                   //         ],
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                   // SizedBox(height: 20),
//                   GestureDetector(
//                     onTap: () {
//                       AuthMethods().deleteuser();
//                     },
//                     child: Container(
//                       margin: EdgeInsets.symmetric(horizontal: 20),
//                       child: Material(
//                         borderRadius: BorderRadius.circular(10),
//                         elevation: 2,
//                         child: Container(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 15, horizontal: 10),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.delete,
//                                 color: Colors.black,
//                               ),
//                               SizedBox(width: 20),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Delete Account',
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   GestureDetector(
//                     onTap: () async {
//                       await FirebaseAuth.instance.signOut();
//                       Navigator.pushNamed(context, '/login');
//                     },
//                     // onTap: () {
//                     //   Navigator.pushReplacement(
//                     //       context, MaterialPageRoute(builder: (context) => Home()));
//                     // },
//                     child: Container(
//                       margin: EdgeInsets.symmetric(horizontal: 20),
//                       child: Material(
//                         borderRadius: BorderRadius.circular(10),
//                         elevation: 2,
//                         child: Container(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 15, horizontal: 10),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.logout,
//                                 color: Colors.black,
//                               ),
//                               SizedBox(width: 20),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Log Out',
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 40),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:bean_bar_v2/services/auth.dart';
import 'package:bean_bar_v2/services/shared_pref.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? profile, name, email;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    selectedImage = File(image!.path);
    setState(() {
      uploadItem();
    });
  }

  uploadItem() async {
    if (selectedImage != null) {
      String addId = randomAlphaNumeric(10);

      Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child("blogImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL();
      await SharedPreferenceHelper().saveUserProfile(downloadUrl);
      setState(() {

      });
    }
  }

  getthesharedpref() async {
    profile = await SharedPreferenceHelper().getUserProfile();
    name = await SharedPreferenceHelper().getUserName();
    email = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  onthisload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    onthisload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: name==null? CircularProgressIndicator(): Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
                  height: MediaQuery.of(context).size.height / 4.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              MediaQuery.of(context).size.width, 105.0))),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 6.5),
                    child: Material(
                      elevation: 10.0,
                      borderRadius: BorderRadius.circular(60),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: selectedImage==null?  GestureDetector(
                          onTap: (){
                            getImage();
                          },
                          child: profile==null? Image.asset("images/boy.jpg", height: 120, width: 120, fit: BoxFit.cover,) :Image.network(
                            profile!,
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ): Image.file(selectedImage!,  height: 120,
                          width: 120,
                          fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 70.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name!,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 2.0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            name!,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 2.0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            email!,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 2.0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.description,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Terms and Condition",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            GestureDetector(
              onTap: (){
                AuthMethods().deleteuser();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 2.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delete Account",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            GestureDetector(
              onTap: (){
                AuthMethods().SignOut();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 2.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Logout",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
