// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_sales.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelSales _$ModelSalesFromJson(Map<String, dynamic> json) => ModelSales(
      staff: json['staff'] as String?,
      lead: json['lead'] as String?,
      demo: json['demo'] as String?,
      imp: json['imp'] as String?,
      pend: json['pend'] as String?,
      closed: json['closed'] as String?,
      declined: json['declined'] as String?,
      follow_up: json['follow_up'] as String?,
      tot_days: json['tot_days'] as String?,
      declined_lead: json['declined_lead'] as String?,
      declined_demo: json['declined_demo'] as String?,
    );

Map<String, dynamic> _$ModelSalesToJson(ModelSales instance) =>
    <String, dynamic>{
      'staff': instance.staff,
      'lead': instance.lead,
      'demo': instance.demo,
      'imp': instance.imp,
      'pend': instance.pend,
      'closed': instance.closed,
      'declined': instance.declined,
      'follow_up': instance.follow_up,
      'tot_days': instance.tot_days,
      'declined_lead': instance.declined_lead,
      'declined_demo': instance.declined_demo,
    };
