library social_media_recorder;

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:social_media_recorder/provider/sound_record_notifier.dart';
import 'package:social_media_recorder/widgets/show_counter.dart';

// ignore: must_be_immutable
class SoundRecorderWhenLockedDesign extends StatelessWidget {
  final double fullRecordPackageHeight;
  final SoundRecordNotifier soundRecordNotifier;
  final String? cancelText;
  final Function sendRequestFunction;
  final Function(String time)? stopRecording;
  final Widget? recordIconWhenLockedRecord;
  final TextStyle? cancelTextStyle;
  final TextStyle? counterTextStyle;
  final Color recordIconWhenLockBackGroundColor;
  final Color? counterBackGroundColor;
  final Color? cancelTextBackGroundColor;
  final Widget? sendButtonIcon;

  // ignore: sort_constructors_first
  const SoundRecorderWhenLockedDesign({
    Key? key,
    required this.fullRecordPackageHeight,
    required this.sendButtonIcon,
    required this.soundRecordNotifier,
    required this.cancelText,
    required this.sendRequestFunction,
    this.stopRecording,
    required this.recordIconWhenLockedRecord,
    required this.cancelTextStyle,
    required this.counterTextStyle,
    required this.recordIconWhenLockBackGroundColor,
    required this.counterBackGroundColor,
    required this.cancelTextBackGroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double iconSize = fullRecordPackageHeight.clamp(24.0, 48.0);

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: cancelTextBackGroundColor ?? Colors.grey.shade100,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Send icon
          InkWell(
            onTap: () async {
              soundRecordNotifier.isShow = false;
              soundRecordNotifier.finishRecording();
              sendRequestFunction();
            },
            child: Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                color: recordIconWhenLockBackGroundColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: recordIconWhenLockedRecord ??
                    sendButtonIcon ??
                    Icon(
                      Icons.send,
                      size: iconSize * 0.6,
                      color: soundRecordNotifier.buttonPressed
                          ? Colors.grey.shade200
                          : Colors.black,
                    ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Cancel text
          SizedBox(
            width: iconSize * 1.5,
            height: iconSize * 0.8,
            child: InkWell(
              onTap: () {
                soundRecordNotifier.isShow = false;
                final String _time = '${soundRecordNotifier.minute}:${soundRecordNotifier.second}';
                if (stopRecording != null) stopRecording!(_time);
                soundRecordNotifier.resetEdgePadding();
              },
              child: Center(
                child: Text(
                  cancelText ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: cancelTextStyle ?? const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Counter
          ShowCounter(
            soundRecorderState: soundRecordNotifier,
            counterTextStyle: counterTextStyle,
            counterBackGroundColor: counterBackGroundColor,
            fullRecordPackageHeight: fullRecordPackageHeight,
          ),
        ],
      ),
    );
  }
}