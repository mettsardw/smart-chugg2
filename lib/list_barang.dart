import 'package:flutter/material.dart';

class ListBarang extends StatefulWidget {
  @override
  _ListBarangState createState() => _ListBarangState();
}

class _ListBarangState extends State<ListBarang> {
  int _counter = 2;
  List<String> _dataBarang = ["ASH","BIBI"];

  void _tambahBarang() {
    setState(() {
      _counter++;
      _dataBarang.add(_counter.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Barang")
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _dataBarang.length,
          itemBuilder: (context, int i){
            return new ListTile(
              //leading: FlutterLogo(size: 56.0),
              title: Text(_dataBarang[i]),
              subtitle: Text((_counter*1000).toString()),
              trailing: Icon(Icons.more_vert)
            );
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahBarang,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}