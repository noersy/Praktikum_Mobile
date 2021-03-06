import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modul3/View/component/AddNotification.dart';
import 'package:modul3/View/component/indecatorLoad.dart';
import 'package:modul3/model/KelasModel/Kelas.dart';
import 'package:modul3/model/KelasModel/Notif.dart';
import 'package:modul3/model/KelasModel/Scadule.dart';
import 'package:modul3/service/PushNotificationService.dart';
import 'package:modul3/thame/PaletteColor.dart';
import 'package:provider/provider.dart';

import 'ConsolePage/ConsolePage.dart';
import 'HomePage/HomePage.dart';
import 'UserBottomSheetFialog/UserBottomSheetDialog.dart';

class DashboardPage extends StatefulWidget {
  final String username;
  final String fullname;

  const DashboardPage({@required this.username, this.fullname});

  @override
  _Dashboard createState() => _Dashboard(this.username, this.fullname);
}

class _Dashboard extends State<DashboardPage> {
  final PushNotificationService _navigationService = PushNotificationService();
  final AddNotification _addNotification = new AddNotification();
  final String username;
  final String fullname;
  String _token = "Waiting for token...";
  int _bottomNavBarSelectedIndex = 0;
  bool _newNotification = false;
  bool _newSchedule = false;
  List<Notif> _notif = [];
  List<Kelas> _schadule = [];
  List<DataKelas> _itemKelas = [];
  List<String> _list = [];

  _Dashboard(this.username, this.fullname);

  @override
  void initState() {
    _navigationService.initialise(
      handlerNotification: _handlerNotification,
      handlerScadule: _handlerScadule,
    );
    _navigationService.getToken().then((value) {
      setState(() {
        _token = value;
      });
    });
    print(_token);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      HomePage(),
      ConsolePage(),
      //NotificationPage(item: _notif),
    ];

    return Scaffold(
      /* floatingActionButton: FloatingActionButton(
          backgroundColor: PaletteColor.primarybg2,
          onPressed: () {
            _addNotification.addNotificationPopUp(
                context: context, token: _token);
            print(_token);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.add, color: PaletteColor.black,),
          ),
        ),*/
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset_outlined),
            title: Text('Console'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _bottomNavBarSelectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
      body: _children[_bottomNavBarSelectedIndex],);
  }

  _onItemTapped(index) {
    if (index != _bottomNavBarSelectedIndex) {
      if (index != 2) {
        setState(() {
          if (index == 2) {
            _newNotification = false;
          }
          if (index == 1) {
            _newSchedule = false;
          }
          _bottomNavBarSelectedIndex = index;
        });
      }
      if (index == 2)
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) =>
              UserBottomSheetDialog(ctx: context),
        );
    }
  }


  void _handlerScadule(Schedule item) {
    print("schedule yes : " + item.toJson().toString());
    int index = _list.indexWhere((value) => value.contains(item.data.hari));
    _newSchedule = _bottomNavBarSelectedIndex == 1 ? false : true;
    setState(() {
      if (index >= 0) {
        _itemKelas = _schadule[index].data;
        _itemKelas.add(DataKelas(
          nama: item.data.kelas,
          lab: item.data.lab,
          tempat: item.data.tempat,
          jam: item.data.jam,
        ));
      } else {
        _itemKelas = [];
        _itemKelas.add(DataKelas(
            nama: item.data.kelas,
            lab: item.data.lab,
            tempat: item.data.tempat,
            jam: item.data.jam));
        _schadule.add(Kelas(schedule: item.data.hari, data: _itemKelas));
        _list.add(item.data.hari);
      }
    });
  }

  void _handlerNotification(Notif notif) {
    print("notif yes");
    setState(() {
      _newNotification = _bottomNavBarSelectedIndex == 2 ? false : true;
      _notif.add(notif);
    });
  }
}
