class EmpModel {
  int empid;
  String ename;
  int age;
  String city;
  int istl;
  String tlname;
  int tlid;

  EmpModel( this.ename, this.age, this.city, this.istl, this.tlid,
      this.tlname,{this.empid});

  int get id => empid;
  String get tname => ename;
  int get agee => age;
  String get cityname => city;
  int get istlval =>istl;
  String get tlName => tlname;
  int get tlID => tlid;

  static Map<String, dynamic> toMap(EmpModel empDModel) {
    return {
      'empid': empDModel.empid,
      'ename': empDModel.ename,
      'age': empDModel.age,
      'city': empDModel.city,
      'istl': empDModel.istl,
      'tlname': empDModel.tlname,
      'tlid': empDModel.tlid
    };
  }
}
