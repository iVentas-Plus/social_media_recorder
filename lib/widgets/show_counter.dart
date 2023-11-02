library social_media_recorder;

import 'package:flutter/material.dart';
import 'package:social_media_recorder/provider/sound_record_notifier.dart';

/// Used this class to show counter and mic Icon
class ShowCounter extends StatelessWidget {
  final SoundRecordNotifier soundRecorderState;
  final TextStyle? counterTextStyle;
  final Color? counterBackGroundColor;
  final double fullRecordPackageHeight;
  bool middle = false;
  // ignore: sort_constructors_first
  const ShowCounter({
    required this.soundRecorderState,
    required this.fullRecordPackageHeight,
    Key? key,
    this.counterTextStyle,
    required this.counterBackGroundColor,
  }) : super(key: key);

  double _animationOpacity()
  {
    middle = !middle;
    if(middle){
      return 0;
    }
    else {
      return 1;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: fullRecordPackageHeight,
        width: MediaQuery.of(context).size.width * 0.4,
        color: counterBackGroundColor ?? Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    soundRecorderState.second.toString().padLeft(2, '0'),
                    style: counterTextStyle ??
                        const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(width: 3),
                  const Text(" : "),
                  Text(
                    soundRecorderState.minute.toString().padLeft(2, '0'),
                    style: counterTextStyle ??
                        const TextStyle(color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(width: 3),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: _animationOpacity(),
                child: const Icon(
                  Icons.mic,
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
