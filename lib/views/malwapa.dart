import 'package:flutter/material.dart';

import 'package:flutter_sqflite_plays/models/entities.dart';
import 'package:flutter_sqflite_plays/utils/dbhelper.dart';

class Malwapa extends StatefulWidget {
  @override
  _MalwapaState createState() => _MalwapaState();
}

class _MalwapaState extends State<Malwapa> {
  List<Lelwapa> malwapa = [];
  //  = [
  //   {
  //     "id": 0,
  //     "surname": "Johnson",
  //     "plot": 123,
  //     "housenumber": 1,
  //     "town": 'Tlokweng',
  //   },
  //   {
  //     "id": 1,
  //     "surname": "Letlole",
  //     "plot": 123,
  //     "housenumber": 2,
  //     "town": 'Tlokweng',
  //   },
  //   {
  //     "id": 2,
  //     "surname": "Lekomola",
  //     "plot": 123,
  //     "housenumber": 3,
  //     "town": 'Tlokweng',
  //   },
  // ];

  @override
  void initState() {
    super.initState();
    _getMalwapa();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Malwapa"),
      ),
      body: _batho(malwapa),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return TsenyaLelwapa();
              },
            ),
          );
          _getMalwapa();
        },
        child: Icon(Icons.add),
        tooltip: "Tsenya lelwapa le lesha",
      ),
    );
  }

  Widget _batho(List list) {
    return ListView.builder(
        itemCount: malwapa.length,
        itemBuilder: (context, i) {
          var lelwapa = malwapa[i].toMap();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("House of ${lelwapa['surname']}"),
              subtitle: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Plot: ${lelwapa['plot']}"),
                      Text("Housenumber: ${lelwapa['housenumber']}"),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _getMalwapa() {
    DBHelper db = DBHelper();
    List<Lelwapa> mlp = [];
    var res = db.getMalwapa();
    res.then((value) {
      value.forEach((element) {
        mlp.add(Lelwapa.fromObject(element));
      });
      setState(() {
        malwapa = mlp;
      });
    });
  }
}

class TsenyaLelwapa extends StatefulWidget {
  @override
  _TsenyaLelwapaState createState() => _TsenyaLelwapaState();
}

class _TsenyaLelwapaState extends State<TsenyaLelwapa> {
  DBHelper helper;
  final _globalKey = GlobalKey<FormState>();

  // controllers
  TextEditingController surname = TextEditingController();
  TextEditingController plot = TextEditingController();
  TextEditingController housenumber = TextEditingController();
  TextEditingController town = TextEditingController();

  @override
  void initState() {
    super.initState();
    helper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tsenya Lelwapa"),
      ),
      body: _lelwapaForm(),
    );
  }

  Widget _lelwapaForm() {
    return Form(
      key: _globalKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: surname,
              decoration: InputDecoration(
                  labelText: "Household Surname",
                  hintText: "Leina la Lelwapa",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: plot,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Plot number",
                  hintText: "Residential address",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: housenumber,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Housenumber",
                  hintText: "Housenumber",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: town,
              decoration: InputDecoration(
                  labelText: "Town",
                  hintText: "Town which the house is located",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (_globalKey.currentState.validate()) {
                      DBHelper db = DBHelper();

                      Lelwapa lelwapa = Lelwapa(null, null, null, null);
                      lelwapa.surname = surname.text;
                      lelwapa.plot = int.parse(plot.text);
                      lelwapa.housenumber = int.parse(housenumber.text);
                      lelwapa.town = town.text;

                      var res = db.insertLelwapa(lelwapa);

                      res.then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${lelwapa.surname} has been added"),
                          ),
                        );
                        Navigator.pop(context, true);
                      });
                    }
                  },
                  child: Text("submit"))),
        ],
      ),
    );
  }
}
