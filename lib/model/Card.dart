class Card {
  String _id;
  String _name;
  String _number;
  String _securityCode;
  String _validThru;

  Card(
      {String id,
      String name,
      String number,
      String securityCode,
      String validThru}) {
    this._id = id;
    this._name = name;
    this._number = number;
    this._securityCode = securityCode;
    this._validThru = validThru;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get number => _number;
  set number(String number) => _number = number;
  String get securityCode => _securityCode;
  set securityCode(String securityCode) => _securityCode = securityCode;
  String get validThru => _validThru;
  set validThru(String validThru) => _validThru = validThru;

  Card.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _number = json['number'];
    _securityCode = json['securityCode'];
    _validThru = json['validThru'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['number'] = this._number;
    data['securityCode'] = this._securityCode;
    data['validThru'] = this._validThru;
    return data;
  }
}
