import 'package:json_annotation/json_annotation.dart';

part 'model_sales.g.dart';

@JsonSerializable()
class ModelSales {
  String? staff;
  String? lead;
  String? demo;
  String? imp;
  String? pend;
  String? closed;
  String? declined;
  String? follow_up;
  String? tot_days;

  ModelSales({this.staff, this.lead, this.demo, this.imp, this.pend, this.closed, this.declined,this.follow_up,this.tot_days});


  factory ModelSales.fromJson(Map<String, dynamic> json) => _$ModelSalesFromJson(json);
  Map<String, dynamic> toJson() => _$ModelSalesToJson(this);

}
