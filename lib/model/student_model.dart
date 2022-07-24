

List<StudentModel> studentsListFromJson(List<dynamic> json) =>
    List<StudentModel>.from(json.map((x) => StudentModel.fromJson(x)));

List<Map> studentsListToJson(List<StudentModel> data) =>
    List<Map>.from(data.map((x) => x.toJson()));

class StudentModel {
  String? batch;
  String? course;
  String? department;
  String? dob;
  String? email;
  String? name;
  String? parent;
  String? parentPhone;
  String? parentRelation;
  String? phone;
  String? rating;
  String? status;
  String? year;
  String? image;
  Perfomance? perfomance;

  StudentModel({
    this.batch,
    this.course,
    this.department,
    this.dob,
    this.email,
    this.name,
    this.parent,
    this.parentPhone,
    this.parentRelation,
    this.phone,
    this.rating,
    this.status,
    this.year,
    this.image,
    this.perfomance,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        batch: json["batch"],
        course: json["course"],
        department: json["department"],
        dob: json["dob"],
        email: json['email'],
        name: json["name"],
        parent: json["parent"],
        parentPhone: json["parentPhone"],
        parentRelation: json["parentRelation"],
        phone: json["phone"],
        rating: json["rating"],
        status: json['status'],
        year: json["year"],
        image: json["image"],
        perfomance: Perfomance.fromJson(json["perfomance"]),
      );

  Map<String, dynamic> toJson() => {
        'batch': batch,
        'course': course,
        'department': department,
        'dob': dob,
        'email': email,
        'name': name,
        'parent': parent,
        'parentPhone': parentPhone,
        'parentRelation': parentRelation,
        'phone': phone,
        'rating': rating,
        'status': status,
        'year': year,
        'image':image,
        'perfomance': perfomance?.toJson(),
      };
}

class Perfomance {
  Perfomance({this.fifth, this.fourth, this.third, this.second, this.last});

  int? fifth;
  int? fourth;
  int? third;
  int? second;
  int? last;

  factory Perfomance.fromJson(Map<String, dynamic> json) => Perfomance(
        fifth: json['fifth'],
        fourth: json['fourth'],
        third: json['third'],
        second: json['second'],
        last: json['last'],
      );

  Map<String, dynamic> toJson() => {
        'fifth': fifth,
        'fourth': fourth,
        'third': third,
        'second': second,
        'last': last,
      };
}
