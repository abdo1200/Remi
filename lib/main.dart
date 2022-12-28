import 'package:remi/providers/mode_provider.dart';
import 'package:remi/screens/bottombar.dart';
import 'package:remi/screens/onboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color mainColor = const Color(0xffed5f72);
Color navy = const Color(0xff302d3e);
Color dark = const Color.fromARGB(255, 29, 37, 46);
Color white = Colors.white;
Color grey = const Color.fromARGB(255, 53, 57, 62);

Color toColor(String hexStringColor) {
  final buffer = StringBuffer();

  if (hexStringColor.length == 6 || hexStringColor.length == 7) {
    buffer.write('ff');
    buffer.write(hexStringColor.replaceFirst("#", ""));
  }
  if (hexStringColor.length == 9) {
    buffer.write(hexStringColor.replaceFirst("#", ""));
  }
  return Color(int.parse(buffer.toString(), radix: 16));
}

bool arabic(String s) {
  for (int i = 0; i < s.length; i++) {
    int c = s.codeUnitAt(i);
    if (c >= 0x0600 && c <= 0x06E0) return true;
  }
  return false;
}

int? viewd;
void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  viewd = prefs.getInt('viewed');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ModeProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var mode = Provider.of<ModeProvider>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Remi',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "BetmRounded",
        ),
        home: viewd != 0
            ? const WithBuilder()
            : FutureBuilder(
                future: mode.getSelected(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return BottomBar(
                      index: 0,
                    );
                  } else {
                    return Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [CircularProgressIndicator()]),
                    );
                  }
                })));
  }
}
