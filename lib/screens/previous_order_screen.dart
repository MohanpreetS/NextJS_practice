import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/main_drawer.dart';
import '../widgets/previous_order_card.dart';

class PreviousOrderScreen extends StatefulWidget {
  PreviousOrderScreen({Key? key}) : super(key: key);

  @override
  State<PreviousOrderScreen> createState() => _PreviousOrderScreenState();
}

class _PreviousOrderScreenState extends State<PreviousOrderScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Previous Orders"),
        actions: [
          IconButton(
            onPressed: () async {
              isLoading = true;
              await orderProvider.fetchOrders(context);
              setState(() {
                isLoading = false;
              });
            },
            icon: const Icon(
              Icons.refresh,
              size: 30,
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: ListView.builder(
                itemBuilder: (context, i) {
                  return PreviousOrderCard(
                    order: orderProvider.previousOrders[i],
                  );
                },
                itemCount: orderProvider.previousOrders.length,
              ),
            ),
    );
  }
}
