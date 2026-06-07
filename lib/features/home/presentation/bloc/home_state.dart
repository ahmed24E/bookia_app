class HomeState {}

class HomeInitialState extends HomeState {}

// new arrivals
class GetSlidersLoadingState extends HomeState {}

class GetSlidersLoadedState extends HomeState {}

class NewArrivalsBooksLoadingState extends HomeState {}

class NewArrivalsBooksLoadedState extends HomeState {}

// wishlist
class GetWishlistLoadingState extends HomeState {}

class GetWishlistLoadedState extends HomeState {}

class AddToWishlistLoadingState extends HomeState {}

class AddToWishlistLoadedState extends HomeState {}

class RemoveFromWishlistLoadingState extends HomeState {}

class RemoveFromWishlistLoadedState extends HomeState {}

/// cart
class GetCartLoadingState extends HomeState {}

class GetCartLoadedState extends HomeState {}

class UpdateCartLoadingState extends HomeState {}

class UpdateCartLoadedState extends HomeState {}

class AddToCartLoadingState extends HomeState {}

class AddToCartLoadedState extends HomeState {}

class RemoveFromCartLoadingState extends HomeState {}

class RemoveFromCartLoadedState extends HomeState {}

// checkout
class CheckoutLoadingState extends HomeState {}

class CheckoutLoadedState extends HomeState {}

class PlaceOrderLoadingState extends HomeState {}

class PlaceOrderLoadedState extends HomeState {}

class HomeErrorState extends HomeState {
  String message;
  HomeErrorState({required this.message});
}
