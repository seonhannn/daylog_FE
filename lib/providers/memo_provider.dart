import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/memo.dart';

final memoListProvider = StateProvider<List<Memo>>((ref) {
  // 임시 mock 데이터
  return [
    Memo(
      id: '1',
      userId: 'user1',
      content: '회의 준비하기',
      type: MemoType.todo,
      memoDate: DateTime.now(),
      createdAt: DateTime.now(),
      isDone: false,
    ),
    Memo(
      id: '2',
      userId: 'user1',
      content: '중요 공지: 내일 점검',
      type: MemoType.memo,
      memoDate: DateTime.now(),
      createdAt: DateTime.now(),
    ),
    Memo(
      id: '3',
      userId: 'user1',
      content: '오늘의 메모',
      type: MemoType.memo,
      memoDate: DateTime.now(),
      createdAt: DateTime.now(),
    ),
    Memo(
      id: '4',
      userId: 'user1',
      content: '오늘의 메모',
      type: MemoType.memo,
      memoDate: DateTime.now(),
      createdAt: DateTime.now(),
    ),
    Memo(
      id: '5',
      userId: 'user1',
      content: '오늘의 메모',
      type: MemoType.memo,
      memoDate: DateTime.now(),
      createdAt: DateTime.now(),
    ),
  ];
});
