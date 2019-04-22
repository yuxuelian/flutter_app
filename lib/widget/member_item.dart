import 'package:flutter/material.dart';

import 'state_button.dart';

class MemberItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final String name;
  final String phone;
  final String role;
  final String houseNo;
  final String expire;

  MemberItem(this.onTap, this.name, this.phone, this.role, this.houseNo, this.expire);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: StateButtonWidget(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('姓　　名:', style: TextStyle(color: Colors.white, fontSize: 16)),
                  Text('电　　话:', style: TextStyle(color: Colors.white, fontSize: 16)),
                  Text('成员权限:', style: TextStyle(color: Colors.white, fontSize: 16)),
                  Text('房屋编号:', style: TextStyle(color: Colors.white, fontSize: 16)),
                  Text('到期时间:', style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
              Padding(padding: EdgeInsets.only(left: 10)),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(name, style: TextStyle(color: Colors.white, fontSize: 16)),
                    Text(phone, style: TextStyle(color: Colors.white, fontSize: 16)),
                    Text(role, style: TextStyle(color: Colors.white, fontSize: 16)),
                    Text(houseNo, style: TextStyle(color: Colors.white, fontSize: 16)),
                    Text(expire, style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: onTap,
        stateEnabled: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          gradient: LinearGradient(colors: <Color>[Color(0xFF05A8F1), Color(0xFF25EAA6)]),
        ),
        statePressed: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          gradient: LinearGradient(colors: <Color>[Color(0xFF0558F1), Color(0xFF00D080)]),
        ),
      ),
    );
  }
}
