import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';
import '../providers/orders.dart';
import '../providers/auth.dart';
import '../widgets/previous_order_card.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (Provider.of<Orders>(context, listen: false).previousOrders.length ==
        0) {
      await Provider.of<Auth>(context, listen: false).doFetching(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Active Orders"),
        actions: [
          IconButton(
            onPressed: () async {
              await orderProvider.fetchOrders(context);
              setState(() {});
            },
            icon: const Icon(
              Icons.refresh,
              size: 30,
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: (orderProvider.currentOrders.isEmpty)
            ? const Center(
                child: Text("No current orders"),
              )
            : ListView.builder(
                itemBuilder: (context, i) {
                  return PreviousOrderCard(
                    order: orderProvider.currentOrders[i],
                  );
                },
                itemCount: orderProvider.currentOrders.length,
              ),
      ),
    );
  }
}
