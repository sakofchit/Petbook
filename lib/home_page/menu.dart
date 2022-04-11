import 'package:flutter/material.dart';
import 'package:petbook/petbook/petbook_theme.dart';


class MenuItems {
  static const home = MenuItem('Home', Icons.home_rounded);
  static const addPet = MenuItem('Add a Pet', Icons.pets_rounded);
  static const shop = MenuItem('Shop', Icons.shopping_bag_rounded);
  static const settings = MenuItem('Settings', Icons.settings_suggest_rounded);

  static const all = <MenuItem>[
    home,
    addPet,
    shop,
    settings
  ];
}


class MenuPage extends StatelessWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;
  

  const MenuPage({
    Key key,
    this.currentItem,
    this.onSelectedItem
    }) : super(key: key);
    
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xffF5CAC3),
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Spacer(),
          ...MenuItems.all.map(buildMenuItem).toList(),
          Spacer(flex: 2),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 30),
            child: Text("Group 23, POOSD Large Project")
          )
        ],
      )
    )
  );

  Widget buildMenuItem(MenuItem item) => ListTileTheme(
    selectedColor: const Color(0xff3A405A),
    child: ListTile(
    selected: currentItem == item,
    //selectedTileColor: Colors.black,
    minLeadingWidth: 20,
    leading: Icon(item.icon),
    title: Text(item.title),
    onTap: () => onSelectedItem(item),
  ));
}


class MenuItem {
  final String title;
  final IconData icon;

  const MenuItem(this.title, this.icon);
}