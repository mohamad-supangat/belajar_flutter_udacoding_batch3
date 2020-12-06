import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';

// eventbuss
EventBus eventBus = EventBus();

class TransactionListRefresh {}

// digunakan untuk penempatan beberapa global variable
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
