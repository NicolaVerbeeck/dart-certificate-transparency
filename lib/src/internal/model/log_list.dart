import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'log_list.g.dart';

@JsonSerializable()
@immutable
class LogListV2 {
  @JsonKey(name: 'version')
  final String? version;
  @JsonKey(name: 'operators')
  final List<LogListOperator> operators;

  const LogListV2({
    required this.operators,
    this.version,
  });

  factory LogListV2.fromJson(Map<String, dynamic> json) =>
      _$LogListV2FromJson(json);

  Map<String, dynamic> toJson() => _$LogListV2ToJson(this);
}

@JsonSerializable()
@immutable
class LogListOperator {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'email')
  final List<String> email;
  @JsonKey(name: 'logs')
  final List<LogListLog> logs;

  const LogListOperator({
    required this.name,
    required this.email,
    required this.logs,
  });

  factory LogListOperator.fromJson(Map<String, dynamic> json) =>
      _$LogListOperatorFromJson(json);

  Map<String, dynamic> toJson() => _$LogListOperatorToJson(this);
}

@JsonSerializable()
@immutable
class LogListLog {
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'key')
  final String key;
  @JsonKey(name: 'log_id')
  final String logId;
  @JsonKey(name: 'mmd')
  final int maximumMergeDelay;
  @JsonKey(name: 'url')
  final String url;
  @JsonKey(name: 'dns')
  final LogListHostname? dns;
  @JsonKey(name: 'temporal_interval')
  final LogListTemporalInterval? temporalInterval;
  @JsonKey(name: 'log_type')
  final LogListLogType? logType;
  @JsonKey(name: 'state')
  final LogListState? state;

  const LogListLog({
    required this.key,
    required this.logId,
    required this.maximumMergeDelay,
    required this.url,
    this.description,
    this.dns,
    this.temporalInterval,
    this.logType,
    this.state,
  });

  factory LogListLog.fromJson(Map<String, dynamic> json) =>
      _$LogListLogFromJson(json);

  Map<String, dynamic> toJson() => _$LogListLogToJson(this);
}

@JsonSerializable()
@immutable
class LogListHostname {
  @JsonKey(name: 'value')
  final String value;

  const LogListHostname({
    required this.value,
  });

  factory LogListHostname.fromJson(Map<String, dynamic> json) =>
      _$LogListHostnameFromJson(json);

  Map<String, dynamic> toJson() => _$LogListHostnameToJson(this);
}

@JsonSerializable()
@immutable
@_RFC3339DateTimeSerializer()
class LogListTemporalInterval {
  @JsonKey(name: 'start_inclusive')
  final DateTime startInclusive;
  @JsonKey(name: 'end_exclusive')
  final DateTime endExclusive;

  const LogListTemporalInterval({
    required this.startInclusive,
    required this.endExclusive,
  });

  factory LogListTemporalInterval.fromJson(Map<String, dynamic> json) =>
      _$LogListTemporalIntervalFromJson(json);

  Map<String, dynamic> toJson() => _$LogListTemporalIntervalToJson(this);
}

@JsonSerializable()
@immutable
class LogListState {
  @JsonKey(name: 'pending')
  final LogListStateItem? pending;
  @JsonKey(name: 'qualified')
  final LogListStateItem? qualified;
  @JsonKey(name: 'usable')
  final LogListStateItem? usable;
  @JsonKey(name: 'readonly')
  final LogListStateItem? readonly;
  @JsonKey(name: 'retired')
  final LogListStateItem? retired;
  @JsonKey(name: 'rejected')
  final LogListStateItem? rejected;

  const LogListState({
    this.pending,
    this.qualified,
    this.usable,
    this.readonly,
    this.retired,
    this.rejected,
  });

  factory LogListState.fromJson(Map<String, dynamic> json) =>
      _$LogListStateFromJson(json);
  Map<String, dynamic> toJson() => _$LogListStateToJson(this);
}

@JsonSerializable()
@_RFC3339DateTimeSerializer()
class LogListStateItem {
  @JsonKey(name: 'timestamp')
  final DateTime timestamp;

  LogListStateItem({
    required this.timestamp,
  });

  factory LogListStateItem.fromJson(Map<String, dynamic> json) =>
      _$LogListStateItemFromJson(json);
  Map<String, dynamic> toJson() => _$LogListStateItemToJson(this);
}

enum LogListLogType {
  @JsonValue('prod')
  PROD,
  @JsonValue('test')
  TEST,
}

class _RFC3339DateTimeSerializer implements JsonConverter<DateTime, String> {
  const _RFC3339DateTimeSerializer();

  @override
  DateTime fromJson(String json) {
    final fixed = json.replaceAllMapped(
      RegExp(r'(.*:\d\d)(\.\d+)?(Z|[+-]\d{2}:\d{2})'),
      (match) {
        var timeSecfrac = match[2] ?? '';
        if (timeSecfrac.length > 7) {
          timeSecfrac = timeSecfrac.substring(0, 7);
        }
        return match[1]! + timeSecfrac + match[3]!;
      },
    );

    return DateTime.parse(fixed).toUtc();
  }

  @override
  String toJson(DateTime object) {
    if (!object.isUtc) {
      throw ArgumentError.value(
          object, 'dateTime', 'Must be in utc for serialization.');
    }

    return object.toIso8601String();
  }
}
