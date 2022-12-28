import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:remi/main.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:remi/screens/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final TextEditingController feed = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var mode = Provider.of<ModeProvider>(context, listen: true);
    return Scaffold(
        backgroundColor: mode.color,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: mode.cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      spreadRadius: .5,
                      blurRadius: 7,
                    )
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Dark Mode',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w100,
                              color: mode.textColor)),
                      FutureBuilder(
                          future: mode.getSelected(),
                          builder: (context, snapshot) {
                            return Switch(
                                value: mode.darkMode,
                                activeColor: mainColor,
                                onChanged: ((value) async {
                                  showDialog<void>(
                                      barrierColor:
                                          Colors.black.withOpacity(.5),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor:
                                              (mode.darkMode) ? grey : white,
                                          title: Text(
                                              (mode.darkMode)
                                                  ? 'Disable DarkMode'
                                                  : 'Enable DarkMode',
                                              style: TextStyle(
                                                fontSize: 25,
                                                color: (mode.darkMode)
                                                    ? Colors.white
                                                    : Colors.black,
                                              )),
                                          content:
                                              Text('Restart app to see changes',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: (mode.darkMode)
                                                        ? Colors.white
                                                        : Colors.black,
                                                  )),
                                          actions: <Widget>[
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge,
                                              ),
                                              child: Text('Restart',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: (mode.darkMode)
                                                        ? Colors.white
                                                        : Colors.black,
                                                  )),
                                              onPressed: () async {
                                                SharedPreferences pref =
                                                    await SharedPreferences
                                                        .getInstance();

                                                pref.setBool('mode', value);
                                                mode.changeMode(value);

                                                setState(() {
                                                  mode.darkMode = value;
                                                });
                                                // ignore: use_build_context_synchronously
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          BottomBar(
                                                        index: 0,
                                                      ),
                                                    ));
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                }));
                          }),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Give us your Feedback',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: mainColor),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  maxLines: 5,
                  style: TextStyle(fontSize: 20, color: mode.textColor),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    hintStyle: TextStyle(fontSize: 20, color: mode.textColor),
                    hintText: "Enter Your Feedback",
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: navy), //<-- SEE HERE
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: navy),
                    ),
                  ),
                  controller: feed,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (feed.text.isEmpty) {
                        AnimatedSnackBar.material(
                          'Please enter some Text',
                          type: AnimatedSnackBarType.error,
                          mobileSnackBarPosition: MobileSnackBarPosition.top,
                          desktopSnackBarPosition:
                              DesktopSnackBarPosition.topCenter,
                          duration: const Duration(seconds: 1),
                        ).show(context);
                      } else {
                        AnimatedSnackBar.material(
                          ' sended Successfully',
                          type: AnimatedSnackBarType.success,
                          mobileSnackBarPosition: MobileSnackBarPosition.top,
                          desktopSnackBarPosition:
                              DesktopSnackBarPosition.topCenter,
                          duration: const Duration(seconds: 1),
                        ).show(context);
                        feed.text = '';
                      }
                    },
                    child: Text('Submit',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                            color: white)),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return navy;
                        }
                        return navy;
                      }),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
