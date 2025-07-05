import 'package:bookia_app/features/cart/data/models/request/place_order_params.dart';

class HomeEvent {}

class GetSlidersEvent extends HomeEvent {}

class GetNewArrivalsBooksEvent extends HomeEvent {}

class GetWishlistEvent extends HomeEvent {}

class AddToWishlistEvent extends HomeEvent {
  final int productId;

  AddToWishlistEvent({required this.productId});
}

class RemoveFromWishlistEvent extends HomeEvent {
  final int productId;

  RemoveFromWishlistEvent({required this.productId});
}

class GetCartEvent extends HomeEvent {}

class AddToCartEvent extends HomeEvent {
  final int productId;

  AddToCartEvent({required this.productId});
}

class RemoveFromCartEvent extends HomeEvent {
  final int cartItemId;

  RemoveFromCartEvent({required this.cartItemId});
}

class UpdateCartEvent extends HomeEvent {
  final int cartItemId;
  final int quantity;
  UpdateCartEvent({required this.cartItemId, required this.quantity});
}

class CheckoutEvent extends HomeEvent {}

class PlaceOrderEvent extends HomeEvent {
  final PlaceOrderParams params;
  PlaceOrderEvent({required this.params});
}
