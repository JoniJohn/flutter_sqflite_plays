class Lelwapa {
  int id;
  String surname;
  int plot;
  int housenumber;
  String town;

  // constructors
  Lelwapa(this.surname, this.plot, this.housenumber, this.town);
  Lelwapa.withId(this.id, this.surname, this.plot, this.housenumber, this.town);

  /// setters
  ///
  /// getters
  ///

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['surname'] = this.surname;
    map['plot'] = this.plot;
    map['housenumber'] = this.housenumber;
    map['town'] = this.town;
    if (this.id != null) map['id'] = this.id;

    return map;
  }

  Lelwapa.fromObject(dynamic o) {
    this.id = o['id'];
    this.surname = o['surname'];
    this.plot = o['plot'];
    this.housenumber = o['housenumber'];
    this.town = o['town'];
  }
}

class Motho {
  int id;
  String name;
  int age;
  String gender;
  int household;

  Motho(this.name, this.age, this.gender, this.household);
  Motho.withId(this.id, this.name, this.age, this.gender, this.household);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['name'] = this.name;
    map['age'] = this.age;
    map['gender'] = this.gender;
    map['household'] = this.household;
    if (this.id != null) map['id'] = this.id;

    return map;
  }

  Motho.fromObject(dynamic o) {
    this.id = o['id'];
    this.name = o['name'];
    this.age = o['age'];
    this.gender = o['gender'];
    this.household = o['household'];
  }
}

class Hobbie {
  int id;
  String title;

  Hobbie(this.title);
  Hobbie.withId(this.id, this.title);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['title'] = this.title;
    if (this.id != null) map['id'] = this.id;

    return map;
  }

  Hobbie.fromObject(dynamic o) {
    this.id = o['id'];
    this.title = o['title'];
  }
}

class HobbieYaMotho {
  int motho;
  int hobby;

  HobbieYaMotho(this.hobby, this.motho);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['motho'] = this.motho;
    map['hobby'] = this.hobby;

    return map;
  }

  HobbieYaMotho.fromObject(dynamic o) {
    this.hobby = o['hobby'];
    this.motho = o['motho'];
  }
}

class Seruiwa {
  int id;
  String name;
  String type;
  String color;
  int owner;

  Seruiwa(this.name, this.type, this.color, this.owner);
  Seruiwa.withId(this.id, this.name, this.type, this.color, this.owner);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['name'] = this.name;
    map['type'] = this.type;
    map['color'] = this.color;
    map['owner'] = this.owner;
    if (this.id != null) map['id'] = this.id;

    return map;
  }

  Seruiwa.fromObject(dynamic o) {
    this.id = o['id'];
    this.name = o['name'];
    this.type = o['type'];
    this.color = o['color'];
    this.owner = o['owner'];
  }
}
