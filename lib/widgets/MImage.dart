import 'package:flutter/material.dart';

class MImage extends StatelessWidget {
  final bool isNetwork;
  final String url;
  final double? width;
  final double? height;

  const MImage(
      {super.key,
      this.isNetwork = true,
      required this.url,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    if (isNetwork) {
      return Image.network(url, width: width, height: height);
    }
    return Image.asset(url, width: width, height: height);
  }
}
