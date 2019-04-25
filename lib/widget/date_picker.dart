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
    assert(minimumDate.millisecondsSinceEpoch <= initialDateTime.millisecondsSinceEpoch);
    assert(initialDateTime.millisecondsSinceEpoch <= maximumDate.millisecondsSinceEpoch);
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => DatePicker(
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

  DatePicker(this.initialDateTime, this.minimumDate, this.maximumDate, this.onDateTimeChanged, {Key key}) : super(key: key);

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

  Widget _buildBaseContainer(BuildContext context, Row row) {
    return Container(
      height: _kPickerSheetHeight,
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 18.0,
        ),
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
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            ),
            // 分割线
            Container(
              height: 0.5,
              color: CupertinoColors.black,
            ),
            Expanded(child: row),
          ],
        ),
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
              // 记录选中的年
              _yearSelected = _yearStringList[index];
              setState(() {
                // 计算月的合法性
                final tempMonthStringList = computeMonth(widget.minimumDate, widget.maximumDate, _yearStringList[index].key);
                // 赋值  重新加载数据
                _monthStringList = tempMonthStringList;
                // 移动到 0 位置
                _monthScrollController.jumpToItem(0);

                print(_yearSelected);
                print(_monthSelected);

//                print("tempMonthStringList.length = ${tempMonthStringList.length}");
//                // 获取上一次选中的月份的位置
//                var lastIndex = tempMonthStringList.indexOf(_monthSelected);
//                // 未查找到(会返回 -1)
//                if (lastIndex != -1) {
//                  _monthScrollController.jumpToItem(lastIndex);
//                } else {
//                  _monthScrollController.jumpToItem(0);
//                }
              });
            },
            children: List<Widget>.generate(_yearStringList.length, (index) {
              return Center(
                child: Text(_yearStringList[index].value),
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
              print("_monthScrollController----index = $index----");
              // 记录一下本次选中的实体
              _monthSelected = _monthStringList[index];
              setState(() {
                // 需要更新 天 显示
              });
            },
            children: List<Widget>.generate(_monthStringList.length, (int index) {
              return Center(
                child: Text(_monthStringList[index].value),
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
              // 记录一下本次选中的实体
              _daySelected = _dayStringList[index];
              setState(() {
                // 更新状态
              });
            },
            children: List<Widget>.generate(_dayStringList.length, (int index) {
              return Center(
                child: Text(_dayStringList[index].value),
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
