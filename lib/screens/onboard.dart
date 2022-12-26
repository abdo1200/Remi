import 'dart:math';

import 'package:remi/screens/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Class to hold data for itembuilder in Withbuilder app.
class ItemData {
  final Color color;
  final String img;
  final String text1;
  final String text2;

  ItemData(
    this.color,
    this.img,
    this.text1,
    this.text2,
  );
}

/// Example of LiquidSwipe with itemBuilder
class WithBuilder extends StatefulWidget {
  const WithBuilder({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WithBuilder createState() => _WithBuilder();
}

class _WithBuilder extends State<WithBuilder> {
  int page = 0;
  LiquidController? liquidController;
  UpdateType? updateType;

  List<ItemData> data = [
    ItemData(Colors.blue, 'assets/img/notes.png', "Write Notes",
        "Daily Tracker can help you create, edit and organize all your notes"),
    ItemData(Colors.deepPurpleAccent, 'assets/img/todo.png', "ToDo List",
        "Daily Tracker can help you list your tasks to organize your work"),
    ItemData(Colors.redAccent, 'assets/img/steps.png', "Habit Tracker",
        "Daily Tracker can help you to track your habits with 30 day challange"),
  ];

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  _isViewed() async {
    int viewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('viewed', viewed);
  }

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return SizedBox(
      width: 25.0,
      child: Center(
        child: Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: SizedBox(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          LiquidSwipe.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                color: data[index].color,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data[index].img,
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            data[index].text1,
                            style: headstyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            data[index].text2,
                            style: desStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            positionSlideIcon: 0.8,
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            onPageChangeCallback: pageChangeCallback,
            waveType: WaveType.liquidReveal,
            liquidController: liquidController,
            fullTransitionValue: 880,
            enableSideReveal: true,
            enableLoop: true,
            ignoreUserGestureWhileAnimating: true,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                const Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(data.length, _buildDot),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: GestureDetector(
                onTap: () async {
                  await _isViewed();
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomBar(
                                index: 0,
                              )));
                },
                child: Container(
                  color: Colors.white.withOpacity(0.01),
                  child: (liquidController!.currentPage + 1 < data.length)
                      ? const Text("Skip")
                      : const Text("Finish"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}

const headstyle = TextStyle(
  fontSize: 30,
  fontFamily: "tt",
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
const desStyle = TextStyle(
  fontSize: 18,
  fontFamily: "tt",
  fontWeight: FontWeight.w300,
  color: Colors.white,
);
