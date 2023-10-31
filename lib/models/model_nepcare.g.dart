// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_nepcare.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailsClosed _$DetailsClosedFromJson(Map<String, dynamic> json) =>
    DetailsClosed(
      cn: json['cn'] as String?,
      cs: json['cs'] as String?,
      cp: json['cp'] as String?,
      ex: json['ex'] as String?,
      gu: json['gu'] as String?,
      oth: json['oth'] as String?,
      efr: json['efr'] as String?,
    );

Map<String, dynamic> _$DetailsClosedToJson(DetailsClosed instance) =>
    <String, dynamic>{
      'cn': instance.cn,
      'cs': instance.cs,
      'cp': instance.cp,
      'ex': instance.ex,
      'gu': instance.gu,
      'oth': instance.oth,
      'efr': instance.efr,
    };

DetailsOther _$DetailsOtherFromJson(Map<String, dynamic> json) => DetailsOther(
      wn: json['wn'] as String?,
      ws: json['ws'] as String?,
      wp: json['wp'] as String?,
      dn: json['dn'] as String?,
      ds: json['ds'] as String?,
      dp: json['dp'] as String?,
      ln: json['ln'] as String?,
      ls: json['ls'] as String?,
      lp: json['lp'] as String?,
    );

Map<String, dynamic> _$DetailsOtherToJson(DetailsOther instance) =>
    <String, dynamic>{
      'wn': instance.wn,
      'ws': instance.ws,
      'wp': instance.wp,
      'dn': instance.dn,
      'ds': instance.ds,
      'dp': instance.dp,
      'ln': instance.ln,
      'ls': instance.ls,
      'lp': instance.lp,
    };
