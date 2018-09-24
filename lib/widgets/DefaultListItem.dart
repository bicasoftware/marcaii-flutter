import 'package:flutter/material.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/Styles.dart';

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
        ListTile(
          onTap: onTap,
          leading: Icon(
            icon,
            color: iconColor,
          ),
          title: Text(
            title,
            style: Styles.getListTitleStyle(context),
          ),
          trailing: contentChild,
        ),
        _paintDivider(context),
      ],
    );
  }
}
