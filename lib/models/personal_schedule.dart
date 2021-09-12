class PersonalSchedule {
  String? id;
  String? date;
  String? name;
  String? timer;
  String? note;

  PersonalSchedule(this.date, this.name, this.timer, this.note, {this.id});

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
