import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/features/account/services/account_services.dart';
import 'package:amazone_clone/features/admin/screens/analitics_screen.dart';
import 'package:amazone_clone/features/admin/screens/orders_screen.dart';
import 'package:amazone_clone/features/admin/screens/product_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final AccountServices accountServices = AccountServices();

  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const ProductScreen(),
    const AnalicticScreen(),
    const OrderScreenAdmin(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.portrait) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: GlobalVariables.appBarGradient,
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        'assets/images/amazon_in.png',
                        width: 130,
                        height: 65,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      'Admin',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      onPressed: () {
                        accountServices.logOut(context);
                      },
                      icon: const Icon(Icons.logout),
                    ),
                  ),
                ],
              ),
            ),
            body: pages[_page],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _page,
              selectedItemColor: GlobalVariables.selectedNavBarColor,
              unselectedItemColor: GlobalVariables.unselectedNavBarColor,
              backgroundColor: GlobalVariables.backgroundColor,
              iconSize: 28,
              onTap: updatePage,
              items: [
                // HOME SCREEN
                BottomNavigationBarItem(
                  label: '',
                  icon: Container(
                    width: bottomBarWidth,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: _page == 0
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor,
                          width: bottomBarBorderWidth,
                        ),
                      ),
                    ),
                    child: const Icon(Icons.home_outlined),
                  ),
                ),
                // ANALYTICS SCREEN
                BottomNavigationBarItem(
                  label: '',
                  icon: Container(
                    width: bottomBarWidth,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: _page == 1
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor,
                          width: bottomBarBorderWidth,
                        ),
                      ),
                    ),
                    child: const Icon(Icons.analytics_outlined),
                  ),
                ),
                // ORDERS SCREEN
                BottomNavigationBarItem(
                  label: '',
                  icon: Container(
                    width: bottomBarWidth,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: _page == 2
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor,
                          width: bottomBarBorderWidth,
                        ),
                      ),
                    ),
                    child: const Icon(Icons.all_inbox_outlined),
                  ),
                ),
              ],
            ),
          );
        } else {
          // Landscape mode
          return Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: GlobalVariables.appBarGradient,
                ),
              ),
              title: const Text(
                'Admin',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    onPressed: () {
                      accountServices.logOut(context);
                    },
                    icon: const Icon(Icons.logout),
                  ),
                ),
              ],
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: 100,
                    child: DrawerHeader(
                      decoration: const BoxDecoration(
                        gradient: GlobalVariables.appBarGradient,
                      ),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          'assets/images/amazon_in.png',
                          width: 130,
                          height: 65,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Product',
                      style: TextStyle(
                        color: _page == 0
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.unselectedNavBarColor,
                      ),
                    ),
                    leading: Icon(
                      Icons.home_outlined,
                      color: _page == 0
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.unselectedNavBarColor,
                    ),
                    onTap: () {
                      updatePage(0);
                      Navigator.pop(context);
                    },
                    selected: _page == 0,
                  ),
                  ListTile(
                    title: Text(
                      'Analytics',
                      style: TextStyle(
                        color: _page == 1
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.unselectedNavBarColor,
                      ),
                    ),
                    leading: Icon(
                      Icons.analytics_outlined,
                      color: _page == 1
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.unselectedNavBarColor,
                    ),
                    onTap: () {
                      updatePage(1);
                      Navigator.pop(context);
                    },
                    selected: _page == 1,
                  ),
                  ListTile(
                    title: Text(
                      'Orders',
                      style: TextStyle(
                        color: _page == 2
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.unselectedNavBarColor,
                      ),
                    ),
                    leading: Icon(
                      Icons.all_inbox_outlined,
                      color: _page == 2
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.unselectedNavBarColor,
                    ),
                    onTap: () {
                      updatePage(2);
                      Navigator.pop(context);
                    },
                    selected: _page == 2,
                  ),
                ],
              ),
            ),
            body: pages[_page],
          );
        }
      },
    );
  }
}

// class _AdminScreenState extends State<AdminScreen> {
//   final AccountServices accountServices = AccountServices();

//   int _page = 0;
//   double bottomBarWidth = 42;
//   double bottomBarBorderWidth = 5;

//   List<Widget> pages = [
//     const ProductScreen(),
//     const AnalicticScreen(),
//     const OrderScreenAdmin()
//   ];

//   void updatePage(int page) {
//     setState(() {
//       _page = page;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(50),
//         child: AppBar(
//           flexibleSpace: Container(
//             decoration:
//                 const BoxDecoration(gradient: GlobalVariables.appBarGradient),
//           ),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 alignment: Alignment.topLeft,
//                 child: Image.asset(
//                   'assets/images/amazon_in.png',
//                   width: 130,
//                   height: 65,
//                   color: Colors.black,
//                 ),
//               ),
//               const Text(
//                 'Admin',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               )
//             ],
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 8),
//               child: IconButton(
//                   onPressed: () {
//                     accountServices.logOut(context);
//                   },
//                   icon: const Icon(Icons.logout)),
//             )
//           ],
//         ),
//       ),
//       body: pages[_page],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _page,
//         selectedItemColor: GlobalVariables.selectedNavBarColor,
//         unselectedItemColor: GlobalVariables.unselectedNavBarColor,
//         backgroundColor: GlobalVariables.backgroundColor,
//         iconSize: 28,
//         onTap: updatePage,
//         items: [
//           // HOME SCREEN
//           BottomNavigationBarItem(
//             label: '',
//             icon: Container(
//               width: bottomBarWidth,
//               decoration: BoxDecoration(
//                 border: Border(
//                   top: BorderSide(
//                     color: _page == 0
//                         ? GlobalVariables.selectedNavBarColor
//                         : GlobalVariables.backgroundColor,
//                     width: bottomBarBorderWidth,
//                   ),
//                 ),
//               ),
//               child: const Icon(Icons.home_outlined),
//             ),
//           ),
//           // PROFILE SCREEN
//           BottomNavigationBarItem(
//             label: '',
//             icon: Container(
//               width: bottomBarWidth,
//               decoration: BoxDecoration(
//                 border: Border(
//                   top: BorderSide(
//                     color: _page == 1
//                         ? GlobalVariables.selectedNavBarColor
//                         : GlobalVariables.backgroundColor,
//                     width: bottomBarBorderWidth,
//                   ),
//                 ),
//               ),
//               child: const Icon(Icons.analytics_outlined),
//             ),
//           ),
//           // ORDERS SCREEN
//           BottomNavigationBarItem(
//             label: '',
//             icon: Container(
//               width: bottomBarWidth,
//               decoration: BoxDecoration(
//                 border: Border(
//                   top: BorderSide(
//                     color: _page == 2
//                         ? GlobalVariables.selectedNavBarColor
//                         : GlobalVariables.backgroundColor,
//                     width: bottomBarBorderWidth,
//                   ),
//                 ),
//               ),
//               child: const Icon(Icons.all_inbox_outlined),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
