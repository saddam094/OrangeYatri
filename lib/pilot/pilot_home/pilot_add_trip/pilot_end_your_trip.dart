import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_yatri/constant/constant_color.dart';
import 'package:orange_yatri/pilot/pilot_home/pilot_home_page.dart';
import 'package:orange_yatri/ui/ui_helper.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PilotEndYourRide extends StatefulWidget {
  final String tripId;
  const PilotEndYourRide({super.key, required this.tripId});

  @override
  State<PilotEndYourRide> createState() => _PilotEndYourRideState();
}

class _PilotEndYourRideState extends State<PilotEndYourRide> {
  var data = {};

  Future tripEnd() async {

    var userData = {"tripId": widget.tripId};
    print(widget.tripId);

    final jsonData = json.encode(userData);
    var response;

    try {
      response = await http.put(
          Uri.parse(
              'https://000quaslq5.execute-api.ap-south-1.amazonaws.com/orange_yatri/orangeYatri_pilot_end_trip'),
          body: jsonData);

      var newResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        print('hallo-1');

        if (newResponse['body-json']['statusCode'] == 200) {
          print('hallo-2');

          showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.info(
                message: 'Trip End Successfully',
                backgroundColor: Colors.green,
                textStyle: TextStyle(
                    fontSize: 25,
                    color: Constant.textBtnColor,
                    fontWeight: FontWeight.w600),
              ),
              displayDuration: Duration(seconds: 2)
          );

          Get.offAll(PilotHomePage());

        } else if (newResponse['body-json']['statusCode'] == 400) {
          print('hallo-3');

          showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.info(
                message: newResponse['body-json']['body'],
                backgroundColor: Colors.white,
                textStyle: TextStyle(
                    fontSize: 25,
                    color: Constant.textBtnColor,
                    fontWeight: FontWeight.w600),
              ),
              displayDuration: Duration(seconds: 3)
          );

          print(newResponse['body-json']['body']);
        }

      } else {
        print('hallo-4');
        print('Failed');

        showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.info(
              message: 'Failed',
              backgroundColor: Colors.white,
              textStyle: TextStyle(
                  fontSize: 25,
                  color: Constant.textBtnColor,
                  fontWeight: FontWeight.w600),
            ),
            displayDuration: Duration(seconds: 2));
      }
    } catch (e) {
      print('saddam bhai ye Exception hai');
      print(e.toString());
    }
  }

  Future<Object> tripData() async {
    var userData = {"tripId": widget.tripId};

    final jsonData = json.encode(userData);
    var response;

    try {
      response = await http.post(
          Uri.parse(
              'https://000quaslq5.execute-api.ap-south-1.amazonaws.com/orange_yatri/orangeYatri_particular_trip_all_data'),
          body: jsonData);

      var newResponse = json.decode(response.body);

      if (newResponse['body-json']['statusCode'] == 200) {
        data = newResponse['body-json']['body'];
        print(newResponse['body-json']['body']);
      } else if (newResponse['body-json']['statusCode'] == 400) {
        print(newResponse['body-json']['body']);
      }
    } catch (e) {
      print('saddam ye Exception hai');
      print(e.toString());
    }

    return {
      'name': 'Null',
      'phone': 'Null',
      'dlNumber': 'Null',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: tripData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: Column(
              children: [
                /// Heading Container ==============================================
                Container(
                  height: Constant.height * .1,
                  width: Constant.width * 1,
                  padding: EdgeInsets.only(
                      left: Constant.width * .05, right: Constant.width * .05),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Name and Id Box
                      Column(
                        children: [
                          Text(
                            data['name'] == null
                                ? 'null'
                                : data['name'],
                            style: TextStyle(
                                fontSize: Constant.width * .07,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          Text(
                            data['dlNumber'] == null
                                ? 'null'
                                : data['dlNumber'],
                            style: TextStyle(
                                fontSize: Constant.width * .05,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          )
                        ],
                      ),

                      /// Helpline Call Box
                      Container(
                        height: Constant.height * .07,
                        width: Constant.width * .3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.call,
                              color: Colors.green,
                              size: Constant.width * .07,
                            ),
                            Text(
                              'HELP',
                              style: TextStyle(
                                  fontSize: Constant.width * .06,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                /// Details Card Container =========================================
                Container(
                  height: Constant.height * .39,
                  width: Constant.width * .95,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: Constant.height * .015),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade700,
                          blurRadius: 5,
                          spreadRadius: 1,
                        )
                      ]),
                  child: Column(
                    children: [
                      /// Image, Name, Number, DL Number, Mobile Number
                      Row(
                        children: [
                          /// Image Container
                          Container(
                            height: Constant.height * .14,
                            width: Constant.width * .28,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.shade500,
                                  width: Constant.width * .005,
                                )),
                            child: Center(
                              child: Icon(
                                Icons.person,
                                size: Constant.height * .13,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ),

                          SizedBox(
                            width: Constant.width * .05,
                          ),

                          /// Nmae, Number, DL, Mobile Number
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['vehicleName'] == null
                                    ? 'null'
                                    : data['vehicleName'],
                                style: TextStyle(
                                    fontSize: Constant.width * .05, fontWeight: FontWeight.w600, fontFamily: 'PopinsBlack'),
                              ),
                              Text(
                                data['vehicleNumber'] == null
                                    ? 'null'
                                    : data['vehicleNumber'],
                                style: TextStyle(
                                    fontSize: Constant.width * .05,
                                    fontWeight: FontWeight.w400,
                                    color: Constant.textColor),
                              ),
                              Text(
                                data['dlNumber'] == null
                                    ? 'null'
                                    :'DL : ' + data['dlNumber'],
                                style: TextStyle(
                                    fontSize: Constant.width * .05,
                                    fontWeight: FontWeight.w400,
                                    color: Constant.textColor),
                              ),
                              Text(
                                data['phone'] == null
                                    ? 'null'
                                    : 'Mob : ' + data['phone'],
                                style: TextStyle(
                                    fontSize: Constant.width * .05,
                                    fontWeight: FontWeight.w400,
                                    color: Constant.textColor),
                              ),
                            ],
                          )
                        ],
                      ),

                      /// Trip Start Date
                      Row(
                        children: [
                          Text(
                            'Trip Start Date : ',
                            style: TextStyle(
                                fontSize: Constant.width * .05,
                                fontWeight: FontWeight.w600,
                                color: Constant.color1,
                                fontFamily: 'FontMain'
                            ),
                          ),
                          Text(
                            data['date'] == null ? 'null' : data['date'],
                            style: TextStyle(
                                fontSize: Constant.width * .05,
                                fontWeight: FontWeight.w400,
                                color: Constant.textColor),
                          )
                        ],
                      ),

                      /// Trip start Time
                      Row(
                        children: [
                          Text(
                            'Trip Start Time : ',
                            style: TextStyle(
                                fontSize: Constant.width * .05,
                                fontWeight: FontWeight.w600,
                                color: Constant.color1,
                                fontFamily: 'FontMain'
                            ),
                          ),
                          Text(
                            data['time'] == null ? 'null' : data['time'],
                            style: TextStyle(
                                fontSize: Constant.width * .05,
                                fontWeight: FontWeight.w400,
                                color: Constant.textColor),
                          )
                        ],
                      ),

                      /// Goods Details
                      Row(
                        children: [
                          Text(
                            'Goods Details : ',
                            style: TextStyle(
                                fontSize: Constant.width * .05,
                                fontWeight: FontWeight.w600,
                                color: Constant.color1,
                                fontFamily: 'FontMain'
                            ),
                          ),
                          Text(
                            data['goodsDetails'] == null
                                ? 'null'
                                : data['goodsDetails'],
                            style: TextStyle(
                                fontSize: Constant.width * .05,
                                fontWeight: FontWeight.w400,
                                color: Constant.textColor),
                          )
                        ],
                      ),

                      /// Goods Weight
                      Row(
                        children: [
                          Text(
                            'Goods Weight : ',
                            style: TextStyle(
                                fontSize: Constant.width * .05,
                                fontWeight: FontWeight.w600,
                                color: Constant.color1,
                                fontFamily: 'FontMain'
                            ),
                          ),
                          Text(
                            data['goodsWeight'] == null
                                ? 'null'
                                : data['goodsWeight'],
                            style: TextStyle(
                                fontSize: Constant.width * .05,
                                fontWeight: FontWeight.w400,
                                color: Constant.textColor),
                          )
                        ],
                      ),

                      /// Pickup Address Delivery Address
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Pickup Address
                          Container(
                            height: Constant.height * .09,
                            width: Constant.width * .44,
                            // color: Colors.red,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pickup Address',
                                  style: TextStyle(
                                      fontSize: Constant.width * .05,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                      fontFamily: 'FontMain'
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    data['pickUpAddress'] == null
                                        ? 'null'
                                        : data['pickUpAddress'],
                                    style: TextStyle(
                                        fontSize: Constant.width * .04,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                    maxLines: 2,
                                  ),
                                )
                              ],
                            ),
                          ),

                          /// Delivery Address
                          Container(
                            height: Constant.height * .09,
                            width: Constant.width * .44,
                            // color: Colors.yellowAccent,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Delivery Address',
                                  style: TextStyle(
                                      fontSize: Constant.width * .05,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                      fontFamily: 'FontMain'
                                  ),
                                ),
                                Text(
                                  data['deliveryAddress'] == null
                                      ? 'null'
                                      : data['deliveryAddress'],
                                  style: TextStyle(
                                      fontSize: Constant.width * .04,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                  maxLines: 2,
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),

                /// QR Code Box
                Container(
                  margin: EdgeInsets.only(
                      top: Constant.height * .03,
                      bottom: Constant.height * .03
                  ),
                  height: Constant.height * .34,
                  width: Constant.height * .34,
                  // color: Colors.grey.shade100,
                  child: QrImageView(
                    data: data['tripId'],
                    version: QrVersions.auto,
                    size: Constant.height * .34,
                  ),
                ),

                /// End Your Ride Button
                UiHelper.customButton(() {

                  tripEnd();

                }, 'End Your Ride')
              ],
            ),
          );
        }
      },
    ));
  }
}
