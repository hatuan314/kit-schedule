// class SchoolSchedule {
//   String? date;
//   String? lesson;
//   String? subject;
//   String? address;
//
//   SchoolSchedule(this.date, this.lesson, this.subject, this.address);
//
//
//   SchoolSchedule.fromJsonApi(Map<String, dynamic> data, this.date) {
//     this.subject = data['subject'];
//     this.lesson = data['lesson'];
//     this.address = data['address'];
//   }
//
//   SchoolSchedule.fromJsonDb(Map<String, dynamic> data) {
//     this.date = data['date'];
//     this.subject = data['subject_name'];
//     this.lesson = data['lesson'];
//     this.address = data['address'];
//   }
//
//   toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['date'] = this.date;
//     data['address'] = this.address;
//     data['lesson'] = this.lesson;
//     data['subject'] = this.subject;
//     return data;
//   }
//
//   @override
//   String toString() {
//     // TODO: implement toString
//     return super.toString();
//   }
// }
