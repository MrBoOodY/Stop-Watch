import 'package:flutter/material.dart';
import 'package:stop_watch/shared_preferences/shared_preference_helper.dart';
import 'package:stop_watch/view_model/stop_watch_view_model.dart';

class StopWatchView extends StatefulWidget {
  const StopWatchView({Key? key}) : super(key: key);

  @override
  State<StopWatchView> createState() => _StopWatchViewState();
}

class _StopWatchViewState extends State<StopWatchView> {
  bool _isLoading = true;
  final StopWatchViewModel _stopWatchViewModel = StopWatchViewModel();
  @override
  void initState() {
    super.initState();
    SharedPreferenceHelper.init().then((_) {
      _isLoading = false;
      if (mounted) {
        setState(() {});
      }
    });
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  ValueListenableBuilder<Duration>(
                    valueListenable: _stopWatchViewModel.stopWatchTime,
                    builder: (_, stopWatchTime, __) {
                      return Column(
                        children: [
                          Text(
                            '${twoDigits(stopWatchTime.inHours)}:${twoDigits(stopWatchTime.inMinutes.remainder(60))}:${twoDigits(stopWatchTime.inSeconds.remainder(60))}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _stopWatchViewModel.changeStopWatchStatus();
                                },
                                child: ValueListenableBuilder<bool>(
                                  valueListenable:
                                      _stopWatchViewModel.isRunning,
                                  builder: (_, isRunning, __) => Text(
                                      stopWatchTime.inSeconds == 0
                                          ? 'Start'
                                          : (isRunning ? 'Pause' : 'Resume')),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  _stopWatchViewModel.resetStopWatch();
                                },
                                style: TextButton.styleFrom(
                                    textStyle:
                                        const TextStyle(color: Colors.red)),
                                child: const Text('Reset'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 50.0),
                          Text(
                            'Time In Seconds : ${stopWatchTime.inSeconds}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 50.0),
                  Text(
                    'Last Time In Seconds Before Termination : ${SharedPreferenceHelper.getStopWatchInSeconds}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
      )),
    );
  }
}
