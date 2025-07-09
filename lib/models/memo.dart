import 'package:freezed_annotation/freezed_annotation.dart';

part 'memo.freezed.dart';
part 'memo.g.dart';

@freezed
class Memo with _$Memo {
  const factory Memo({
    required String id,
    required String userId,
    required String content,
    required MemoType type,
    required DateTime memoDate,
    required DateTime createdAt,
    String? imageUrl,
    bool? isDone,
  }) = _Memo;

  factory Memo.fromJson(Map<String, dynamic> json) => _$MemoFromJson(json);
}

enum MemoType { memo, notice, todo }
