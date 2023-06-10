import 'package:amazone_clone/common/widget/bottom_bar.dart';
import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/features/admin/screens/admin_screen.dart';
import 'package:amazone_clone/features/auth/screens/auth_screen.dart';
import 'package:amazone_clone/features/auth/services/auth_service.dart';
import 'package:amazone_clone/providers/user_provider.dart';
import 'package:amazone_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    authService.getUserData(context);
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amazon Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        // useMaterial3: true, // can remove this line
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          final userType = userProvider.user.type;
          if (userProvider.user.token.isNotEmpty) {
            if (userType == 'user') {
              return const BottomBar();
            } else if (userType == 'admin') {
              return const AdminScreen();
            }
          }
          return const AuthScreen();
        },
      ),
    );
    // Provider.of<UserProvider>(context).user.token.isNotEmpty
    //     ? Provider.of<UserProvider>(context, listen: false).user.type ==
    //             'user'
    //         ? const BottomBar()
    //         : const AdminScreen()
    //     : const AuthScreen());
  }
}
