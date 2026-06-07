import 'package:bookia_app/core/functions/dialogs.dart';
import 'package:bookia_app/core/functions/navigation.dart';
import 'package:bookia_app/core/utils/text_styles.dart';
import 'package:bookia_app/core/widgets/custom_button.dart';
import 'package:bookia_app/features/cart/data/models/response/get_cart_response/cart_item.dart';
import 'package:bookia_app/features/cart/presentation/page/checkout_screen.dart';
import 'package:bookia_app/features/cart/presentation/widgets/cart_item.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_event.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_state.dart';
import 'package:bookia_app/features/wishlist/presentation/widgets/empty_wishlist_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is GetCartLoadingState ||
            state is RemoveFromCartLoadingState ||
            state is UpdateCartLoadingState ||
            state is CheckoutLoadingState) {
          showLoadingDialog(context);
        } else if (state is GetCartLoadedState) {
          Navigator.pop(context);
        } else if (state is UpdateCartLoadedState) {
          Navigator.pop(context);
        } else if (state is RemoveFromCartLoadedState) {
          Navigator.pop(context);
          context.read<HomeBloc>().add(GetCartEvent());
        } else if (state is CheckoutLoadedState) {
          String cartTotal =
              context.read<HomeBloc>().cartResponse?.data?.total.toString() ??
                  '';
          Navigator.pop(context);
          pushTo(context, CheckoutScreen(total: cartTotal));
        }
      },
      builder: (context, state) {
        var cart = context.read<HomeBloc>().cartResponse;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cart'),
          ),
          bottomNavigationBar: (cart?.data?.cartItems?.isNotEmpty == true)
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(22, 10, 22, 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text('Total :', style: getFont18TextStyle()),
                          const Spacer(),
                          Text('${cart?.data?.total}\$',
                              style: getFont18TextStyle()),
                        ],
                      ),
                      const Gap(16),
                      CustomButton(
                          text: 'Checkout',
                          onPressed: () {
                            context.read<HomeBloc>().add(CheckoutEvent());
                          })
                    ],
                  ),
                )
              : const SizedBox(),
          body: cart?.data?.cartItems?.isEmpty == true
              ? const EmptyWishlistWidget()
              : cartListBuilder(cart?.data?.cartItems ?? []),
        );
      },
    );
  }

  cartListBuilder(List<CartItem> cartList) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: ListView.separated(
          itemBuilder: (context, index) {
            return CartItemWidget(
              product: cartList[index],
              onRemove: () {
                context.read<HomeBloc>().add(RemoveFromCartEvent(
                    cartItemId: cartList[index].itemId ?? 0));
              },
              onAddQuantity: () {
                if ((cartList[index].itemQuantity ?? 0) <
                    (cartList[index].itemProductStock ?? 0)) {
                  context.read<HomeBloc>().add(UpdateCartEvent(
                      cartItemId: cartList[index].itemId ?? 0,
                      quantity: (cartList[index].itemQuantity ?? 0) + 1));
                } else {
                  showAppDialog(
                      context, 'Item is out of stock', DialogType.success);
                }
              },
              onMinusQuantity: () {
                if ((cartList[index].itemQuantity ?? 0) > 1) {
                  context.read<HomeBloc>().add(UpdateCartEvent(
                      cartItemId: cartList[index].itemId ?? 0,
                      quantity: (cartList[index].itemQuantity ?? 0) - 1));
                }
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(
                height: 30,
              ),
          itemCount: cartList.length),
    );
  }
}
