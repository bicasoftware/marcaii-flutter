import 'package:flutter/material.dart';

class DefaultListItem extends StatelessWidget {
  const DefaultListItem({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.contentChild,
    @required this.onTap,
    this.isLast: false,
    this.iconColor: Colors.black54,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final GestureTapCallback onTap;
  final Widget contentChild;
  final Color iconColor;
  final bool isLast;

  Widget _paintDivider(BuildContext context) {
    if (!isLast) {
      return Divider(height: 1.0, color: Theme.of(context).dividerColor);
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          child: ListTile(
            leading: Icon(
              icon,
              color: iconColor,
            ),
            title: Row(
              children: <Widget>[
                ExpandedListTitle(
                  title: title,
                ),
                Container(
                  margin: EdgeInsets.only(right: 8.0),
                  child: contentChild,
                ),
              ],
            ),
          ),
        ),
        _paintDivider(context),
      ],
    );
  }
}

class ExpandedListTitle extends StatelessWidget {
  const ExpandedListTitle({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        title,
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14.0),
      ),
    );
  }
}
