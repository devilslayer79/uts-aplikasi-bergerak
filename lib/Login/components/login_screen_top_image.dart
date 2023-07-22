import 'package:flutter/material.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const Text(
        //   "LOGIN",
        //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        // ),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 2,
              child: Image.asset("assets/images/kopi bg.png"),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}
