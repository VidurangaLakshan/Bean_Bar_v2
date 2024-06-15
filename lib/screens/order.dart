import 'dart:async';

import 'package:bean_bar_v2/screens/success.dart';
import 'package:bean_bar_v2/services/database.dart';
import 'package:bean_bar_v2/services/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? id;
  int? wallet;
  int total = 0, amount2 = 0;

  void startTimer() {
    Timer(Duration(seconds: 1), () {
      setState(() {});
    });
  }

  getthesharedpref() async {
    id = await SharedPreferenceHelper().getUserId();
    wallet = await SharedPreferenceHelper().getUserWallet();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    foodStream = await DatabaseMethods().getFoodCart(id!);
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    startTimer();
    super.initState();
  }

  Stream? foodStream;

  Widget foodCart() {
    return StreamBuilder(
        stream: foodStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    total = total + int.parse(ds["Total"]);
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Material(
                            elevation: 5,
                            shadowColor: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Column(children: [
                                    Container(
                                      height: 42,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child:
                                          Center(child: Text(ds["Quantity"])),
                                    ),
                                    SizedBox(height: 6),
                                    GestureDetector(
                                      onTap: () async {
                                        await DatabaseMethods()
                                            .deleteFoodCart(id!, ds.id);
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 42,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                            child: Text(
                                          'X',
                                          style: TextStyle(color: Colors.red),
                                        )),
                                      ),
                                    ),
                                  ]),
                                  SizedBox(width: 20),
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Image.network(
                                        ds["Image"],
                                        height: 90,
                                        width: 90,
                                        fit: BoxFit.cover,
                                      )),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Column(children: [
                                      Text(ds["Name"],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          'LKR ' +
                                              ds["Total"].toString() +
                                              '.00',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ]),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2,
              shadowColor: isDark ? Colors.white : Colors.black,
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Text(
                    'Bean Cart',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
                height: MediaQuery.of(context).size.height / 1.7,
                child: foodCart()),
            // Container(
            //   margin: EdgeInsets.only(left: 20, right: 20),
            //   child: Material(
            //     elevation: 5,
            //     shadowColor: isDark ? Colors.white : Colors.black,
            //     borderRadius: BorderRadius.circular(10),
            //     child: Container(
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       padding: EdgeInsets.all(10),
            //       child: Row(
            //         children: [
            //           Column(children: [
            //             Container(
            //               height: 42,
            //               width: 40,
            //               decoration: BoxDecoration(
            //                 border: Border.all(
            //                   color: isDark ? Colors.white : Colors.black,
            //                 ),
            //                 borderRadius: BorderRadius.circular(10),
            //               ),
            //               child: Center(child: Text('2')),
            //             ),
            //             SizedBox(height: 6),
            //             Container(
            //               height: 42,
            //               width: 40,
            //               decoration: BoxDecoration(
            //                 border: Border.all(
            //                   color: isDark ? Colors.white : Colors.black,
            //                 ),
            //                 borderRadius: BorderRadius.circular(10),
            //               ),
            //               child: Center(
            //                   child: Text(
            //                 'X',
            //                 style: TextStyle(color: Colors.red),
            //               )),
            //             ),
            //           ]),
            //           SizedBox(width: 20),
            //           ClipRRect(
            //               borderRadius: BorderRadius.circular(60),
            //               child: Image.asset(
            //                 'images/ice-cream1.jpg',
            //                 height: 90,
            //                 width: 90,
            //                 fit: BoxFit.cover,
            //               )),
            //           SizedBox(width: 20),
            //           Column(children: [
            //             Text('Chocolate Ice...',
            //                 style: TextStyle(
            //                     fontSize: 20, fontWeight: FontWeight.bold)),
            //             Text('LKR 600.00',
            //                 style: TextStyle(
            //                     fontSize: 20, fontWeight: FontWeight.bold)),
            //           ])
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 10),
            // Container(
            //   margin: EdgeInsets.only(left: 20, right: 20),
            //   child: Material(
            //     elevation: 5,
            //     shadowColor: isDark ? Colors.white : Colors.black,
            //     borderRadius: BorderRadius.circular(10),
            //     child: Container(
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       padding: EdgeInsets.all(10),
            //       child: Row(
            //         children: [
            //           Column(
            //             children: [
            //               Container(
            //                 height: 42,
            //                 width: 40,
            //                 decoration: BoxDecoration(
            //                   border: Border.all(
            //                     color: isDark ? Colors.white : Colors.black,
            //                   ),
            //                   borderRadius: BorderRadius.circular(10),
            //                 ),
            //                 child: Center(child: Text('1')),
            //               ),
            //               SizedBox(
            //                 height: 6,
            //               ),
            //               Container(
            //                 height: 42,
            //                 width: 40,
            //                 decoration: BoxDecoration(
            //                   border: Border.all(
            //                     color: isDark ? Colors.white : Colors.black,
            //                   ),
            //                   borderRadius: BorderRadius.circular(10),
            //                 ),
            //                 child: Center(
            //                     child: Text(
            //                   'X',
            //                   style: TextStyle(color: Colors.red),
            //                 )),
            //               ),
            //             ],
            //           ),
            //           SizedBox(width: 20),
            //           ClipRRect(
            //               borderRadius: BorderRadius.circular(60),
            //               child: Image.asset(
            //                 'images/special.png',
            //                 height: 90,
            //                 width: 90,
            //                 fit: BoxFit.cover,
            //               )),
            //           SizedBox(width: 20),
            //           Column(children: [
            //             Text('Today\'s Special',
            //                 style: TextStyle(
            //                     fontSize: 20, fontWeight: FontWeight.bold)),
            //             Text('LKR 700.00',
            //                 style: TextStyle(
            //                     fontSize: 20, fontWeight: FontWeight.bold)),
            //           ])
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            Spacer(),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Price',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'LKR ' + total.toString() + '.00',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                int amount = wallet! - total;
                await DatabaseMethods().UpdateUserWallet(id!, amount);
                await SharedPreferenceHelper().saveUserWallet(amount);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Success();
                }));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white38 : Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Center(
                    child: Text(
                  'Checkout',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
