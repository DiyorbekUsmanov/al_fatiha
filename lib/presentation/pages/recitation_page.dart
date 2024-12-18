import 'package:al_fatiha/presentation/blocs/recitation_bloc.dart';
import 'package:al_fatiha/presentation/widgets/controlRecording.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/SurahModel.dart';
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
        backgroundColor: Colors.grey[200],

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
                                entry.key + 1;
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
                    child: controlRecording(context, bloc, state),
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
