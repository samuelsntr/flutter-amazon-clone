import 'package:amazone_clone/features/account/services/account_services.dart';
import 'package:amazone_clone/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButton extends StatefulWidget {
  const TopButton({super.key});

  @override
  State<TopButton> createState() => _TopButtonState();
}

class _TopButtonState extends State<TopButton> {
  final AccountServices accountServices = AccountServices();

  void logOut() async {
    accountServices.logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: 'Your Orders', onPressed: () {}),
            AccountButton(text: 'Turn Seller', onPressed: () {}),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(text: 'Log Out', onPressed: logOut),
            AccountButton(text: 'Your Wish List', onPressed: () {}),
          ],
        ),
      ],
    );
  }
}
