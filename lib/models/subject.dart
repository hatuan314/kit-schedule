class Subject {
  int? id;
  String? name;
  int? credits;

  Subject(this.id, this.name, this.credits);

  Subject.fromJson(Map<String, dynamic> data) {
    this.id = data['id'];
    this.name = data['name'];
    this.credits = data['credits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['credits'] = this.credits;
    return data;
  }
}
