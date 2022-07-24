

List<ExamModel> examsListFromJson(List<dynamic> json) =>
    List<ExamModel>.from(json.map((x) => ExamModel.fromJson(x)));

List<Map> examsListToJson(List<ExamModel> data) =>
    List<Map>.from(data.map((x) => x.toJson()));

class ExamModel {
  String? examName;
  List<dynamic> subjectsList;

  ExamModel({
    this.examName,
    this.subjectsList = const []
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) => ExamModel(
        examName: json["examName"],
        subjectsList: json["subjectsList"],
      );

  Map<String, dynamic> toJson() => {
        'examName': examName,
        'subjectsList': subjectsList,
      };
}
