import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class Note {
  static const Map<int, String> _intToNote = {
    0: 'diez',
    1: 'veinte',
    2: 'cincuenta',
    3: 'cien',
    4: 'doscientos',
  };
  static const Map<String, int> _noteToInt = {
    'diez': 0,
    'veinte': 1,
    'cincuenta': 2,
    'cien': 3,
    'doscientos': 4,
  };
  static const Map<String, int> _noteToValues = {
    'diez': 10,
    'veinte': 20,
    'cincuenta': 50,
    'cien': 100,
    'doscientos': 200,
  };

  static final Map<String, Color> noteToColor = {
    'diez': diezColor,
    'veinte': veinteColor,
    'cincuenta': cincuentaColor,
    'cien': cienColor,
    'doscientos': dcienColor,
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
