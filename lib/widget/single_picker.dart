import 'package:flutter/cupertino.dart';

const double _kPickerSheetHeight = 216.0;
const double _kPickerItemHeight = 32.0;

class SinglePicker extends StatefulWidget {
  static Future<T> showSinglePicker<T>(
    BuildContext context,
    List<String> showStringList,
    ValueChanged<int> onSelectedItemChanged,
  ) {
    assert(showStringList.length > 0);
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => SinglePicker._(
            showStringList,
            onSelectedItemChanged,
          ),
    );
  }

  final List<String> _showStringList;
  final ValueChanged<int> _onSelectedItemChanged;

  SinglePicker._(this._showStringList, this._onSelectedItemChanged, {Key key}) : super(key: key);

  @override
  State createState() => _SinglePickerState();
}

class _SinglePickerState extends State<SinglePicker> {
  int _selectedIndex = 0;

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
                  Navigator.of(context, rootNavigator: true).pop(_selectedIndex);
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

  @override
  Widget build(BuildContext context) => _buildBaseContainer(
        context,
        CupertinoPicker(
          looping: true,
          itemExtent: _kPickerItemHeight,
          backgroundColor: CupertinoColors.white,
          onSelectedItemChanged: (index) {
            // 记录一下index
            _selectedIndex = index;
            widget._onSelectedItemChanged(index);
          },
          children: List<Widget>.generate(widget._showStringList.length, (index) {
            return Center(
              child: Text(widget._showStringList[index], style: TextStyle(fontSize: 18, color: CupertinoColors.black)),
            );
          }),
        ),
      );
}
