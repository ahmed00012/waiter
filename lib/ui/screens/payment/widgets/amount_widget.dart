import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:waiter/ui/widgets/custom_text_field.dart';

import '../../../../constants/colors.dart';

class AmountWidget extends StatefulWidget {
 final String? predict1;
 final String? predict2;
 final String? predict3;
 final  String? predict4;
 final  String? remainingAmount;
 final  bool? showTextField;
  AmountWidget(
      {this.predict1,
      this.predict2,
      this.predict3,
      this.predict4,
      this.remainingAmount,
      this.showTextField});

  @override
  _AmountWidgetState createState() => _AmountWidgetState();
}

class _AmountWidgetState extends State<AmountWidget> {
  TextEditingController amount = TextEditingController();
  bool predict1Chosen = true;
  bool predict2Chosen = false;
  bool predict3Chosen = false;
  bool predict4Chosen = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.predict1.toString() != 'null')
            InkWell(
              onTap: () {
                setState(() {
                  predict1Chosen = true;
                  predict2Chosen = false;
                  predict3Chosen = false;
                  predict4Chosen = false;
                  amount.text = '';
                });
                // Navigator.pop(context,widget.predict1);
              },
              child: Container(
                height: size.height * 0.08,
                width: 250,
                decoration: BoxDecoration(
                    color: predict1Chosen ? Constants.mainColor : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color:
                          predict1Chosen ? Constants.mainColor : Colors.black12,
                    )),
                child: Center(
                  child: Text(
                    widget.predict1!,
                    style: TextStyle(
                      fontSize: size.height * 0.02,
                      color: predict1Chosen ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          if (widget.predict1.toString() != 'null')
            SizedBox(
              height: 20,
            ),
          if (widget.predict2.toString() != 'null')
            InkWell(
              onTap: () {
                setState(() {
                  predict1Chosen = false;
                  predict2Chosen = true;
                  predict3Chosen = false;
                  predict4Chosen = false;
                  amount.text = '';
                });
              },
              child: Container(
                height: size.height * 0.08,
                width: 250,
                decoration: BoxDecoration(
                    color: predict2Chosen ? Constants.mainColor : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color:
                          predict2Chosen ? Constants.mainColor : Colors.black12,
                    )),
                child: Center(
                  child: Text(
                    widget.predict2!,
                    style: TextStyle(
                      fontSize: size.height * 0.02,
                      color: predict2Chosen ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          if (widget.predict2.toString() != 'null')
            SizedBox(
              height: 20,
            ),
          if (widget.predict3.toString() != 'null')
            InkWell(
              onTap: () {
                setState(() {
                  predict1Chosen = false;
                  predict2Chosen = false;
                  predict3Chosen = true;
                  predict4Chosen = false;
                  amount.text = '';
                });
              },
              child: Container(
                height: size.height * 0.08,
                width: 250,
                decoration: BoxDecoration(
                    color: predict3Chosen ? Constants.mainColor : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color:
                          predict3Chosen ? Constants.mainColor : Colors.black12,
                    )),
                child: Center(
                  child: Text(
                    widget.predict3!,
                    style: TextStyle(
                      fontSize: size.height * 0.02,
                      color: predict3Chosen ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          if (widget.predict3.toString() != 'null')
            SizedBox(
              height: 20,
            ),
          if (widget.predict4.toString() != 'null')
            InkWell(
              onTap: () {
                setState(() {
                  predict1Chosen = false;
                  predict2Chosen = false;
                  predict3Chosen = false;
                  predict4Chosen = true;
                  amount.text = '';
                });
              },
              child: Container(
                height: size.height * 0.08,
                width: 250,
                decoration: BoxDecoration(
                    color: predict4Chosen ? Constants.mainColor : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color:
                          predict4Chosen ? Constants.mainColor : Colors.black12,
                    )),
                child: Center(
                  child: Text(
                    widget.predict4!,
                    style: TextStyle(
                      fontSize: size.height * 0.02,
                      color: predict4Chosen ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          if (widget.predict4.toString() != 'null')
            SizedBox(
              height: 20,
            ),
          if (widget.showTextField!)
            InkWell(
              onTap: () {
                setState(() {
                  predict1Chosen = false;
                  predict2Chosen = false;
                  predict3Chosen = false;
                  predict4Chosen = false;
                });
              },
              child: Container(
                width: 250,
                child: CustomTextField(
                  controller: amount,
                  label: 'anotherAmount'.tr(),
                  numerical: true,
                  onChange: (value){
                    if(value!.isNotEmpty ){
                      setState(() {
                        predict1Chosen = false;
                        predict2Chosen = false;
                        predict3Chosen = false;
                        predict4Chosen = false;
                      });

                    }
                  },
                ),
              ),
            ),
          if (widget.remainingAmount != null)
            Container(
              height: 70,
              width: 250,
              decoration: BoxDecoration(
                  color: Constants.mainColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  widget.remainingAmount!,
                  style: TextStyle(
                      fontSize: size.height * 0.02, color: Colors.white),
                ),
              ),
            ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              if (predict1Chosen && widget.remainingAmount == null) {
                Navigator.pop(context, widget.predict1);
              }
              else if (predict2Chosen) {
                Navigator.pop(context, widget.predict2);
              }
              else  if (predict3Chosen) {
                Navigator.pop(context, widget.predict3);
              }
              else  if (predict4Chosen) {
                Navigator.pop(context, widget.predict4);
              }
              else  if (amount.text.isNotEmpty) {
                Navigator.pop(context, amount.text);
              }
              else  if (widget.remainingAmount != null) {
                Navigator.pop(context, widget.remainingAmount);
                amount.text = '';
              }
            },
            child: Container(
              height: size.height * 0.08,
              width: 150,
              decoration: BoxDecoration(
                  color: Constants.mainColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  'ok'.tr(),
                  style: TextStyle(
                      color: Colors.white, fontSize: size.height * 0.025),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
