
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiter/constants/styles.dart';
import 'package:waiter/ui/screens/cart/widgets/cart_item.dart';
import 'package:waiter/ui/screens/cart/widgets/cart_upper_row.dart';
import 'package:waiter/ui/screens/cart/widgets/summary_row.dart';
import 'package:waiter/ui/screens/payment/payment_screen.dart';
import 'package:waiter/ui/widgets/bottom_nav_bar.dart';

import '../../../constants/colors.dart';
import '../../../constants/enums.dart';
import '../../../data_controller/cart_controller.dart';
import '../../../data_controller/tables_controller.dart';
import '../../../models/cart_model.dart';
import '../home/home_screen.dart';
import '../tables/tables_screen.dart';
import 'widgets/choose_client_widget.dart';
import '../tables/widgets/tables_dialog.dart';


class Cart extends ConsumerStatefulWidget {
  final bool? navigate;
  final bool? closeEdit;
  final bool? closeOrder;
  const Cart({super.key, this.navigate, this.closeEdit = false , this.closeOrder = false});

  @override
  CartState createState() => CartState();
}

class CartState extends ConsumerState<Cart> {
  SelectedTab? selectedTab;

  void cartNavigation({required OrderDetails orderDetails}) {

    if(orderDetails.orderUpdatedId == null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TablesScreen(
                    orderDetails: orderDetails,
                  )));
    }

    else{
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => PaymentScreen(order: orderDetails,
      //
      //         )));
      final tableController = ref.watch(tablesFuture);
      final cartController = ref.watch(cartFuture);
      tableController.updateOrder(orderDetails).then((value){
        cartController.closeOrder();
      });
    }


  }



  @override
  Widget build(BuildContext context) {
    // final viewModel = ref.watch(dataFuture);
    final cartController = ref.watch(cartFuture);
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [

    CartUpperRow(
        clientName: cartController.orderDetails.clientName,
        tableTitle: cartController.orderDetails.tableTitle,
        onTapChooseClient: (){
        ConstantStyles.showPopup(context: context,
        content:  ChooseClientWidget(),
        title: 'clients'.tr(), );
    },
        onTapSend: ()=> cartNavigation(orderDetails: cartController.orderDetails),
        onTapTables: (){
          if (!widget.closeEdit!) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>TablesScreen()));
          }

        }),

        Expanded(
          child: Container(
            width: size.width * 0.28,
            child: Card(
              elevation: 1,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                // alignment: Alignment.center,
                // fit: StackFit.expand,
                children: [
                  //////////////////cancel order button////////////////////////

                  if(cartController.orderDetails.cart.isNotEmpty)
                    InkWell(
                      onTap: () {
                        cartController.emptyCardList();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                            (route) => false);
                      },
                      child: Container(
                        height: size.height * 0.07,
                        width: double.infinity,
                        color: Colors.red[500],
                        child: Center(
                          child: Text(
                            // viewModel.updateOrder
                            cartController.orderDetails.orderUpdatedId != null
                                ? 'cancelEditing'.tr()
                                : 'cancelOrder'.tr(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size.height * 0.025),
                          ),
                        ),
                      ),
                    ),

/////////////////////card products/////////////////////////////////

                    Expanded(
                      // height: size.height * 0.55,

                      child: ListView.builder(
                        itemCount: cartController.orderDetails.cart.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CartItem(index: index,closeEdit: widget.closeEdit ?? false,);
                        },
                      ),
                    ),
                  // Spacer(),

                  ////////////////////////////////////summary////////////////////////////////////////
                  if(cartController.orderDetails.cart.isNotEmpty)
                  const Divider(),
                  if(cartController.orderDetails.cart.isNotEmpty)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (cartController.orderDetails.deliveryFee != 0)
                        SummaryRow(title: '${'delivery'.tr()} : ', value: '${cartController.orderDetails.deliveryFee.toStringAsFixed(2)} SAR',),

                        if (cartController.orderDetails.tax != 0)
                          SummaryRow(title:  '${'tax'.tr()}: ',
                            value: '${cartController.orderDetails.tax.toStringAsFixed(2)} SAR',),

                        if (cartController.orderDetails.discount != 0)
                          SummaryRow(title: '${'discount'.tr()}: ',
                            value: '${cartController.orderDetails.discount} SAR',),

                        const SizedBox(
                          height: 5,
                        )
                      ],
                    ),

////////////////////////////////////////////checkout button////////////////////////////////
                  if(cartController.orderDetails.cart.isNotEmpty)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {
                          cartNavigation(
                              orderDetails: cartController.orderDetails);
                        },
                        child: Container(
                          height: size.height * 0.07,
                          width: size.width,
                          color: Constants.mainColor,
                          alignment: Alignment.center,
                          child: Container(
                            width: size.width * 0.24,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * 0.085,
                                  child: Text(
                                    'pay'.tr(),
                                    style: TextStyle(
                                        fontSize: size.height * 0.025,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  width: 2,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${'total'.tr()}: ',
                                  style: TextStyle(
                                      fontSize: size.height * 0.025,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                const  Spacer(),
                                Text(
                                  '${cartController.orderDetails.total
                                          .toStringAsFixed(2)} SAR',
                                  style: TextStyle(
                                      fontSize: size.height * 0.025,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
