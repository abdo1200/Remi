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
  @override
  Widget build(BuildContext context) {
    var mode = Provider.of<ModeProvider>(context, listen: true);
    return SafeArea(
      child: Container(
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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                              barrierColor: Colors.black.withOpacity(.5),
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
                                  content: Text('Restart app to see changes',
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
                                                  const BottomBar(),
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
    );
  }
}
