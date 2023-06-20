import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class Note {
  static const Map<int, String> _intToNote = {
    0: 'b10',
    1: 'b20',
    2: 'b50',
    3: 'b100',
    4: 'b200',
  };
  static const Map<String, int> _noteToInt = {
    'b10': 0,
    'b20': 1,
    'b50': 2,
    'b100': 3,
    'b200': 4,
  };
  static const Map<String, int> _noteToValues = {
    'b10': 10,
    'b20': 20,
    'b50': 50,
    'b100': 100,
    'b200': 200,
  };

  static final Map<String, Color> noteToColor = {
    'b10': diezColor,
    'b20': veinteColor,
    'b50': cincuentaColor,
    'b100': cienColor,
    'b200': dcienColor,
  };

  static const TABLE_NAME = "notes";
  static const COLUMN_ID = "id";
  static const COLUMN_NOTE = "note";
  static const COLUMN_DATETIME = "datetime";
  int? id;
  int? note;
  int? datetimeInt;
  late DateTime datetime;
  String? label;
  int? value;

  Note({this.id, this.label, this.datetimeInt});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      COLUMN_NOTE: _noteToInt[label],
    };
    if (id != null) {
      map[COLUMN_ID] = id;
    }
    if (datetimeInt != null) {
      map[COLUMN_DATETIME] = datetimeInt;
    }
    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    id = map[COLUMN_ID];
    note = map[COLUMN_NOTE];
    datetimeInt = map[COLUMN_DATETIME];
    datetime = DateTime.fromMicrosecondsSinceEpoch(datetimeInt!);
    label = _intToNote[note];
    value = _noteToValues[label];
  }
}
