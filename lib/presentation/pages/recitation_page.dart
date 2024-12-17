import 'package:al_fatiha/core/services/log_services.dart';
import 'package:al_fatiha/presentation/blocs/recitation_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';

import '../../data/models/SurahModel.dart';
import '../blocs/recitation_event.dart';
import '../blocs/recitation_state.dart';
import '../widgets/customAppBar.dart';

class RecitationPage extends StatelessWidget {
  const RecitationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SurahModel surah = SurahModel(
      title: "سورة الفاتحة",
      verses: [
        "بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ",
        "ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَـٰلَمِينَ",
        "ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ",
        "مَـٰلِكِ يَوْمِ ٱلدِّينِ",
        "إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ",
        "ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَ",
        "صِرَٰطَ ٱلَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ ٱلْمَغْضُوبِ عَلَيْهِمْ وَلَا ٱلضَّآلِّينَ",
      ],
    );

    return BlocProvider(
      create: (context) => RecitationBloc(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.grey[200], // Extends background to the edges

        body: BlocBuilder<RecitationBloc, RecitationState>(
          builder: (context, state) {
            final bloc = context.read<RecitationBloc>();
            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child:
                        customAppBar(context, "Fotiha surasini qiroat qilish"),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          // Title of Surah
                          Text(
                            surah.title,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                            ),
                          ),
                          const SizedBox(height: 10),

                          ...surah.verses.asMap().entries.map((entry) {
                            int index =
                                entry.key + 1; // Verse number starts from 1
                            String verse = entry.value;

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: verse,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        height: 2.0,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    TextSpan(
                                      text: _getArabicNumber(index),
                                      // Verse number in Arabic
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: state.status == "initial"
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
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
                        // : state.status == "recording"
                        //     ? StreamBuilder<RecordingDisposition>(
                        //         stream: bloc.recorder.dispositionStream(),
                        //         builder: (context, snapshot) {
                        //           final duration =
                        //               snapshot.data?.duration ?? Duration.zero;
                        //           final minutes = duration.inMinutes
                        //               .remainder(60)
                        //               .toString()
                        //               .padLeft(2, '0');
                        //           final seconds = duration.inSeconds
                        //               .remainder(60)
                        //               .toString()
                        //               .padLeft(2, '0');
                        //           LogService.w("time is: $duration}");
                        //
                        //           return Column(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceAround,
                        //             children: [
                        //               Text(
                        //                 "$minutes:$seconds",
                        //                 style: const TextStyle(fontSize: 20),
                        //               ),
                        //               Container(
                        //                 margin:
                        //                     const EdgeInsets.only(bottom: 16),
                        //                 child: GestureDetector(
                        //                   onTap: () {
                        //                     LogService.w("time is: $duration}");
                        //                     bloc.add(OnFinishRecording());
                        //                   },
                        //                   child: Container(
                        //                     padding: const EdgeInsets.all(30),
                        //                     decoration: const BoxDecoration(
                        //                       color: Color(
                        //                           0xFF30BF77), // Green color
                        //                       shape: BoxShape.circle,
                        //                     ),
                        //                     child: const Icon(
                        //                       Icons.stop_rounded,
                        //                       size: 32,
                        //                       color: Colors.white,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ],
                        //           );
                        //         },
                        //       )
                            : Column(
                                children: [
                                  // Play the recorded file
                                  GestureDetector(
                                    onTap: () {
                                      //TODO
                                      // Implement playback logic here
                                    },
                                    child: const Icon(Icons.play_arrow),
                                  ),
                                  //TODO
                                ],
                              ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _getArabicNumber(int number) {
    const arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    String numberStr = number.toString();
    String arabicNumber = '';
    for (int i = 0; i < numberStr.length; i++) {
      arabicNumber += arabicNumbers[int.parse(numberStr[i])];
    }
    return ' $arabicNumber';
  }
}
