import 'package:flutter/material.dart';
import '../utils/media_player.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

// Instructions and their corresponding audio feedbacks
const _instructionsList = [
  ["Inicio", "sounds/sound_instruction_one.mp3"],
  ["Deteccion de billetes", "sounds/sound_instruction_two.mp3"],
  ["El historial", "sounds/sound_instruction_history_3.mp3"],
  ["Lista de billetes", "sounds/sound_instruction_historyList_3.mp3"],
];

class InstructionPage extends StatefulWidget {
  @override
  _InstructionPageState createState() => _InstructionPageState();
}

class _InstructionPageState extends State<InstructionPage> {
  final _fontSize = 23.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "INFORMACION",
              style: GoogleFonts.poppins(
                textStyle:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
              ),
            ),
          ),
          backgroundColor: appBarBgColor,
          elevation: 15,
          centerTitle: true,
        ),
        body: getInstructionListView(),
        backgroundColor: infobgColor);
  }

  Widget getInstructionListView() {
    final TextStyle listTextStyle =
        TextStyle(fontSize: _fontSize, fontWeight: FontWeight.w600);

    return ListView.builder(
      itemCount: _instructionsList.length,
      itemBuilder: (context, index) {
        return Column(children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.04,
                bottom: MediaQuery.of(context).size.width * 0.0,
                left: MediaQuery.of(context).size.width * 0.03,
                right: MediaQuery.of(context).size.width * 0.03),
            child: Container(
              height: MediaQuery.of(context).size.width * 0.22,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: infoBoxColor,
                boxShadow: [
                  BoxShadow(
                    color: grey,
                    spreadRadius: 1,
                    blurRadius: 0,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05),
                  child: Center(
                      child: ListTile(
                    title: Text('${index + 1}. ' + _instructionsList[index][0],
                        style: listTextStyle),
                    trailing: Icon(
                      Icons.volume_up_sharp,
                      color: iconColor,
                      size: 40,
                    ),
                    onTap: () {
                      MediaPlayer.playAudio(_instructionsList[index][1]);
                    },
                  ))),
            ),
          ),
        ]);
      },
    );
  }

  @override
  void dispose() {
    // If any audio is being played, stop it before leaving Instructions Page
    MediaPlayer.stopAudio();
    super.dispose();
  }
}
