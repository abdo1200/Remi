import 'package:provider/provider.dart';
import 'package:remi/main.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:remi/screens/add_note.dart';
import 'package:remi/widgets/note_card.dart';
import 'package:remi/widgets/tabs_header.dart';
import 'package:flutter/material.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var mode = Provider.of<ModeProvider>(context);

    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            TabsHeader(
                function: () {
                  Navigator.push(
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
                    if (mode.notes != null) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: mode.notes!.length,
                          itemBuilder: (context, index) {
                            //print(mode.notes);
                            return FutureBuilder<List<String>?>(
                                future: mode.getNoteDetails(mode.notes![index]),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: NoteCard(
                                          color: toColor(snapshot.data![2]),
                                          title: snapshot.data![0],
                                          content: snapshot.data![1]),
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                });
                          },
                        );
                      } else {
                        return const Text('No Notes yet');
                      }
                      // return Container();
                    } else {
                      return const Text('No Notes yet');
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
