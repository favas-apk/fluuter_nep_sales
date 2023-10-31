// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelSchedule _$ModelScheduleFromJson(Map<String, dynamic> json) =>
    ModelSchedule(
      tkt: json['tkt'] as String?,
      dat: json['dat'] as String?,
      nepid: json['nepid'] as String?,
      cus: json['cus'] as String?,
      desp: json['desp'] as String?,
      pccnt: json['pccnt'] as String?,
      mob: json['mob'] as String?,
      recno: json['recno'] as String?,
      st: json['st'] as String?,
      staff: json['staff'] as String?,
      updatedtym: json['updatedtym'] as String?,
      remark: json['remark'] as String?,
    );

Map<String, dynamic> _$ModelScheduleToJson(ModelSchedule instance) =>
    <String, dynamic>{
      'tkt': instance.tkt,
      'dat': instance.dat,
      'nepid': instance.nepid,
      'cus': instance.cus,
      'desp': instance.desp,
      'pccnt': instance.pccnt,
      'mob': instance.mob,
      'recno': instance.recno,
      'st': instance.st,
      'staff': instance.staff,
      'updatedtym': instance.updatedtym,
      'remark': instance.remark,
    };
