/*
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
import 'package:json_annotation/json_annotation.dart';

part 'model_nepcare.g.dart';

@JsonSerializable()
class DetailsClosed {
  String? cn;
  String? cs;
  String? cp;
  String? ex;
  String? gu;
  String? oth;
  String? efr;

  DetailsClosed({this.cn, this.cs, this.cp,this.ex,this.gu,this.oth,this.efr});

  factory DetailsClosed.fromJson(Map<String, dynamic> json) => _$DetailsClosedFromJson(json);
  Map<String, dynamic> toJson() => _$DetailsClosedToJson(this);


}

@JsonSerializable()
class DetailsOther {
  String? wn;
  String? ws;
  String? wp;
  String? dn;
  String? ds;
  String? dp;
  String? ln;
  String? ls;
  String? lp;


  DetailsOther({this.wn, this.ws, this.wp, this.dn, this.ds, this.dp, this.ln, this.ls, this.lp});

  factory DetailsOther.fromJson(Map<String, dynamic> json) => _$DetailsOtherFromJson(json);
  Map<String, dynamic> toJson() => _$DetailsOtherToJson(this);

}

// @JsonSerializable()
// class  ModelNepcare {
//   List<DetailsClosed?>? detailsclosed;
//   List<DetailsOther?>? detailsothers;
//   int? result;
//
//   ModelNepcare({this.detailsclosed, this.detailsothers, this.result});
//
//
//
//   factory ModelNepcare.fromJson(Map<String, dynamic> json) => _$ModelNepcareFromJson(json);
//   Map<String, dynamic> toJson() => _$ModelNepcareToJson(this);
//
//
//
//
// }

