import 'package:bookia_app/core/constants/app_assets.dart';
import 'package:bookia_app/core/functions/dialogs.dart';
import 'package:bookia_app/core/utils/colors.dart';
import 'package:bookia_app/core/utils/text_styles.dart';
import 'package:bookia_app/core/widgets/custom_button.dart';
import 'package:bookia_app/features/home/data/models/get_arrivals_books_response/product.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_event.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key, required this.product});
  final Product product;

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is AddToWishlistLoadingState ||
            state is AddToCartLoadingState) {
          showLoadingDialog(context);
        } else if (state is AddToWishlistLoadedState) {
          Navigator.pop(context);
          showAppDialog(context, 'Added to wishlist', DialogType.success);
        } else if (state is AddToCartLoadedState) {
          Navigator.pop(context);
          showAppDialog(context, 'Added to cart', DialogType.success);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  context.read<HomeBloc>().add(
                      AddToWishlistEvent(productId: widget.product.id ?? 0));
                },
                icon: SvgPicture.asset(AppAssets.bookmark))
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 10, 22, 5),
            child: Row(
              children: [
                Text(
                  '${widget.product.priceAfterDiscount} \$',
                  style: getFont24TextStyle(),
                ),
                const Gap(45),
                Expanded(
                  child: CustomButton(
                      bgColor: AppColors.darkColor,
                      text: 'Add To Cart',
                      onPressed: () {
                        context.read<HomeBloc>().add(
                            AddToCartEvent(productId: widget.product.id ?? 0));
                      }),
                )
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(10),
                Hero(
                  tag: widget.product.id.toString(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.product.image ?? '',
                      height: 250,
                    ),
                  ),
                ),
                const Gap(12),
                Text(
                  widget.product.name ?? '',
                  textAlign: TextAlign.center,
                  style: getFont30TextStyle(),
                ),
                const Gap(10),
                Text(widget.product.category ?? '',
                    style: getFont16TextStyle(color: AppColors.primaryColor)),
                const Gap(16),
                Text(
                  widget.product.description ?? '',
                  style: getFont14TextStyle(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
