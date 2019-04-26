class StringEntity {
  final int key;
  final String value;

  const StringEntity(this.key, this.value);

  @override
  String toString() {
    return "key = $key value = $value";
  }
}

const _29 = StringEntity(29, '29日');
const _30 = StringEntity(30, '30日');
const _31 = StringEntity(31, '31日');

const List<StringEntity> monthList = [
  StringEntity(1, '01月'),
  StringEntity(2, '02月'),
  StringEntity(3, '03月'),
  StringEntity(4, '04月'),
  StringEntity(5, '05月'),
  StringEntity(6, '06月'),
  StringEntity(7, '07月'),
  StringEntity(8, '08月'),
  StringEntity(9, '09月'),
  StringEntity(10, '10月'),
  StringEntity(11, '11月'),
  StringEntity(12, '12月'),
];

const List<StringEntity> dayList = [
  StringEntity(1, '01日'),
  StringEntity(2, '02日'),
  StringEntity(3, '03日'),
  StringEntity(4, '04日'),
  StringEntity(5, '05日'),
  StringEntity(6, '06日'),
  StringEntity(7, '07日'),
  StringEntity(8, '08日'),
  StringEntity(9, '09日'),
  StringEntity(10, '10日'),
  StringEntity(11, '11日'),
  StringEntity(12, '12日'),
  StringEntity(13, '13日'),
  StringEntity(14, '14日'),
  StringEntity(15, '15日'),
  StringEntity(16, '16日'),
  StringEntity(17, '17日'),
  StringEntity(18, '18日'),
  StringEntity(19, '19日'),
  StringEntity(20, '20日'),
  StringEntity(21, '21日'),
  StringEntity(22, '22日'),
  StringEntity(23, '23日'),
  StringEntity(24, '24日'),
  StringEntity(25, '25日'),
  StringEntity(26, '26日'),
  StringEntity(27, '27日'),
  StringEntity(28, '28日'),
  _29,
  _30,
  _31,
];

List<StringEntity> computeYear(DateTime min, DateTime max) {
  final res = <StringEntity>[];
  for (int i = min.year; i <= max.year; i++) {
    res.add(StringEntity(i, '$i年'));
  }
  return res;
}

List<StringEntity> computeMonth(DateTime min, DateTime max, int currentYear) {
  final minYear = min.year;
  final maxYear = max.year;
  List<StringEntity> res;
  if (currentYear == minYear && currentYear == maxYear) {
    res = monthList.sublist(min.month - 1, max.month);
  } else if (currentYear == minYear) {
    res = monthList.sublist(min.month - 1);
  } else if (currentYear == maxYear) {
    res = monthList.sublist(0, max.month);
  } else {
    res = monthList;
  }
  return res;
}

List<StringEntity> computeDay(DateTime min, DateTime max, int currentYear, int currentMonth) {
  final minYear = min.year;
  final maxYear = max.year;
  final minMonth = min.month;
  final maxMonth = max.month;
  List<StringEntity> res;
  if (currentYear == minYear && currentYear == maxYear) {
    if (currentMonth == minMonth && currentMonth == maxMonth) {
      // 最大最小都在同一年的同一个月中
      res = dayList.sublist(min.day - 1, max.day);
    } else if (currentMonth == minMonth) {
      // 第一年的第一月
      res = dayList.sublist(min.day - 1);
    } else if (currentMonth == maxMonth) {
      // 第一年的最后一月
      res = dayList.sublist(0, max.day);
    } else {
      res = dayList;
    }
  } else if (currentYear == minYear) {
    if (currentMonth == minMonth) {
      // 第一年的第一个月
      res = dayList.sublist(min.day - 1);
    } else {
      res = dayList;
    }
  } else if (currentYear == maxYear) {
    if (currentMonth == maxMonth) {
      // 最后一年的最后一个月
      res = dayList.sublist(0, max.day);
    } else {
      res = dayList;
    }
  } else {
    res = dayList;
  }
  return _checkDayList(res, currentYear, currentMonth);
}

bool _isLeapYear(int year) {
  if (year % 100 == 0) {
    return year % 400 == 0;
  } else {
    return year % 4 == 0;
  }
}

List<StringEntity> _checkDayList(List<StringEntity> dayList, int currentYear, int currentMonth) {
  var index = -1;
  switch (currentMonth) {
    case 2:
      if (_isLeapYear(currentYear)) {
        // 是闰年的情况,就去找是否有 30
        index = dayList.indexOf(_30);
      } else {
        // 不是闰年的情况,就去找是否有 29
        index = dayList.indexOf(_29);
      }
      break;
    case 4:
    case 6:
    case 9:
    case 11:
      // 是否有 31
      index = dayList.indexOf(_31);
      break;
  }
  if (index != -1) {
    return dayList.sublist(0, index);
  } else {
    return dayList;
  }
}
