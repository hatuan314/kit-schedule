class PersonalSchedule {
  String id;
  String _date;
  String _name;
  String _timer;
  String _note;

  PersonalSchedule(this._date, this._name, this._timer, this._note, {this.id});

  String get note => _note;

  set note(String value) {
    _note = value;
  }

  String get timer => _timer;

  set timer(String value) {
    _timer = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  PersonalSchedule.fromJson(Map<String, dynamic> data) {
    this.id = data['id'].toString();
    this.date = data['date'];
    this.note = data['note'];
    this.name = data['schedule_name'];
    this.timer = data['timer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['note'] = this.note;
    data['date'] = this.date;
    data['schedule_name'] = this.name;
    data['timer'] = this.timer;
    return data;
  }
}
