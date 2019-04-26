import 'package:flutter/cupertino.dart';

import '../utils/date_compute_utils.dart';

const double _kPickerSheetHeight = 216.0;
const double _kPickerItemHeight = 32.0;

class DatePicker extends StatefulWidget {
  static Future<T> showDatePicker<T>(
    BuildContext context,
    DateTime initialDateTime,
    DateTime minimumDate,
    DateTime maximumDate,
    ValueChanged<DateTime> onDateTimeChanged,
  ) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => DatePicker._(
            initialDateTime,
            minimumDate,
            maximumDate,
            onDateTimeChanged,
          ),
    );
  }

  final DateTime initialDateTime;
  final DateTime minimumDate;
  final DateTime maximumDate;
  final ValueChanged<DateTime> onDateTimeChanged;

  // 私有构造器,不允许外部通过构造器调用,只能通过 showDatePicker 静态方法显示
  DatePicker._(this.initialDateTime, this.minimumDate, this.maximumDate, this.onDateTimeChanged, {Key key}) : super(key: key);

  @override
  State createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  FixedExtentScrollController _yearScrollController;
  FixedExtentScrollController _monthScrollController;
  FixedExtentScrollController _dayScrollController;

  List<StringEntity> _yearStringList;
  List<StringEntity> _monthStringList;
  List<StringEntity> _dayStringList;

  StringEntity _yearSelected;
  StringEntity _monthSelected;
  StringEntity _daySelected;

  @override
  void initState() {
    super.initState();
    _yearStringList = computeYear(widget.minimumDate, widget.maximumDate);
    _monthStringList = computeMonth(widget.minimumDate, widget.maximumDate, widget.initialDateTime.year);
    _dayStringList = computeDay(widget.minimumDate, widget.maximumDate, widget.initialDateTime.year, widget.initialDateTime.month);
    var _yearSelectedIndex;
    var _monthSelectedIndex;
    var _daySelectedIndex;
    // 查找指定年所在位置
    for (_yearSelectedIndex = 0; _yearSelectedIndex < _yearStringList.length; _yearSelectedIndex++) {
      if (_yearStringList[_yearSelectedIndex].key == widget.initialDateTime.year) {
        _yearSelected = _yearStringList[_yearSelectedIndex];
        break;
      }
    }
    // 查找月份所在位置
    for (_monthSelectedIndex = 0; _monthSelectedIndex < _monthStringList.length; _monthSelectedIndex++) {
      if (_monthStringList[_monthSelectedIndex].key == widget.initialDateTime.month) {
        _monthSelected = _monthStringList[_monthSelectedIndex];
        break;
      }
    }
    // 查找 天 所在位置
    for (_daySelectedIndex = 0; _daySelectedIndex < _dayStringList.length; _daySelectedIndex++) {
      if (_dayStringList[_daySelectedIndex].key == widget.initialDateTime.day) {
        _daySelected = _dayStringList[_daySelectedIndex];
        break;
      }
    }
    _yearScrollController = FixedExtentScrollController(initialItem: _yearSelectedIndex);
    _monthScrollController = FixedExtentScrollController(initialItem: _monthSelectedIndex);
    _dayScrollController = FixedExtentScrollController(initialItem: _daySelectedIndex);
  }

  DateTime _computeDateTime() {
    final year = _yearSelected.key;
    final month = _monthSelected.key;
    final day = _daySelected.key;
    final nowDateTime = DateTime.now();
    return DateTime.utc(
      year,
      month,
      day,
      nowDateTime.hour,
      nowDateTime.minute,
      nowDateTime.second,
      nowDateTime.millisecond,
      nowDateTime.microsecond,
    );
  }

  Widget _buildBaseContainer(BuildContext context, Widget content) {
    return Container(
      height: _kPickerSheetHeight,
      color: CupertinoColors.white,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CupertinoButton(
                minSize: 30,
                padding: EdgeInsets.fromLTRB(14, 10, 14, 10),
                child: Text("取消"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              CupertinoButton(
                minSize: 30,
                padding: EdgeInsets.fromLTRB(14, 10, 14, 10),
                child: Text("确定"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop(_computeDateTime());
                },
              ),
            ],
          ),
          // 分割线
          Container(
            height: 0.5,
            color: CupertinoColors.black,
          ),
          Expanded(child: content),
        ],
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: CupertinoPicker(
            looping: true,
            scrollController: _yearScrollController,
            itemExtent: _kPickerItemHeight,
            backgroundColor: CupertinoColors.white,
            onSelectedItemChanged: (index) {
              setState(() {
                _yearSelected = _yearStringList[index];
                // 重新计算月
                final tempMonthStringList = computeMonth(widget.minimumDate, widget.maximumDate, _yearSelected.key);
                _monthStringList = tempMonthStringList;
                _monthSelected = _monthStringList[0];
                _monthScrollController.jumpToItem(0);

                // 重新计算日
                final tempDayStringList = computeDay(widget.minimumDate, widget.maximumDate, _yearSelected.key, _monthSelected.key);
                _dayStringList = tempDayStringList;
                _daySelected = _dayStringList[0];
                _dayScrollController.jumpToItem(0);

                // 选择的日期更新回调
                widget.onDateTimeChanged(_computeDateTime());
              });
            },
            children: List<Widget>.generate(_yearStringList.length, (index) {
              return Center(
                child: Text(_yearStringList[index].value, style: TextStyle(fontSize: 18, color: CupertinoColors.black)),
              );
            }),
          ),
        ),
        Expanded(
          child: CupertinoPicker(
            looping: true,
            scrollController: _monthScrollController,
            itemExtent: _kPickerItemHeight,
            backgroundColor: CupertinoColors.white,
            onSelectedItemChanged: (index) {
              setState(() {
                _monthSelected = _monthStringList[index];
                // 重新计算日
                final tempDayStringList = computeDay(widget.minimumDate, widget.maximumDate, _yearSelected.key, _monthSelected.key);
                _dayStringList = tempDayStringList;
                _daySelected = _dayStringList[0];
                _dayScrollController.jumpToItem(0);

                // 选择的日期更新回调
                widget.onDateTimeChanged(_computeDateTime());
              });
            },
            children: List<Widget>.generate(_monthStringList.length, (int index) {
              return Center(
                child: Text(_monthStringList[index].value, style: TextStyle(fontSize: 18, color: CupertinoColors.black)),
              );
            }),
          ),
        ),
        Expanded(
          child: CupertinoPicker(
            looping: true,
            scrollController: _dayScrollController,
            itemExtent: _kPickerItemHeight,
            backgroundColor: CupertinoColors.white,
            onSelectedItemChanged: (index) {
              setState(() {
                _daySelected = _dayStringList[index];

                // 选择的日期更新回调
                widget.onDateTimeChanged(_computeDateTime());
              });
            },
            children: List<Widget>.generate(_dayStringList.length, (int index) {
              return Center(
                child: Text(_dayStringList[index].value, style: TextStyle(fontSize: 18, color: CupertinoColors.black)),
              );
            }),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildBaseContainer(context, _buildDatePicker(context));
}
