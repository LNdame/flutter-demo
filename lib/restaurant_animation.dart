import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class RestaurantAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("RESTAURANT"),
        centerTitle: true,
      ),
      body: new RestaurantAnimationScreen(),
    );
  }
}

class RestaurantAnimationScreen extends StatefulWidget {
  @override
  State createState() => new RestaurantAnimationScreenState();
}

class RestaurantAnimationScreenState extends State<RestaurantAnimationScreen> with TickerProviderStateMixin {

  AnimationController animControlDropDown, animControlZoomBtn;
  Animation dropDownAnimation, fadeInAnimation;
  double thresholdMarginTop1 = 40.0,
      thresholdMarginTop2 = 60.0;

  @override
  void initState() {
    super.initState();

    // Animation phrase 1
    animControlDropDown = new AnimationController(vsync: this, duration: new Duration(milliseconds: 1500));

    dropDownAnimation =
        new Tween (begin: 0.0, end: 70.0).animate(
            new CurvedAnimation(parent: animControlDropDown, curve: new Interval(0.0, 1.0, curve: Curves.easeOut)));
    dropDownAnimation.addListener(() {
      setState(() {});
    });

    fadeInAnimation = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(parent: animControlDropDown, curve: new Interval(0.0, 0.8, curve: Curves.easeOut)));
    fadeInAnimation.addListener(() {
      setState(() {});
    });

    animControlDropDown.forward();

    // Animation phrase 2
    animControlZoomBtn = new AnimationController(vsync: this, duration: new Duration(milliseconds: 100));
    animControlZoomBtn.addListener(() {
      setState(() {});
    });
    animControlZoomBtn.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animControlZoomBtn.reverse();
      }
    });
  }

  // Process value for margin top with bounce
  double processMarginTop(double value, double thresholdValue1, thresholdValue2) {
    if (value < thresholdValue1) {
      return value;
    } else if (value < thresholdValue2) {
      return value = thresholdValue1 - (value - thresholdValue1);
    } else {
      return value = value - thresholdValue1;
    }
  }

  @override
  void dispose() {
    animControlDropDown.dispose();
    super.dispose();
  }

  void onBtnPressed() {
    animControlZoomBtn.forward();
  }

  Widget renderTabMenu() {
    return new Container(
      child: new Row(
        children: <Widget>[

          // Dashboard
          new FlatButton(
            child: new Row(
              children: <Widget>[
                new Image.asset('images/ic_home.png', width: 15.0, height: 15.0),
                new Container(width: 10.0),
                new Text('Dashboard', style: new TextStyle(color: Colors.white))
              ],
            ),
            onPressed: () {},
          ),

          // Menus
          new FlatButton(
            child: new Row(
              children: <Widget>[
                new Image.asset('images/ic_menu.png', width: 15.0, height: 15.0),
                new Container(width: 10.0),
                new Text('Menus', style: new TextStyle(color: Colors.white))
              ],
            ),
            onPressed: () {},
          ),

          // Seats
          new FlatButton(
            child: new Row(
              children: <Widget>[
                new Image.asset('images/ic_seat.png', width: 15.0, height: 15.0),
                new Container(width: 10.0),
                new Text('Seats', style: new TextStyle(color: Colors.white))
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
      decoration: new BoxDecoration(color: new Color(0xFFf53970)),
      padding: new EdgeInsets.all(10.0),
    );
  }

  Widget renderBigTable(String colorTable, Function onPressed) {
    return new FlatButton(
      onPressed: onPressed,
      child:
      new Container(
        width: 120.0,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              child: new Row(
                children: <Widget>[
                  new Image.asset('images/chair_top.png', width: 40.0, height: 20.0,),
                  new Container(width: 10.0,),
                  new Image.asset('images/chair_top.png', width: 40.0, height: 20.0,),
                ],
              ),
              width: 90.0,
            ),
            new Stack(
              children: <Widget>[
                new Image.asset(
                  colorTable == 'green' ? 'images/table_big_green.png' : 'images/table_big_pink.png',
                  width: 120.0,
                  height: 60.0,
                  fit: BoxFit.contain,),
                new Container(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                          '01',
                          style: new TextStyle(color: new Color(0xFF575869), fontSize: 14.0)
                      ),
                      new Container(height: 15.0,),
                      new Text(
                          'Available',
                          style: new TextStyle(color: new Color(0xFF575869), fontSize: 10.0)
                      )
                    ],
                  ),
                  margin: new EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0, right: 10.0),
                )
              ],
            ),
            new Container(
              child: new Row(
                children: <Widget>[
                  new Image.asset('images/chair_bottom.png', width: 40.0, height: 20.0,),
                  new Container(width: 10.0,),
                  new Image.asset('images/chair_bottom.png', width: 40.0, height: 20.0,),
                ],
              ),
              width: 90.0,
            ),
          ],
        ),
      ),
      padding: new EdgeInsets.all(0.0),
    );
  }

  // With press animation for demo
  Widget renderBigTable2(String colorTable, Function onPressed) {
    return new FlatButton(
      onPressed: onPressed,
      child:
      new Container(
        width: 120.0 - animControlZoomBtn.value * 10,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              child: new Row(
                children: <Widget>[
                  new Image.asset(
                      'images/chair_top.png',
                      width: 40.0 - animControlZoomBtn.value * 5,
                      height: 20.0 - animControlZoomBtn.value * 2
                  ),
                  new Container(width: 10.0 - animControlZoomBtn.value * 2),
                  new Image.asset(
                      'images/chair_top.png',
                      width: 40.0 - animControlZoomBtn.value * 5,
                      height: 20.0 - animControlZoomBtn.value * 2
                  ),
                ],
              ),
              width: 90.0 - animControlZoomBtn.value * 10,
            ),
            new Stack(
              children: <Widget>[
                new Image.asset(
                    colorTable == 'green' ? 'images/table_big_green.png' : 'images/table_big_pink.png',
                    width: 120.0 - animControlZoomBtn.value * 10,
                    height: 60.0 - animControlZoomBtn.value * 5,
                    fit: BoxFit.contain
                ),
                new Container(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                          '01',
                          style: new TextStyle(
                              color: new Color(0xFF575869),
                              fontSize: 14.0 - animControlZoomBtn.value * 2
                          )
                      ),
                      new Container(height: 15.0),
                      new Text(
                          'Available',
                          style: new TextStyle(
                              color: new Color(0xFF575869),
                              fontSize: 10.0 - animControlZoomBtn.value * 2
                          )
                      )
                    ],
                  ),
                  margin: new EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0, right: 10.0),
                )
              ],
            ),
            new Container(
              child: new Row(
                children: <Widget>[
                  new Image.asset(
                      'images/chair_bottom.png',
                      width: 40.0 - animControlZoomBtn.value * 5,
                      height: 20.0 - animControlZoomBtn.value * 2
                  ),
                  new Container(width: 10.0 - animControlZoomBtn.value * 2),
                  new Image.asset('images/chair_bottom.png',
                      width: 40.0 - animControlZoomBtn.value * 5,
                      height: 20.0 - animControlZoomBtn.value * 2
                  ),
                ],
              ),
              width: 90.0 - animControlZoomBtn.value * 10,
            ),
          ],
        ),
      ),
      padding: new EdgeInsets.all(0.0),
    );
  }

  Widget renderSmallTable(String colorTable, Function onPressed) {
    return new FlatButton(
      onPressed: onPressed,
      child:
      new Container(
        width: 60.0,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              child: new Row(
                children: <Widget>[
                  new Image.asset('images/chair_top.png', width: 40.0, height: 20.0,),
                ],
              ),
              width: 40.0,
            ),
            new Stack(
              children: <Widget>[
                new Image.asset(
                  colorTable == 'green' ? 'images/table_small_green.png' : 'images/table_small_yellow.png',
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.contain,
                ),
                new Container(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                          '01',
                          style: new TextStyle(color: new Color(0xFF575869), fontSize: 14.0)
                      ),
                      new Container(height: 15.0,),
                      new Text(
                          'Taken',
                          style: new TextStyle(color: new Color(0xFF575869), fontSize: 10.0)
                      )
                    ],
                  ),
                  margin: new EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0, right: 10.0),
                )
              ],
            ),
            new Container(
              child: new Row(
                children: <Widget>[
                  new Image.asset('images/chair_bottom.png', width: 40.0, height: 20.0,),
                ],
              ),
              width: 40.0,
            ),
          ],
        ),
      ),
      padding: new EdgeInsets.all(0.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(color: new Color(0xfff8f9fb)),
      child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            // Tab menu
            renderTabMenu(),

            new Opacity(
              opacity: fadeInAnimation.value,
              child: new Container(
                child: new Column(
                  children: <Widget>[
                    // Text entrance
                    new Center(
                      child: new Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                        child: new Text(
                          'ENTRANCE', style: new TextStyle(color: new Color(0xFF575869), fontWeight: FontWeight.bold,),
                        ),
                      ),
                    ),

                    // Group tables
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // Table big
                        new Container(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Container(child: renderBigTable2('green', onBtnPressed), width: 120.0,),
                              renderBigTable('pink', null),
                            ],
                          ),
                          margin: new EdgeInsets.only(left: 10.0, right: 10.0),
                        ),

                        // Table small
                        new Container(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              renderSmallTable('green', null),
                              renderSmallTable('yellow', null),
                              renderSmallTable('green', null),
                            ],
                          ),
                          margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                        ),

                        // Table big
                        new Container(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              renderBigTable('pink', null),
                              renderBigTable('green', null),
                            ],
                          ),
                          margin: new EdgeInsets.only(left: 10.0, right: 10.0),
                        ),

                        // Table small
                        new Container(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              renderSmallTable('yellow', null),
                              renderSmallTable('green', null),
                              renderSmallTable('yellow', null),
                            ],
                          ),
                          margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                        ),

                      ],
                    ),
                  ],
                ),
                margin: new EdgeInsets.only(
                    top: processMarginTop(dropDownAnimation.value, thresholdMarginTop1, thresholdMarginTop2)),
              ),
            ),
          ]
      ),
    );
  }
}

