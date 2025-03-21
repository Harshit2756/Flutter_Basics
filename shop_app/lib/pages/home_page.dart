import 'package:flutter/material.dart';
import 'package:shop_app/pages/cart_page.dart';
import 'package:shop_app/widgets/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int curentPage = 0;

  List<Widget> pages = const [ProductList(), CartPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // - Same as (curentPage == 0) ? const ProductList() : const CartPage(),
      // . IndexedStack is a widget that which displays only one child at a time based on the index and keeps the other children in the memory (with same state i.e. if we scroll down in the first page and then go to the second page and then come back to the first page, we will see that the scroll position is the same as before.)
      body: IndexedStack(
        index: curentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        currentIndex: curentPage,
        onTap: (index) {
          setState(() {
            curentPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_sharp),
            label: '',
          ),
        ],
      ),
    );
  }
}
