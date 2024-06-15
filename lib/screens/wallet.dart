import 'dart:ffi';

import 'package:bean_bar_v2/services/database.dart';
import 'package:bean_bar_v2/services/shared_pref.dart';
import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  // String? wallet = '0.00';
  String? id;
  int wallet = 0;
  int tempMoney = 0;

  getthesharedpref() async {
    wallet = (await SharedPreferenceHelper().getUserWallet()) as int;
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;

    return Scaffold(
      body: wallet == null ? CircularProgressIndicator() : Container(
        margin: EdgeInsets.only(top: 60),
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
                      'Wallet',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black),
                    )))),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: isDark ? Colors.black : Color(0xfff2f2f2),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "images/wallet.png",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Wallet',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'LKR ' + wallet.toString() + '.00',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text('Add money',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black)),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    print(id);
                    // makePayment(100);
                    tempMoney = tempMoney + 100;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffe9e2e2)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      '  100  ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // makePayment(500);
                    tempMoney = tempMoney + 500;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffe9e2e2)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      '  500  ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // makePayment(1000);
                    tempMoney = tempMoney + 1000;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffe9e2e2)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      ' 1000 ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // makePayment(2000);
                    tempMoney = tempMoney + 2000;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffe9e2e2)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      ' 2000 ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: id == null ? null : () {
                makePayment(tempMoney);
                tempMoney = 0;
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 12),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xff008080),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Add ' + tempMoney.toString() + ".00",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> makePayment(int amount) async {
    ///now finally display payment sheet
    //   displayPaymentSheet(amount);
    wallet = wallet + amount;
    await SharedPreferenceHelper().saveUserWallet(wallet);
    await getthesharedpref();
    await DatabaseMethods().UpdateUserWallet(id!, wallet);
    // tempMoney = amount;
    // int.parse(wallet!);
  }
}
