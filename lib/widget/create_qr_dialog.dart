import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import '../bean/index.dart';
import '../page/visitor_qr_code_page.dart';
import '../store/user_store.dart';
import '../widget/single_picker.dart';
import 'custom_alert_dialog.dart';
import 'logo.dart';

const _validateTypeList = ['一天一次有效', '连续三天有效'];

class CreateQrDialogWidget extends StatefulWidget {
  @override
  State createState() => _CreateQrDialogState();
}

class _CreateQrDialogState extends State<CreateQrDialogWidget> {
  HouseMember _selectHouseMember;
  int _selectValidateTypeIndex;

  Widget _buildLine1(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)), top: BorderSide(color: Color(0xFFD0D0D0)))),
      padding: EdgeInsets.only(left: 20),
      height: 40,
      child: Row(
        children: <Widget>[
          Image.asset('assets/icon_user.png', width: 20),
          Padding(
            padding: EdgeInsets.only(left: 16),
          ),
          Expanded(
            child: CupertinoTextField(
              maxLines: 1,
              autofocus: false,
              padding: EdgeInsets.all(0),
              placeholder: '访客姓名(非必填)',
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 14, color: Color(0xFF303030)),
              decoration: BoxDecoration(border: Border()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLine2(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
      padding: EdgeInsets.only(left: 20),
      height: 40,
      child: Row(
        children: <Widget>[
          Image.asset('assets/icon_phone.png', width: 20),
          Padding(
            padding: EdgeInsets.only(left: 16),
          ),
          Expanded(
            child: CupertinoTextField(
              maxLines: 1,
              autofocus: false,
              padding: EdgeInsets.all(0),
              placeholder: '访客电话(非必填)',
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 14, color: Color(0xFF303030)),
              decoration: BoxDecoration(border: Border()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLine3(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
      padding: EdgeInsets.only(left: 20),
      height: 40,
      child: Provide<BaseUserStore>(builder: (context, child, userStore) {
        return GestureDetector(
          onTap: () async {
            final resIndex = await SinglePicker.showSinglePicker(context, _validateTypeList, (index) {});
            if (resIndex != null) {
              setState(() {
                _selectValidateTypeIndex = resIndex;
              });
            }
          },
          child: Row(
            children: <Widget>[
              Image.asset('assets/icon_validate_time.png', width: 20),
              Padding(
                padding: EdgeInsets.only(left: 16),
              ),
              Text(_selectValidateTypeIndex == null ? '请选择过期类型' : _validateTypeList[_selectValidateTypeIndex], style: TextStyle(fontSize: 14, color: Color(0xFF303030))),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildLine4(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
      padding: EdgeInsets.only(left: 20),
      height: 40,
      child: Provide<BaseUserStore>(builder: (context, child, userStore) {
        return GestureDetector(
          onTap: () async {
            final houseMemberList = userStore.selectedCommunity.house_member;
            final showStringList = houseMemberList.map<String>((value) => value.fullHouseName).toList();
            final resIndex = await SinglePicker.showSinglePicker(context, showStringList, (index) {});
            if (resIndex != null) {
              setState(() {
                _selectHouseMember = houseMemberList[resIndex];
              });
            }
          },
          child: Row(
            children: <Widget>[
              Image.asset('assets/icon_house.png', width: 20),
              Padding(
                padding: EdgeInsets.only(left: 16),
              ),
              Text(_selectHouseMember == null ? '请选择房屋' : _selectHouseMember.fullHouseName, style: TextStyle(fontSize: 14, color: Color(0xFF303030))),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildBtn(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: FlatButton(
                color: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Color(0xFFD0D0D0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15))),
                child: Text('生成历史', style: TextStyle(fontSize: 14, color: Color(0xFF606060))),
                onPressed: () {
                  // 点击生成历史
                  Navigator.of(context, rootNavigator: true).pop(false);
                },
              ),
            ),
          ),
          Container(
            width: 1,
            color: Color(0xFFD0D0D0),
            child: Column(),
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: FlatButton(
                color: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Color(0xFFD0D0D0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(15))),
                child: Text('立即生成', style: TextStyle(fontSize: 14, color: Color(0xFFEB891A))),
                onPressed: () {
                  // TODO 联网创建访客二维码

                  // TODO 关闭当前页面
                  Navigator.of(context).pop();
                  var qrCodeBean = QrCodeBean.fromJson(json.decode(
                      '{"house_no":"000999","name":"","gender":1,"house":{"id":"RvK7iKCo4Si","name":"1","type":1,"type_name":"楼栋","unit":"001"},"expire":"2019-04-23 00:03:28","phone":"","qr_code":"4rdT6jrmtPWU9WeZhvFynC","created_at":"2019-04-22 00:03:27","pass_limit":0}'));
                  // TODO 跳转到访客二维码显示二面
                  VisitorQrCodePage.start(context, qrCodeBean);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialogWidget(
      content: Container(
        width: 260,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              LogoWidget(),
              _buildLine1(context),
              _buildLine2(context),
              _buildLine3(context),
              _buildLine4(context),
              _buildBtn(context),
            ],
          ),
        ),
      ),
    );
  }
}
