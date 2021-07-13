class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;

  TabNavigationItem({
    required this.page,
    required this.title,
    required this.icon,
  });

  static List<TabNavigationItem> get items => [
        /* Example tab navigation 
        TabNavigationItem(
          page: HomePage(),
          icon: Icon(Icons.home),
          title: Text("Home"),
        ),
        */
      ];
}
