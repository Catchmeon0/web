import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:web/config/palette.dart';
import 'package:web/models/models.dart';
import 'package:web/widgets/widgets.dart';

class CustomAppBar extends StatelessWidget {
  final User currentUser;
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomAppBar({
    Key key,
    @required this.currentUser,
    @required this.icons,
    @required this.selectedIndex,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 65.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Expanded(
            child:  Text(
              "CatchMeOn",
              style: const TextStyle(
                color: Palette.catchMeOn_logo_Color,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2,
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: 600.0,
            child: CustomTabBar(
              icons: icons,
              selectedIndex: selectedIndex,
              onTap: onTap,
              isBottomIndicator: true,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                const SizedBox(width: 12.0),
                CircleButton(
                  icon: Icons.search,
                  iconSize: 30.0,
                  onPressed: () => print('search'),
                ),
                CircleButton(
                  icon: MdiIcons.facebook,
                  iconSize: 30.0,
                  onPressed: () => print('facebook'),
                ),
                CircleButton(
                  icon: MdiIcons.instagram,
                  iconSize: 30.0,
                  onPressed: () => print('instagram'),
                ),
                CircleButton(
                  icon: MdiIcons.twitter,
                  iconSize: 30.0,
                  onPressed: () => print('twitter'),
                ),
               UserCard(user: currentUser),
              ],
            ),
          ),
        ],
      ),
    );
  }
}