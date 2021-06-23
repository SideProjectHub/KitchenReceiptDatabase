class FridgeIcon extends StatelessWidget {
  const FridgeIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget iconCircle = new Container(
      height: 200,
      width: 200,
      decoration: new BoxDecoration(
        color: Colors.gray,
        shape: Boxshape.circle,
      ),
    );

    return new Material(
      child: new Center(
        child: new Stack(children: <Widget>[
          iconCircle,
          new Positioned(
            top: 200,
            left: 173,
            child: Text("Fruits"),
          ),
          new Positioned(
            top: 200,
            left: 173,
            child: Text("Fruits"),
          ),
          new Positioned(
            top: 200,
            left: 173,
            child: Text("Fruits"),
          ),
          new Positioned(
            top: 200,
            left: 173,
            child: Text("Fruits"),
          ),
          new Positioned(
            top: 200,
            left: 173,
            child: Text("Fruits"),
          ),
        ]),
      ),
    );
  }
}
