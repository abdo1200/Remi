import 'package:provider/provider.dart';
import 'package:remi/main.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:remi/screens/add_note.dart';
import 'package:remi/screens/note_details.dart';
import 'package:remi/widgets/note_card.dart';
import 'package:remi/widgets/tabs_header.dart';
import 'package:flutter/material.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    var mode = Provider.of<ModeProvider>(context);

    return Scaffold(
      backgroundColor: mode.color,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              TabsHeader(
                  function: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const AddNote()),
                    );
                  },
                  title: 'Notes',
                  btnText: 'Add Note'),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: FutureBuilder<void>(
                    future: mode.getNotes(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          if (mode.notes!.isNotEmpty) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return GridView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemCount: mode.notes!.length,
                                itemBuilder: (context, index) {
                                  return FutureBuilder<List<String>?>(
                                      future: mode
                                          .getNoteDetails(mode.notes![index]),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: GestureDetector(
                                              onTap: (() {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NoteDetials(
                                                              id: mode
                                                                      .notes![
                                                                  index],
                                                              color: toColor(
                                                                  snapshot
                                                                          .data![
                                                                      2]),
                                                              title: snapshot
                                                                  .data![0],
                                                              content: snapshot
                                                                  .data![1])),
                                                );
                                              }),
                                              child: NoteCard(
                                                  id: mode.notes![index],
                                                  color: toColor(
                                                      snapshot.data![2]),
                                                  title: snapshot.data![0],
                                                  content: snapshot.data![1]),
                                            ),
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      });
                                },
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 80),
                                Image.asset('assets/img/no.png',
                                    height: MediaQuery.of(context).size.height *
                                        .3),
                                const SizedBox(height: 20),
                                Text(
                                  'No Notes yet',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: mode.textColor),
                                ),
                              ],
                            );
                          }
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 80),
                              Image.asset('assets/img/no.png',
                                  height:
                                      MediaQuery.of(context).size.height * .3),
                              const SizedBox(height: 20),
                              Text(
                                'No Notes yet',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: mode.textColor),
                              ),
                            ],
                          );
                        }
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
