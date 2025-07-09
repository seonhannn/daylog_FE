// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemoImpl _$$MemoImplFromJson(Map<String, dynamic> json) => _$MemoImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  content: json['content'] as String,
  type: $enumDecode(_$MemoTypeEnumMap, json['type']),
  memoDate: DateTime.parse(json['memoDate'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  imageUrl: json['imageUrl'] as String?,
  isDone: json['isDone'] as bool?,
);

Map<String, dynamic> _$$MemoImplToJson(_$MemoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'content': instance.content,
      'type': _$MemoTypeEnumMap[instance.type]!,
      'memoDate': instance.memoDate.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'isDone': instance.isDone,
    };

const _$MemoTypeEnumMap = {
  MemoType.memo: 'memo',
  MemoType.notice: 'notice',
  MemoType.todo: 'todo',
};
