import 'package:al_fatiha/presentation/blocs/recitation_bloc.dart';
import 'package:al_fatiha/presentation/blocs/recitation_state.dart';
import 'package:al_fatiha/presentation/widgets/chatwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/SenderMessageModel.dart';
import '../blocs/recitation_event.dart';

Widget controlRecording(
    BuildContext context, RecitationBloc bloc, RecitationState state) {
  return Container(
    child: state.status == "initial"
        ? Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            const Text(
              "Qiroatni yozib yuborish uchun quyidagi\ntugmani 1 marta bosing",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Text(
              "Qiroatni 10dan 120 sekundgacha yuboring",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: GestureDetector(
                onTap: () {
                  bloc.add(OnStartRecording());
                },
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: const BoxDecoration(
                    color: Color(0xFF30BF77), // Green color
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.mic,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ])
        : state.status == "recording"
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Recording...",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () {
                        bloc.add(OnFinishRecording());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: const BoxDecoration(
                          color: Colors.red, // Stop button color
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.stop,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : state.status == "finished"
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(4, 4, 4, 40),
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () {
                                    bloc.add(OnPlayRecording());
                                  },
                                  icon: const Icon(Icons.play_arrow),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.grey[200], // Color of the button
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () {
                                    final bloc = context.read<RecitationBloc>();

                                    // Check if the recording exists before proceeding
                                    if (bloc.state.recordingPath != null) {
                                      // Create the SenderMessageModel with the audio and text message
                                      final senderMessage = SenderMessageModel(
                                        text: "Fotiha surasini qiroat qilish",
                                        audioPath: bloc.state.recordingPath!,
                                      );

                                      // Navigate to a page with the updated chatWidget
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => chatWidget([senderMessage]),
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF30BF77),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Yuborish",
                                          style: TextStyle(fontSize: 12, color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () {
                                    bloc.add(OnStartRecording());
                                  },
                                  icon: const Icon(Icons.delete),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.grey[200], // Color of the button
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
  );
}