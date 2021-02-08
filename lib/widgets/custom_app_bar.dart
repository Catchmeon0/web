import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:web/config/palette.dart';
import 'package:web/models/UserModel.dart';
import 'package:web/models/models.dart';
import 'package:web/screens/screens.dart';
import 'package:web/screens/search/search_screen.dart';
import 'package:web/widgets/widgets.dart';

class CustomAppBar extends StatelessWidget {
  final UserModel currentUser;
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
            child:
            /*Text(
              "CatchMeOn",
              style: const TextStyle(
                color: Palette.catchMeOn_logo_Color,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2,
              ),
            ),*/
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child :new Image.asset("assets/images/CMO_black.png")
      )

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
                  onPressed: () => {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                  )},
                ),

               UserCard(user: currentUser),
                CircleButton(
                  icon: Icons.logout,
                  iconSize: 30.0,
                  onPressed: () => {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthThreePage()),
                  )},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}