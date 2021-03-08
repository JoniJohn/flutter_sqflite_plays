import 'package:flutter/material.dart';

class Diruiwa extends StatelessWidget {
  final diruiwa = [
    {"id": 0, "name": 'Bobby', "type": 'dog', "color": 'brown', "owner": 3},
    {"id": 1, "name": 'Kitty', "type": 'cat', "color": 'ginger', "owner": 0},
    {"id": 2, "name": 'Micky', "type": 'cat', "color": 'black', "owner": 0},
    {"id": 3, "name": 'Simba', "type": 'piglet', "color": 'pink', "owner": 5},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diruiwa"),
      ),
      body: _diruiwa(diruiwa),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        tooltip: "Tsenya seruiwa se sesha",
      ),
    );
  }

  Widget _diruiwa(List list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, i) {
          print(list[i]);
          return ListTile(
            title: Text(list[i]['name']),
            subtitle: Text("${list[i]['color']} ${list[i]['type']}"),
          );
        });
  }
}
