import 'package:flutter/material.dart';
import 'package:new_ecommerce_foundations/utils/constantes.dart';

class DashboardItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const DashboardItem(
      {super.key,
      required this.icon,
      required this.label,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Card(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(Sizes.p8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Icon(icon), Text(label)]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Sizes.p4, horizontal: Sizes.p8),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                )),
              ],
            ),
          )
        ],
      )),
    );
  }
}
