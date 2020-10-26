import 'package:flutter/material.dart';

class OrderHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Ivan HS"),
              Text("Rua Flutter Dart, 25"),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Preço Produto",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("Preço Total"),
          ],
        ),
      ],
    );
  }
}