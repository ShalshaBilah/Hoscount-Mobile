import 'package:flutter/material.dart';

class HistoriPage extends StatefulWidget {
  const HistoriPage({super.key});

  @override
  _HistoriPageState createState() => _HistoriPageState();
}

class _HistoriPageState extends State<HistoriPage> {
  List<String> history = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                return const ListTile(
                  title: Text('Halo'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
