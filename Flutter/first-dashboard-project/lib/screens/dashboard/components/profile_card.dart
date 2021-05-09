import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding/2
      ),
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white10)
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/christian_transparent.png",
            height: 38,
          ),
          if(!Responsive.isMobile(context))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding/2),
              child: Text("Christian Terbeck"),
            ),
          Icon(Icons.keyboard_arrow_down)
        ],
      ),
    );
  }
}