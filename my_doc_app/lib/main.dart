import 'dart:developer' as devtools;

import 'package:flutter/material.dart';

import 'package:my_doc_app/view/bluettooth%20connection%20view/device_list_widget.dart';
import 'package:my_doc_app/view/recording%20screen/recording_main_widget.dart';
import 'package:my_doc_app/view/share%20files/share_main_widget.dart';

void main() {
  // This is important to be sure that everything is initialized.
  // check on internet to know more about this line;
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Project R22'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// List of widget accessible from the [NavigationBar]
  final List<Widget> _widgetList = [
    const DeviceListWidget(),
    const RecordingMainWidget(),
    const ShareMainWidget(),
  ];

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    devtools.log("Changing index -> $index", name: runtimeType.toString());
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _widgetList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bluetooth_sharp),
            label: 'Bluetooth',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outlined),
            label: 'Recordings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share_outlined),
            label: 'Share',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
