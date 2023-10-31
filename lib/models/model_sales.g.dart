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
    };
