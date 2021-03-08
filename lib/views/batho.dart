import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Batho extends StatelessWidget {
  final listOfPeople = [
    {
      "id": 0,
      "name": "Thuto",
      "age": 29,
      "gender": "M",
      "hobbies": ['programming', 'gaming', 'cooking'],
      "household_id": 0,
    },
    {
      "id": 1,
      "name": "Tshepang",
      "age": 26,
      "gender": "F",
      "hobbies": ['reading', 'cooking', 'watching TV'],
      "household_id": 1,
    },
    {
      "id": 2,
      "name": "Happy",
      "age": 22,
      "gender": "F",
      "hobbies": ['listening to music', 'social media'],
      "household_id": 1,
    },
    {
      "id": 3,
      "name": "Lebi",
      "age": 29,
      "gender": "F",
      "hobbies": ['watching TV', 'cooking'],
      "household_id": 2,
    },
    {
      "id": 4,
      "name": "Senate",
      "age": 26,
      "gender": "F",
      "hobbies": ['cooking'],
      "household_id": 2,
    },
    {
      "id": 5,
      "name": "Lebole",
      "age": 25,
      "gender": "F",
      "hobbies": ['reading books', 'watching TV', 'sports'],
      "household_id": 2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Batho"),
      ),
      body: _bathoList(listOfPeople),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        tooltip: "Tsenya motho yo mosha",
      ),
    );
  }

  Widget _bathoList(List list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, i) {
          print(list[i]);
          return ListTile(
            title: Text(list[i]['name']),
            subtitle: Text("Age: ${list[i]['age']}"),
          );
        });
  }
}
