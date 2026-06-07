import 'package:bookia_app/core/functions/dialogs.dart';
import 'package:bookia_app/core/functions/navigation.dart';
import 'package:bookia_app/core/utils/colors.dart';
import 'package:bookia_app/core/utils/text_styles.dart';
import 'package:bookia_app/core/widgets/custom_button.dart';
import 'package:bookia_app/core/widgets/nav_bar_widget.dart';
import 'package:bookia_app/features/cart/data/models/request/place_order_params.dart';
import 'package:bookia_app/features/cart/data/models/response/governorates_data.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_event.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, required this.total});
  final String total;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var emailController = TextEditingController();

  int? governorateId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is PlaceOrderLoadedState) {
          pushAndRemoveUntil(context, const NavBarWidget());
        } else if (state is HomeErrorState) {
          Navigator.pop(context);
          showAppDialog(context, state.message, DialogType.error);
        } else if (state is PlaceOrderLoadingState) {
          showLoadingDialog(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 10, 22, 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text('Total :', style: getFont18TextStyle()),
                    const Spacer(),
                    Text('${widget.total}\$', style: getFont18TextStyle()),
                  ],
                ),
                const Gap(16),
                CustomButton(
                    text: 'Checkout',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<HomeBloc>().add(PlaceOrderEvent(
                                params: PlaceOrderParams(
                              name: nameController.text,
                              phone: phoneController.text,
                              address: addressController.text,
                              email: emailController.text,
                              governorateId: governorateId,
                            )));
                      }
                    })
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(22),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Full Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const Gap(12),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    hintText: 'Phone',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const Gap(12),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    hintText: 'Address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const Gap(12),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const Gap(12),
                DropdownMenu(
                    enableSearch: true,
                    hintText: 'Choose Governorate',
                    expandedInsets: const EdgeInsets.all(0),
                    menuStyle: const MenuStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(AppColors.secondaryColor)),
                    inputDecorationTheme: const InputDecorationTheme(
                      fillColor: AppColors.accentColor,
                      filled: true,
                    ),
                    onSelected: (value) {
                      governorateId = value;
                    },
                    dropdownMenuEntries: governorateData.map((gov) {
                      return DropdownMenuEntry(
                        label: gov["governorate_name_en"],
                        value: gov["id"],
                      );
                    }).toList())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
