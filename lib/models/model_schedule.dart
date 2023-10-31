import 'package:json_annotation/json_annotation.dart';

part 'model_schedule.g.dart';

@JsonSerializable()
class ModelSchedule {
  String? tkt;
  String? dat;
  String? nepid;
  String? cus;
  String? desp;
  String? pccnt;
  String? mob;
  String? recno;
  String? st;
  String? staff;
  String? updatedtym;
  String? remark;



  ModelSchedule({this.tkt, this.dat, this.nepid, this.cus, this.desp, this.pccnt, this.mob, this.recno, this.st, this.staff, this.updatedtym, this.remark});

  factory ModelSchedule.fromJson(Map<String, dynamic> json) => _$ModelScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ModelScheduleToJson(this);
}
