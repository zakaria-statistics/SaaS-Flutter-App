import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_web_app/features/user_auth/presentation/pages/about_page.dart';
import 'package:my_web_app/features/user_auth/presentation/pages/invoice_page.dart';
import 'package:my_web_app/features/user_auth/presentation/pages/item_page.dart';
import 'package:my_web_app/features/user_auth/presentation/pages/profile_page.dart';
import 'package:my_web_app/features/user_auth/presentation/pages/setting_page.dart';
import 'package:my_web_app/features/user_auth/presentation/pages/store_page.dart';
import 'package:my_web_app/features/user_auth/presentation/pages/cart_page.dart';
import '../features/user_auth/presentation/backend/entities/header_item.dart';
import '../features/user_auth/presentation/pages/checkout_page.dart';
import '../features/user_auth/presentation/pages/home_page1.dart';
import '../features/user_auth/presentation/pages/products_page.dart';

// Define navigation events

abstract class RoutingEvent{}

class HomeEvent extends RoutingEvent{}
class ProductsEvent extends RoutingEvent{}
class AboutEvent extends RoutingEvent{}
class ProfileEvent extends RoutingEvent{}
class PostsEvent extends RoutingEvent{}
class SettingsEvent extends RoutingEvent{}
class StoreEvent extends RoutingEvent{
  String userId;
  StoreEvent({required this.userId});
}
class ItemEvent extends RoutingEvent{
  String productId;
  ItemEvent({required this.productId});
}
class CartEvent1 extends RoutingEvent {}
class CheckoutEvent extends RoutingEvent{}
class InvoiceEvent extends RoutingEvent {
  final Map<String, String> orderDetails;
  InvoiceEvent({required this.orderDetails});
}

// Define navigation state class
class RoutingState {
  final Widget widget;
  final HeaderItem headerItem;
  final Map<String, dynamic>? orderDetails;
  RoutingState({required this.widget, required this.headerItem, this.orderDetails,});
}

// Define initial navigation state class
class InitialRoutingState extends RoutingState {
  //InitialRoutingState() : super(widget: const UsersProductsPage(), headerItem: HeaderItem(id: 2, title: 'products'));
  InitialRoutingState() : super(widget: const HomePage1(), headerItem: HeaderItem(id: 1, title: 'home'));
  //InitialRoutingState() : super(widget: StorePage(id: '',), headerItem: HeaderItem(id: 6, title: 'store'));
}

class RoutingBloc extends Bloc<RoutingEvent, RoutingState> {

  RoutingBloc():super(InitialRoutingState()){

    on((HomeEvent event, emit) {
      emit(RoutingState(widget: const HomePage1(), headerItem: HeaderItem(title: 'home', id: 1)));
    });

    on((AboutEvent event, emit) {
      emit(RoutingState(widget: AboutPage(), headerItem: HeaderItem(id: 3, title: 'about')));
    });

    on((ProductsEvent event, emit) {
      emit(RoutingState(widget: const UsersProductsPage(), headerItem: HeaderItem(title: 'products', id: 2)));
    });

    on((ProfileEvent event, emit) {
      emit(RoutingState(widget: ProfilePage(), headerItem: HeaderItem(title: 'profile', id: 4)));
    });
    on((StoreEvent event, emit) {
      emit(RoutingState(widget:  StorePage(id: event.userId,), headerItem: HeaderItem(title: 'store', id: 6)));
    });

    on((SettingsEvent event, emit) {
      emit(RoutingState(widget: const SettingPage(), headerItem: HeaderItem(title: 'settings', id: 7)));
    });

    on((ItemEvent event, emit) {
      print('what s going on');
      emit(
       RoutingState(widget: ItemPage(id: event.productId,), headerItem: HeaderItem(title: 'item', id: 8))
      );
    });
    on((CartEvent1 event, emit) {
      print(event.toString());
      emit(
          RoutingState(widget: CartScreen(), headerItem: HeaderItem(title: 'cart', id: 9))
      );
    });
    on<CheckoutEvent>((event, emit) {
      emit(RoutingState(widget: CheckoutScreen(), headerItem: HeaderItem(title: 'checkout', id: 10)));
    });
    on<InvoiceEvent>((event, emit) {
      emit(RoutingState(
        widget: InvoiceSummaryScreen(order: event.orderDetails),
        headerItem: HeaderItem(title: 'invoice', id: 11),
        orderDetails: event.orderDetails, // Pass order details to state
      ));
    });

  }

}
