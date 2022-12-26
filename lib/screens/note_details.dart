import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remi/main.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:remi/screens/bottombar.dart';

class NoteDetials extends StatefulWidget {
  final String id;
  final Color color;
  final String title;
  final String content;
  const NoteDetials(
      {super.key,
      required this.id,
      required this.color,
      required this.title,
      required this.content});

  @override
  State<NoteDetials> createState() => _NoteDetialsState();
}

class _NoteDetialsState extends State<NoteDetials> {
  String selectedColor = '';
  String title = ' ';
  String content = ' ';

  @override
  Widget build(BuildContext context) {
    var mode = Provider.of<ModeProvider>(context);
    return Scaffold(
      backgroundColor:
          (selectedColor == '') ? widget.color : toColor(selectedColor),
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
                        Navigator.push(
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
                            if (title == widget.title &&
                                content == widget.content &&
                                toColor(selectedColor) == widget.color) {
                            } else {
                              await mode.editNote(
                                widget.id,
                                (title == ' ') ? widget.title : title,
                                (content == ' ') ? widget.content : content,
                                (selectedColor == '')
                                    ? '#${widget.color.value.toRadixString(16)}'
                                    : selectedColor,
                              );

                              // ignore: use_build_context_synchronously
                              AnimatedSnackBar.material(
                                'Saved Successfully',
                                type: AnimatedSnackBarType.success,
                                mobileSnackBarPosition:
                                    MobileSnackBarPosition.top,
                                desktopSnackBarPosition:
                                    DesktopSnackBarPosition.topCenter,
                                duration: const Duration(seconds: 1),
                              ).show(context);
                            }
                          }),
                          icon: Icon(Icons.save,
                              color: (mode.darkMode) ? white : navy))
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: TextEditingController(text: widget.title),
                onChanged: (value) {
                  title = value;
                },
                style: TextStyle(color: white),
                decoration: InputDecoration.collapsed(
                    hintText: 'Title',
                    hintStyle: TextStyle(fontSize: 20, color: mode.textColor)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: TextEditingController(text: widget.content),
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
