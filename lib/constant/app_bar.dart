import 'package:flutter/material.dart';
import 'package:tasteclip/constant/app_text.dart';
import '../config/app_router.dart';

class CardAppBar extends StatefulWidget {
  final Color iconColor;
  final Color? containerColor;
  final String? route;
  final bool shadowOpacity;

  const CardAppBar({
    super.key,
    required this.iconColor,
    required this.containerColor,
    this.route,
    this.shadowOpacity = true,
  });

  @override
  State<CardAppBar> createState() => CardAppBarState();
}

class CardAppBarState extends State<CardAppBar> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double paddingTop;
    double cardRadius;

    if (screenWidth < 300 || screenHeight < 600) {
      paddingTop = 25;
      cardRadius = 10;
    } else if (screenWidth < 350 || screenHeight < 700) {
      paddingTop = 38;
      cardRadius = 12;
    } else {
      paddingTop = 45;
      cardRadius = 15;
    }

    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: GestureDetector(
        onTap: () {
          if (widget.route != null) {
            AppRouter.push(widget.route!);
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.height * 0.06,
          decoration: BoxDecoration(
            color: widget.containerColor,
            borderRadius: BorderRadius.circular(cardRadius),
            boxShadow: widget.shadowOpacity
                ? [
                    BoxShadow(
                      color: textColor.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: widget.iconColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatefulWidget {
  final Color iconColor;
  final String? route;

  const CustomAppBar({
    super.key,
    required this.iconColor,
    this.route,
  });

  @override
  State<CustomAppBar> createState() => CustomAppBarState();
}

class CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double paddingTop;

    if (screenWidth < 300 || screenHeight < 600) {
      paddingTop = 30;
    } else if (screenWidth < 350 || screenHeight < 700) {
      paddingTop = 38;
    } else {
      paddingTop = 45;
    }

    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: GestureDetector(
        onTap: () {
          if (widget.route != null) {
            AppRouter.push(widget.route!);
          }
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: widget.iconColor,
          size: 20,
        ),
      ),
    );
  }
}
