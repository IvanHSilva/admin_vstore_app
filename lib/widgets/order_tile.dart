import 'package:admin_vstore/widgets/order_header.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4
      ),
      child: Card(
        child: ExpansionTile(
          title: Text(
            "#123456 - Entregue",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 16, right: 16, 
                top: 0, bottom: 0
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OrderHeader(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text("Camiseta Preta P"),
                        subtitle: Text("camiseta puro algodão e 100% lavável"),
                        trailing: Text("2",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton(
                        onPressed: (){}, 
                        textColor: Colors.red,
                        child: Text("Excluir"),
                      ),
                      FlatButton(
                        onPressed: (){}, 
                        textColor: Colors.grey[850],
                        child: Text("Voltar"),
                      ),
                      FlatButton(
                        onPressed: (){}, 
                        textColor: Colors.green,
                        child: Text("Avançar"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}