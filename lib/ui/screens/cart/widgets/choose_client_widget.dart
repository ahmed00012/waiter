import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiter/constants/styles.dart';
import 'package:waiter/models/client_model.dart';
import 'package:waiter/ui/widgets/custom_button.dart';
import 'package:waiter/ui/widgets/custom_progress_indicator.dart';
import 'package:waiter/ui/widgets/custom_text_field.dart';
import '../../../../constants/colors.dart';
import '../../../../data_controller/cart_controller.dart';

class ChooseClientWidget extends ConsumerWidget {
   ChooseClientWidget({super.key});
  final TextEditingController searchText = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final cartController = ref.watch(cartFuture);
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: searchText,
                label: 'searchHere'.tr(),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.black45,
                ),
                onChange: (text) {
                  print(text);
                  if(text!.length>3) {
                    cartController.onSearchClientTextChanged(text);
                  }
                },
              ),
            ),
            SizedBox(
              width: 20,
            ),
            CustomButton(
                height: size.height * 0.06,
                title: 'addNew'.tr(),
                onTap: () {
                  ConstantStyles.showPopup(
                    context: context,
                    height: size.height*0.4,
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomTextField(
                          controller: TextEditingController(),
                          label: 'name'.tr(),
                          suffixIcon: Icon(
                            Icons.person,
                            color: Colors.black45,
                          ),
                          onChange: (text) {
                            cartController.orderDetails.clientName = text;
                          },
                        ),
                        CustomTextField(
                          controller: TextEditingController(),
                          label: 'phone'.tr(),
                           numerical:true,
                          suffixIcon: Icon(
                            Icons.phone,
                            color: Colors.black45,
                          ),
                          onChange: (text) {
                            cartController.onSearchClientLocally(text!);
                          },
                        ),
                        CustomButton(
                            title: 'save'.tr(),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            })
                      ],
                    ),
                    title: 'addNew'.tr(),
                  );
                })
          ],
        ),

        SizedBox(
          height: size.height * 0.06,
          child: Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              SizedBox(
                  width: size.width * 0.1,
                  child: Text(
                    'client'.tr(),
                    style: const TextStyle(
                      color: Colors.black38,
                    ),
                  )),
              const Spacer(),
              SizedBox(
                  width: size.width * 0.1,
                  child: Text(
                    'phone'.tr(),
                    style: const TextStyle(
                      color: Colors.black38,
                    ),
                  )),
              const Spacer(),
              SizedBox(
                  width: size.width * 0.05,
                  child: Text(
                    'points'.tr(),
                    style: const TextStyle(
                      color: Colors.black38,
                    ),
                  )),
              const Spacer(),
              SizedBox(
                  width: size.width * 0.05,
                  child: Text(
                    'balance'.tr(),
                    style: const TextStyle(
                      color: Colors.black38,
                    ),
                  )),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        Divider(),

        Expanded(
          child: cartController.clientsLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Constants.mainColor,
                ))
              : ListView.separated(
                  itemCount: cartController.clients.length,
                  itemBuilder: (context, i) {
                    ClientModel client = cartController.clients[i];
                    return InkWell(
                      onTap: () {
                        cartController.chooseClient(
                            name: client.name!, phone: client.phone!);
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: size.height * 0.07,
                        width: size.width * 0.7,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            if (!client.allowCreateOrder)
                              const Icon(
                                Icons.block,
                                color: Colors.red,
                              ),
                            if (client.allowCreateOrder)
                              const Icon(
                                Icons.person_outline,
                                color: Constants.mainColor,
                              ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                                width: size.width * 0.1,
                                child: Text(
                                  client.name!,
                                  style: TextStyle(
                                      color: client.allowCreateOrder
                                          ? Colors.black
                                          : Colors.red),
                                )),
                            const Spacer(),
                            const Icon(
                              Icons.phone,
                              color: Constants.mainColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                                width: size.width * 0.1,
                                child: Text(
                                  client.phone!,
                                  style: TextStyle(
                                      color: client.allowCreateOrder
                                          ? Colors.black
                                          : Colors.red),
                                )),
                            const Spacer(),
                            const Icon(
                              Icons.bookmark_border,
                              color: Constants.mainColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                                width: size.width * 0.05,
                                child: Text(
                                  client.points.toString(),
                                  style: TextStyle(
                                      color: client.allowCreateOrder
                                          ? Colors.black
                                          : Colors.red),
                                )),
                            const Spacer(),
                            const Icon(
                              Icons.monetization_on_outlined,
                              color: Constants.mainColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              client.balance.toString(),
                              style: TextStyle(
                                  color: client.allowCreateOrder
                                      ? Colors.black
                                      : Colors.red),
                            ),
                            SizedBox(
                              width: 30,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                ),
        )
        //
        // SizedBox(
        //   height: 30,
        // ),
        // InkWell(
        //   onTap: () {
        //     Navigator.pop(context);
        //     viewModel.chooseClient();
        //   },
        //   child: Container(
        //     height: size.height * 0.07,
        //     width: size.width * 0.2,
        //     decoration: BoxDecoration(
        //         color: Constants.mainColor,
        //         borderRadius:
        //         BorderRadius.circular(10)),
        //     child: Center(
        //       child: Text(
        //         'save'.tr(),
        //         style: TextStyle(
        //             color: Colors.white,
        //             fontSize:
        //             size.height * 0.025),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
