import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remi/main.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:remi/screens/bottombar.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String selectedColor = '#ed5f72';
  String title = ' ';
  String content = ' ';

  @override
  Widget build(BuildContext context) {
    var mode = Provider.of<ModeProvider>(context);
    return Scaffold(
      backgroundColor: toColor(selectedColor),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomBar(
                                index: 1,
                              ),
                            ));
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: (mode.darkMode) ? white : navy,
                      )),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    content: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3),
                                        itemCount: colors.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedColor = colors[index];
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                color: toColor(colors[index]),
                                              ),
                                            ),
                                          );
                                        }));
                              });
                        },
                        child: Icon(Icons.color_lens,
                            color: (mode.darkMode) ? white : navy),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: (() async {
                          if (title == ' ' || content == ' ') {
                            await AnimatedSnackBar.material(
                              'Please Fill All Data',
                              type: AnimatedSnackBarType.error,
                              mobileSnackBarPosition:
                                  MobileSnackBarPosition.top,
                              desktopSnackBarPosition:
                                  DesktopSnackBarPosition.topCenter,
                              duration: const Duration(seconds: 1),
                            ).show(context);
                          } else {
                            await mode.addNote(title, content, selectedColor);
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomBar(
                                    index: 1,
                                  ),
                                ));
                          }
                        }),
                        icon: Icon(Icons.save,
                            color: (mode.darkMode) ? white : navy),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  title = value;
                },
                style: TextStyle(fontSize: 25, color: white),
                decoration: InputDecoration.collapsed(
                    hintText: 'Title',
                    hintStyle: TextStyle(fontSize: 25, color: white)),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  content = value;
                },
                style: TextStyle(color: white),
                decoration: InputDecoration.collapsed(
                    hintText: 'content',
                    hintStyle: TextStyle(fontSize: 20, color: mode.textColor)),
                autofocus: false,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
              ),
            ],
          ),
        )),
      ),
    );
  }
}

List<String> colors = [
  '#ed5f72',
  '#CD6155',
  '#922B21',
  '#641E16',
  '#512E5F',
  '#9B59B6',
  '#4A235A',
  '#154360',
  '#2471A3',
  '#5DADE2',
  '#0E6251',
  '#16A085',
  '#1E8449',
  '#7D6608',
  '#D4AC0D',
  '#D68910',
  '#F7DC6F',
  '#784212',
  '#CA6F1E',
  '#A04000',
  '#5F6A6A',
];
