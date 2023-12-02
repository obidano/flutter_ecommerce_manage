import 'package:flutter/material.dart';

class MImage extends StatelessWidget {
  final bool isNetwork;
  final String url;

  const MImage({super.key, this.isNetwork = true, required this.url});

  @override
  Widget build(BuildContext context) {
    if (isNetwork) {
      return Image.network(url);
    }
    return Image.asset(url);
  }
}
