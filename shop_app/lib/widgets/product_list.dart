import 'package:flutter/material.dart';
import 'package:shop_app/global_variables.dart';
import 'package:shop_app/widgets/product_card.dart';
import 'package:shop_app/pages/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  // * List of filters
  final List<String> filters = const [
    'All',
    'Addidas',
    'Nike',
    'Bata',
  ];

  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    //* variable
    // * Border for the search bar
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
        right: Radius.circular(50),
      ),
    );

    // * Screen Size
    // . MediaQuery is a widget that provides access to the size and orientation of the screen.
    // . If we want to access only the size of the screen, we can use MediaQuery.sizeOf(context).
    // . MediaQuery.of(context).size returns the size of the screen and will have access when the pixelratio changes.
    // final screensize = MediaQuery.sizeOf(context);

    // . SafeArea is a widget that makes sure that the content is not hidden by the status bar or the notch.
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              // * Heading
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Shoes\nCollection',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              // * Search bar
              // . Expanded is a widget that makes sure that the child widget takes up all the available space.
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ],
          ),
          // * Filter
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //. GestureDetector is a widget that detects gestures.
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    //. Chip is a widget that displays a label in a rounded container.
                    child: Chip(
                      label: Text(
                        filters[index],
                      ),
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),

                      //. theme.of(context) accesses the theme present in the nearest ancestor Theme widget.
                      backgroundColor: (selectedFilter == filter
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromRGBO(245, 247, 249, 1)),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 205, 214, 223),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ~ Stack
          // . Stack is a widget that positions its children relative to the edges of its box on top of each other.
          // Stack(
          //   children: [
          //     // * Background image
          //     Image.asset(
          //       'assets/images/shoes_4.png',
          //       fit: BoxFit.cover,
          //       width: double.infinity,
          //       height: 300,
          //     ),
          //     // * Text
          //     Positioned(
          //       top: 50,
          //       left: 20,
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text('New\nCollection',
          //               style: Theme.of(context).textTheme.titleLarge),
          //           const SizedBox(
          //             height: 20,
          //           ),
          //           Text('SHOP NOW',
          //               style: Theme.of(context).textTheme.bodySmall),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          // * Products

          // ~ LayoutBuilder
          // . LayoutBuilder is a widget that provides the constraints of the parent widget to its builder function.
          // . It is used when we want to build a widget based on the constraints of the parent widget.
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 1080) {
                  return GridView.builder(
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, //  Number of grid items in a row
                      childAspectRatio:
                          1.75, //  Ratio of the width to the height of each grid item
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductDetailsPage(
                                  product: product,
                                );
                              },
                            ),
                          );
                        },
                        child: ProductCard(
                          title: product['title'] as String,
                          imageUrl: product['imageUrl'] as String,
                          price: product['price'] as double,
                          backgroundColor: (index % 2 == 0
                              ? const Color.fromRGBO(216, 240, 253, 1)
                              : const Color.fromRGBO(245, 247, 249, 1)),
                          borderColor: (index % 2 == 0
                              ? const Color.fromRGBO(0, 122, 255, 1)
                              : const Color.fromRGBO(205, 214, 223, 1)),
                        ),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          // ~ Navigator
                          //. A route represents a single page in the app and can be pushed onto a stack of routes to allow the user to navigate back and forth between pages. Routes can be named and the app can navigate to a named route.
                          // . Routes are managed by the Navigator widget, which maintains a stack of routes and provides methods for pushing and popping routes onto and off of the stack
                          // . The of() method is a static method of the Navigator class that returns the NavigatorState for the nearest Navigator ancestor of the current context.
                          // . so we are pushing a route to the navigator. Which is building a new screen with the ProductDetailsPage widget.
                          // . MaterialPageRoute is a widget that defines an adaptive transition from one page to another.
                          // . after we click the back button in the details page, the route is popped from the navigator stack and we are back to the home page.
                          // . other methods like pushReplacement, pushNamed, pushNamedAndRemoveUntil can also be used.
                          // - new page is displayed with the help of animations and the old page is kept in the memory.
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductDetailsPage(
                                  product: product,
                                );
                              },
                            ),
                          );
                        },
                        child: ProductCard(
                          title: product['title'] as String,
                          imageUrl: product['imageUrl'] as String,
                          price: product['price'] as double,
                          backgroundColor: (index % 2 == 0
                              ? const Color.fromRGBO(216, 240, 253, 1)
                              : const Color.fromRGBO(245, 247, 249, 1)),
                          borderColor: (index % 2 == 0
                              ? const Color.fromRGBO(0, 122, 255, 1)
                              : const Color.fromRGBO(205, 214, 223, 1)),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
