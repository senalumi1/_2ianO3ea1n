import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _hourlyLabels = prefs.getStringList('ff_hourlyLabels') ?? _hourlyLabels;
    });
    _safeInit(() {
      _hourlyCount =
          prefs.getStringList('ff_hourlyCount')?.map(int.parse).toList() ??
              _hourlyCount;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _loginTrigger = false;
  bool get loginTrigger => _loginTrigger;
  set loginTrigger(bool value) {
    _loginTrigger = value;
  }

  List<String> _hourlyLabels = [
    '1am',
    '2am',
    '3am',
    '4am',
    '5am',
    '6am',
    '7am',
    '8am',
    '9am',
    '10am',
    '11am',
    '12pm',
    '13pm',
    '14pm',
    '15pm',
    '16pm',
    '17pm',
    '18pm',
    '19pm',
    '20pm'
  ];
  List<String> get hourlyLabels => _hourlyLabels;
  set hourlyLabels(List<String> value) {
    _hourlyLabels = value;
    prefs.setStringList('ff_hourlyLabels', value);
  }

  void addToHourlyLabels(String value) {
    hourlyLabels.add(value);
    prefs.setStringList('ff_hourlyLabels', _hourlyLabels);
  }

  void removeFromHourlyLabels(String value) {
    hourlyLabels.remove(value);
    prefs.setStringList('ff_hourlyLabels', _hourlyLabels);
  }

  void removeAtIndexFromHourlyLabels(int index) {
    hourlyLabels.removeAt(index);
    prefs.setStringList('ff_hourlyLabels', _hourlyLabels);
  }

  void updateHourlyLabelsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    hourlyLabels[index] = updateFn(_hourlyLabels[index]);
    prefs.setStringList('ff_hourlyLabels', _hourlyLabels);
  }

  void insertAtIndexInHourlyLabels(int index, String value) {
    hourlyLabels.insert(index, value);
    prefs.setStringList('ff_hourlyLabels', _hourlyLabels);
  }

  List<int> _hourlyCount = [
    1,
    2,
    3,
    2,
    2,
    1,
    5,
    20,
    4,
    0,
    5,
    0,
    12,
    5,
    3,
    1,
    9,
    11,
    0,
    6
  ];
  List<int> get hourlyCount => _hourlyCount;
  set hourlyCount(List<int> value) {
    _hourlyCount = value;
    prefs.setStringList(
        'ff_hourlyCount', value.map((x) => x.toString()).toList());
  }

  void addToHourlyCount(int value) {
    hourlyCount.add(value);
    prefs.setStringList(
        'ff_hourlyCount', _hourlyCount.map((x) => x.toString()).toList());
  }

  void removeFromHourlyCount(int value) {
    hourlyCount.remove(value);
    prefs.setStringList(
        'ff_hourlyCount', _hourlyCount.map((x) => x.toString()).toList());
  }

  void removeAtIndexFromHourlyCount(int index) {
    hourlyCount.removeAt(index);
    prefs.setStringList(
        'ff_hourlyCount', _hourlyCount.map((x) => x.toString()).toList());
  }

  void updateHourlyCountAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    hourlyCount[index] = updateFn(_hourlyCount[index]);
    prefs.setStringList(
        'ff_hourlyCount', _hourlyCount.map((x) => x.toString()).toList());
  }

  void insertAtIndexInHourlyCount(int index, int value) {
    hourlyCount.insert(index, value);
    prefs.setStringList(
        'ff_hourlyCount', _hourlyCount.map((x) => x.toString()).toList());
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
