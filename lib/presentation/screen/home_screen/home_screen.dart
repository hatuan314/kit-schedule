import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/common/assets_constance.dart';
import 'package:schedule/common/router_list.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/presentation/screen/home_screen/widgets/AccountWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 500);
  AnimationController _controller;
  AppBar appBar = AppBar();
  double borderRadius = 0.0;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return WillPopScope(
      onWillPop: () async {
        if (!isCollapsed) {
          setState(() {

            _controller.reverse();
            borderRadius = 0.0;
            isCollapsed = !isCollapsed;
          });
          return false;
        } else
          return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: <Widget>[
            menu(context),
            AnimatedPositioned(
                left: isCollapsed ? 0 : 0.6 * screenWidth,
                right: isCollapsed ? 0 : -0.2 * screenWidth,
                top: isCollapsed ? 0 : screenHeight * 0.1,
                bottom: isCollapsed ? 0 : screenHeight * 0.1,
                duration: duration,
                curve: Curves.fastOutSlowIn,
                child: dashboard(context)),
          ],
        ),
      ),
    );
  }

  Widget menu(context) {
    return SafeArea(
      child: Container(
        color: ThemeColor.menuBackgroundColor,
        padding: const EdgeInsets.only(left: 0.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
              widthFactor: 0.6,
              heightFactor: 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AccountWidget(),
                  ),
                  Divider(
                    thickness: 1,
                    color: Color(0xff818181),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(AssetsConstance.scheduleIcon),
                        title: Text('January', style: ThemeText.menuItemTextStyle),
                        onTap: (){
                          setState(() {
                            if (isCollapsed) {
                              _controller.forward();
                              borderRadius = 16.0;
                            } else {
                              _controller.reverse();

                              borderRadius = 0.0;
                            }
                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        leading: Icon(AssetsConstance.todoIcon),
                        title: Text('Todo', style: ThemeText.menuItemTextStyle),
                        onTap: (){
                          setState(() {
                            if (isCollapsed) {
                              _controller.forward();
                              borderRadius = 16.0;
                            } else {
                              _controller.reverse();

                              borderRadius = 0.0;
                            }
                            isCollapsed = !isCollapsed;
                          });
                          Navigator.pushNamed(context, RouterList.todo);
                        },
                      ),
                      SizedBox(height: 10),

                    ],
                  ),
                ],
              )),
        ),
      ),
    );
    // ),
    // )
  }

  Widget dashboard(context) {
    return SafeArea(
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        type: MaterialType.card,
        animationDuration: duration,
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 8,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          child: Scaffold(
              appBar: AppBar(
                title: Text('Schedule'),
                leading: IconButton(
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      progress: _controller,
                    ),
                    onPressed: () {
                      setState(() {
                        if (isCollapsed) {
                          _controller.forward();
                          borderRadius = 16.0;
                        } else {
                          _controller.reverse();
                          borderRadius = 0.0;
                        }

                        isCollapsed = !isCollapsed;
                      });
                    }),
              ),
              body: Center(
                child: Text('texttt'),
              ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, RouterList.todo);
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
