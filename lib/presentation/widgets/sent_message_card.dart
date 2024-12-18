import 'package:al_fatiha/core/services/log_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
import 'package:just_audio/just_audio.dart';
import '../../data/models/MessageModel.dart';
import 'dart:async';

class SentMessageWidget extends StatefulWidget {
  final MessageModel message;

  const SentMessageWidget({super.key, required this.message});

  @override
  _SentMessageWidgetState createState() => _SentMessageWidgetState();
}

class _SentMessageWidgetState extends State<SentMessageWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration? _audioDuration;
  bool _isPlaying = false;

  List<double> _waveformSamples = [];

  @override
  void initState() {
    super.initState();
    _loadAudio();
    _listenToWaveform();
  }

  Future<void> _loadAudio() async {
    try {
      await _audioPlayer.setFilePath(widget.message.audioPath!);
      setState(() {
        _audioDuration = _audioPlayer.duration;
      });
      LogService.w("Audio Duration: $_audioDuration");
      _listenToWaveform();
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  void _listenToWaveform() {
    _audioPlayer.positionStream.listen((position) {
      final total = _audioDuration?.inMilliseconds ?? 1;
      final current = position.inMilliseconds;

      if (total > 0) {
        final progress = current / total;

        setState(
          () {
            _waveformSamples = List.generate(
              60,
              (index) {
                final stepProgress = index / 60;
                return stepProgress <= progress
                    ? (index % 10 + 5).toDouble()
                    : 2.0;
              },
            );
          },
        );
      }
    });
  }

  Future<void> _togglePlay() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }

    setState(() {
      _isPlaying = !_isPlaying;
    });

    _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Play Button
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                          ),
                          onPressed: _togglePlay,
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Waveform
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          // child:
                          // Center(
                          //     child: Text(
                          //       "Place for Audio Wave",
                          //       // Replace with wave UI
                          //       style: TextStyle(color: Colors.grey[400]),
                          //     ),),
                          child: PolygonWaveform(
                            samples: _waveformSamples,
                            // Updated list of samples
                            height: 10,
                            width: MediaQuery.of(context).size.width * 0.5,
                            absolute: true,
                            inactiveColor: Colors.grey.shade300,
                            activeColor: Colors.blue,
                          ),
                        ),
                      ),

                      Text(
                        _audioDuration != null
                            ? _formatDuration(_audioDuration!)
                            : "00:00",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Text below the audio widget
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${TimeOfDay.now().format(context)}, ${DateTime.now().toLocal().toString().split(' ')[0]}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
