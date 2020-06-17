class SchoolSchedule {
  String _date;
  String _lesson;
  String _subject;
  String _address;

  SchoolSchedule(this._date, this._lesson, this._subject, this._address);

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get lesson => _lesson;

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  String get subject => _subject;

  set subject(String value) {
    _subject = value;
  }

  set lesson(String value) {
    _lesson = value;
  }

  SchoolSchedule.fromJsonApi(Map<String, dynamic> data, this._date) {
    this.subject = data['subject'];
    this.lesson = data['lesson'];
    this.address = data['address'];
  }

  SchoolSchedule.fromJsonDb(Map<String, dynamic> data) {
    this.date = data['date'];
    this.subject = data['subject_name'];
    this.lesson = data['lesson'];
    this.address = data['address'];
  }

  toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['date'] = this.date;
    data['address'] = this.address;
    data['lesson'] = this.lesson;
    data['subject'] = this.subject;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
