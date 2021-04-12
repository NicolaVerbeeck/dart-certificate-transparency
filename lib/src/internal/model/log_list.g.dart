// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogListV2 _$LogListV2FromJson(Map<String, dynamic> json) {
  return LogListV2(
    operators: (json['operators'] as List<dynamic>)
        .map((e) => LogListOperator.fromJson(e as Map<String, dynamic>))
        .toList(),
    version: json['version'] as String?,
  );
}

Map<String, dynamic> _$LogListV2ToJson(LogListV2 instance) => <String, dynamic>{
      'version': instance.version,
      'operators': instance.operators,
    };

LogListOperator _$LogListOperatorFromJson(Map<String, dynamic> json) {
  return LogListOperator(
    name: json['name'] as String,
    email: (json['email'] as List<dynamic>).map((e) => e as String).toList(),
    logs: (json['logs'] as List<dynamic>)
        .map((e) => LogListLog.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$LogListOperatorToJson(LogListOperator instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'logs': instance.logs,
    };

LogListLog _$LogListLogFromJson(Map<String, dynamic> json) {
  return LogListLog(
    description: json['description'] as String?,
    key: json['key'] as String,
    logId: json['log_id'] as String,
    maximumMergeDelay: json['mmd'] as int,
    url: json['url'] as String,
    dns: json['dns'] == null
        ? null
        : LogListHostname.fromJson(json['dns'] as Map<String, dynamic>),
    temporalInterval: json['temporal_interval'] == null
        ? null
        : LogListTemporalInterval.fromJson(
            json['temporal_interval'] as Map<String, dynamic>),
    logType: _$enumDecodeNullable(_$LogListLogTypeEnumMap, json['log_type']),
    state: json['state'] == null
        ? null
        : LogListState.fromJson(json['state'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LogListLogToJson(LogListLog instance) =>
    <String, dynamic>{
      'description': instance.description,
      'key': instance.key,
      'log_id': instance.logId,
      'mmd': instance.maximumMergeDelay,
      'url': instance.url,
      'dns': instance.dns,
      'temporal_interval': instance.temporalInterval,
      'log_type': _$LogListLogTypeEnumMap[instance.logType],
      'state': instance.state,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$LogListLogTypeEnumMap = {
  LogListLogType.PROD: 'prod',
  LogListLogType.TEST: 'test',
};

LogListHostname _$LogListHostnameFromJson(Map<String, dynamic> json) {
  return LogListHostname(
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$LogListHostnameToJson(LogListHostname instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

LogListTemporalInterval _$LogListTemporalIntervalFromJson(
    Map<String, dynamic> json) {
  return LogListTemporalInterval(
    startInclusive: const _RFC3339DateTimeSerializer()
        .fromJson(json['start_inclusive'] as String),
    endExclusive: const _RFC3339DateTimeSerializer()
        .fromJson(json['end_exclusive'] as String),
  );
}

Map<String, dynamic> _$LogListTemporalIntervalToJson(
        LogListTemporalInterval instance) =>
    <String, dynamic>{
      'start_inclusive':
          const _RFC3339DateTimeSerializer().toJson(instance.startInclusive),
      'end_exclusive':
          const _RFC3339DateTimeSerializer().toJson(instance.endExclusive),
    };

LogListState _$LogListStateFromJson(Map<String, dynamic> json) {
  return LogListState(
    pending: json['pending'] == null
        ? null
        : LogListStateItem.fromJson(json['pending'] as Map<String, dynamic>),
    qualified: json['qualified'] == null
        ? null
        : LogListStateItem.fromJson(json['qualified'] as Map<String, dynamic>),
    usable: json['usable'] == null
        ? null
        : LogListStateItem.fromJson(json['usable'] as Map<String, dynamic>),
    readonly: json['readonly'] == null
        ? null
        : LogListStateItem.fromJson(json['readonly'] as Map<String, dynamic>),
    retired: json['retired'] == null
        ? null
        : LogListStateItem.fromJson(json['retired'] as Map<String, dynamic>),
    rejected: json['rejected'] == null
        ? null
        : LogListStateItem.fromJson(json['rejected'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LogListStateToJson(LogListState instance) =>
    <String, dynamic>{
      'pending': instance.pending,
      'qualified': instance.qualified,
      'usable': instance.usable,
      'readonly': instance.readonly,
      'retired': instance.retired,
      'rejected': instance.rejected,
    };

LogListStateItem _$LogListStateItemFromJson(Map<String, dynamic> json) {
  return LogListStateItem(
    timestamp: const _RFC3339DateTimeSerializer()
        .fromJson(json['timestamp'] as String),
  );
}

Map<String, dynamic> _$LogListStateItemToJson(LogListStateItem instance) =>
    <String, dynamic>{
      'timestamp':
          const _RFC3339DateTimeSerializer().toJson(instance.timestamp),
    };
