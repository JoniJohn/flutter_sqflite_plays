import 'package:flutter/material.dart';

import 'package:flutter_sqflite_plays/models/entities.dart';
import 'package:flutter_sqflite_plays/utils/dbhelper.dart';

class Malwapa extends StatefulWidget {
  @override
  _MalwapaState createState() => _MalwapaState();
}

class _MalwapaState extends State<Malwapa> {
  @override
  void initState() {
    super.initState();
    // _getMalwapa();
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
      body: _batho(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return TsenyaLelwapa();
              },
            ),
          );
          // _getMalwapa();
        },
        child: Icon(Icons.home),
        tooltip: "Tsenya lelwapa le lesha",
      ),
    );
  }

  Widget _batho() {
    DBHelper db = DBHelper();
    return FutureBuilder<List<Lelwapa>>(
      future: db.getMalwapa(),
      builder: (BuildContext context, AsyncSnapshot<List<Lelwapa>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                Lelwapa lelwapa = snapshot.data[i];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Dismissible(
                    background: Container(
                      color: Colors.red,
                    ),
                    onDismissed: (direction) {
                      var res = db.deleteLelwapa(lelwapa);
                      res.then((value) {
                        setState(() => snapshot.data.remove(value));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("${lelwapa.surname} has been deleted."),
                          ),
                        );
                      });
                    },
                    key: UniqueKey(),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                LelwapaDetails(lelwapa)));
                      },
                      title: Text("House of ${lelwapa.surname}"),
                      subtitle: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Plot: ${lelwapa.plot}"),
                              Text("Housenumber: ${lelwapa.housenumber}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
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

class LelwapaDetails extends StatelessWidget {
  final Lelwapa lelwapa;
  LelwapaDetails(this.lelwapa);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("House of ${lelwapa.surname}"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("id: ${lelwapa.id}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("surname: ${lelwapa.surname}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("plot: ${lelwapa.plot}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("housenumber: ${lelwapa.housenumber}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("town: ${lelwapa.town}"),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            height: 47.5,
            width: 47.5,
            child: FloatingActionButton(
              backgroundColor: Colors.accents[6],
              heroTag: "edit",
              tooltip: "edit household details",
              onPressed: () {},
              child: Icon(Icons.edit),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          FloatingActionButton(
            heroTag: "add",
            tooltip: "add a new household member",
            onPressed: () {},
            child: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
