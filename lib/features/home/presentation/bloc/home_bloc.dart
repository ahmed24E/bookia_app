import 'package:bookia_app/features/cart/data/models/response/get_cart_response/get_cart_response.dart';
import 'package:bookia_app/features/cart/data/repo/cart_repo.dart';
import 'package:bookia_app/features/home/data/models/get_arrivals_books_response/product.dart';
import 'package:bookia_app/features/home/data/models/get_sliders_reponse/slider.dart';
import 'package:bookia_app/features/home/data/repo/home_repo.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_event.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_state.dart';
import 'package:bookia_app/features/wishlist/data/repo/wishlist_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<GetNewArrivalsBooksEvent>(getNewArrivals);
    on<GetSlidersEvent>(getSliders);
    on<GetWishlistEvent>(getWishlist);
    on<AddToWishlistEvent>(addToWishlist);
    on<RemoveFromWishlistEvent>(removeFromWishlist);
    on<GetCartEvent>(getCart);
    on<AddToCartEvent>(addToCart);
    on<RemoveFromCartEvent>(removeFromCart);
    on<UpdateCartEvent>(updateCart);
    on<CheckoutEvent>(checkout);
    on<PlaceOrderEvent>(placeOrder);
  }
  List<Product> newArrivalsBooks = [];
  List<Slider> sliders = [];

  List<Product> wishlist = [];
  GetCartResponse? cartResponse;
  Future<void> getNewArrivals(
      GetNewArrivalsBooksEvent event, Emitter<HomeState> emit) async {
    emit(NewArrivalsBooksLoadingState());

    try {
      await HomeRepo.getNewArrivalsBooks().then((value) {
        if (value != null) {
          newArrivalsBooks = value.data?.products ?? [];
          emit(NewArrivalsBooksLoadedState());
        } else {
          emit(HomeErrorState(
              message: 'Unexpected Error occur, please try again'));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: 'Unexpected Error occur, please try again'));
    }
  }

  Future<void> getSliders(
      GetSlidersEvent event, Emitter<HomeState> emit) async {
    emit(GetSlidersLoadingState());

    try {
      await HomeRepo.getSliders().then((value) {
        if (value != null) {
          sliders = value.data?.sliders ?? [];
          emit(GetSlidersLoadedState());
        } else {
          emit(HomeErrorState(
              message: 'Unexpected Error occur, please try again'));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: 'Unexpected Error occur, please try again'));
    }
  }

  Future<void> getWishlist(
      GetWishlistEvent event, Emitter<HomeState> emit) async {
    emit(GetWishlistLoadingState());

    try {
      await WishlistRepo.getWishlist().then((value) {
        if (value != null) {
          wishlist = value.data?.data ?? [];
          emit(GetWishlistLoadedState());
        } else {
          emit(HomeErrorState(
              message: 'Unexpected Error occur, please try again'));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: 'Unexpected Error occur, please try again'));
    }
  }

  Future<void> addToWishlist(
      AddToWishlistEvent event, Emitter<HomeState> emit) async {
    emit(AddToWishlistLoadingState());

    try {
      await WishlistRepo.addToWishlist(productId: event.productId)
          .then((value) {
        if (value) {
          emit(AddToWishlistLoadedState());
        } else {
          emit(HomeErrorState(
              message: 'Unexpected Error occur, please try again'));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: 'Unexpected Error occur, please try again'));
    }
  }

  Future<void> removeFromWishlist(
      RemoveFromWishlistEvent event, Emitter<HomeState> emit) async {
    emit(RemoveFromWishlistLoadingState());

    try {
      await WishlistRepo.removeFromWishlist(productId: event.productId)
          .then((value) {
        if (value) {
          emit(RemoveFromWishlistLoadedState());
        } else {
          emit(HomeErrorState(
              message: 'Unexpected Error occur, please try again'));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: 'Unexpected Error occur, please try again'));
    }
  }

  Future<void> getCart(GetCartEvent event, Emitter<HomeState> emit) async {
    emit(GetCartLoadingState());

    try {
      await CartRepo.getCart().then((value) {
        if (value != null) {
          cartResponse = value;
          emit(GetCartLoadedState());
        } else {
          emit(HomeErrorState(
              message: 'Unexpected Error occur, please try again'));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: 'Unexpected Error occur, please try again'));
    }
  }

  Future<void> addToCart(AddToCartEvent event, Emitter<HomeState> emit) async {
    emit(AddToCartLoadingState());

    try {
      await CartRepo.addToCart(productId: event.productId).then((value) {
        if (value) {
          emit(AddToCartLoadedState());
        } else {
          emit(HomeErrorState(
              message: 'Unexpected Error occur, please try again'));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: 'Unexpected Error occur, please try again'));
    }
  }

  Future<void> removeFromCart(
      RemoveFromCartEvent event, Emitter<HomeState> emit) async {
    emit(RemoveFromCartLoadingState());

    try {
      await CartRepo.removeFromCart(cartItemId: event.cartItemId).then((value) {
        if (value) {
          emit(RemoveFromCartLoadedState());
        } else {
          emit(HomeErrorState(
              message: 'Unexpected Error occur, please try again'));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: 'Unexpected Error occur, please try again'));
    }
  }

  Future<void> updateCart(
      UpdateCartEvent event, Emitter<HomeState> emit) async {
    emit(UpdateCartLoadingState());

    try {
      await CartRepo.updateCartItemQuantity(
              cartItemId: event.cartItemId, quantity: event.quantity)
          .then((value) {
        if (value != null) {
          cartResponse = value;
          emit(UpdateCartLoadedState());
        } else {
          emit(HomeErrorState(
              message: 'Unexpected Error occur, please try again'));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: 'Unexpected Error occur, please try again'));
    }
  }

  Future<void> checkout(CheckoutEvent event, Emitter<HomeState> emit) async {
    emit(CheckoutLoadingState());

    try {
      await CartRepo.checkout().then((value) {
        if (value) {
          emit(CheckoutLoadedState());
        } else {
          emit(HomeErrorState(
              message: 'Unexpected Error occur, please try again'));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: 'Unexpected Error occur, please try again'));
    }
  }

  Future<void> placeOrder(
      PlaceOrderEvent event, Emitter<HomeState> emit) async {
    emit(PlaceOrderLoadingState());

    try {
      await CartRepo.placeOrder(params: event.params).then((value) {
        if (value) {
          emit(PlaceOrderLoadedState());
        } else {
          emit(HomeErrorState(
              message: 'Unexpected Error occur, please try again'));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: 'Unexpected Error occur, please try again'));
    }
  }
}
