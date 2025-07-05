import 'package:bookia_app/core/functions/dialogs.dart';
import 'package:bookia_app/features/home/data/models/get_arrivals_books_response/product.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_event.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_state.dart';
import 'package:bookia_app/features/wishlist/presentation/widgets/empty_wishlist_widget.dart';
import 'package:bookia_app/features/wishlist/presentation/widgets/wishlist_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetWishlistEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is GetWishlistLoadingState ||
            state is AddToCartLoadingState ||
            state is RemoveFromWishlistLoadingState) {
          showLoadingDialog(context);
        } else if (state is GetWishlistLoadedState) {
          Navigator.pop(context);
        } else if (state is RemoveFromWishlistLoadedState) {
          Navigator.pop(context);
          context.read<HomeBloc>().add(GetWishlistEvent());
        } else if (state is AddToCartLoadedState) {
          Navigator.pop(context);
          showAppDialog(context, 'Added to cart', DialogType.success);
        }
      },
      builder: (context, state) {
        var wishlist = context.read<HomeBloc>().wishlist;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Wishlist'),
          ),
          body: wishlist.isEmpty
              ? const EmptyWishlistWidget()
              : wishlistBuilder(wishlist),
        );
      },
    );
  }

  wishlistBuilder(List<Product> wishlist) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: ListView.separated(
          itemBuilder: (context, index) {
            return WishlistItem(
              product: wishlist[index],
              onRemove: () {
                context.read<HomeBloc>().add(RemoveFromWishlistEvent(
                    productId: wishlist[index].id ?? 0));
              },
              onAddToCart: () {
                context
                    .read<HomeBloc>()
                    .add(AddToCartEvent(productId: wishlist[index].id ?? 0));
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(
                height: 30,
              ),
          itemCount: wishlist.length),
    );
  }
}
