import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';

class NavigationTabBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onNext, onPrev, onLabelTap;
  final TabBar tabBar;
  final int position;

  const NavigationTabBar({
    Key key,
    @required this.onNext,
    @required this.onPrev,
    @required this.onLabelTap,
    @required this.tabBar,
    @required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                color: Colors.white,
                icon: Icon(
                  Icons.navigate_before,
                  color: Colors.white,
                ),
                onPressed: onPrev,
              ),
              Expanded(
                child: FlatButton(
                  child: Text(
                    Arrays.months[position],
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: onLabelTap,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.navigate_next,
                  color: Colors.white,
                ),
                onPressed: onNext,
              ),
            ],
          ),
          tabBar,
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(84.0);
  //Size get preferredSize => Size.fromHeight(76.0);
}
