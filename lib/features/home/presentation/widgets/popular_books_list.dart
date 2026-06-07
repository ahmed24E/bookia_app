import 'package:bookia_app/core/functions/navigation.dart';
import 'package:bookia_app/core/utils/colors.dart';
import 'package:bookia_app/core/utils/text_styles.dart';
import 'package:bookia_app/core/widgets/custom_button.dart';
import 'package:bookia_app/features/home/data/models/get_arrivals_books_response/product.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_event.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_state.dart';
import 'package:bookia_app/features/home/presentation/page/book_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PopularBooksList extends StatefulWidget {
  const PopularBooksList({
    super.key,
  });

  @override
  State<PopularBooksList> createState() => _PopularBooksListState();
}

class _PopularBooksListState extends State<PopularBooksList> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetNewArrivalsBooksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (pervious, current) =>
          current is NewArrivalsBooksLoadedState ||
          current is NewArrivalsBooksLoadingState,
      builder: (context, state) {
        if (state is NewArrivalsBooksLoadedState) {
          var booksList = context.read<HomeBloc>().newArrivalsBooks;
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('New Arrival Books', style: getFont24TextStyle()),
                const Gap(10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 11,
                      mainAxisSpacing: 11,
                      mainAxisExtent: 280),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          pushTo(
                              context,
                              BookDetailsScreen(
                                product: booksList[index],
                              ));
                        },
                        child: GridBookItem(book: booksList[index]));
                  },
                  itemCount: booksList.length,
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class GridBookItem extends StatelessWidget {
  const GridBookItem({
    super.key,
    required this.book,
  });

  final Product book;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Hero(
            tag: book.id.toString(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                book.image ?? '',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          )),
          const Gap(10),
          Text(
            book.name ?? '',
            style: getFont16TextStyle(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Gap(10),
          Row(
            children: [
              Text(
                '${book.priceAfterDiscount?.toStringAsFixed(1)} EGP',
                style: getFont14TextStyle(),
              ),
              const Gap(8),
              Expanded(
                child: CustomButton(
                    bgColor: AppColors.darkColor,
                    height: 30,
                    radius: 4,
                    text: 'Buy',
                    onPressed: () {}),
              )
            ],
          )
        ],
      ),
    );
  }
}
