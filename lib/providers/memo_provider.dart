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
    // 추가 mock 데이터
    Memo(
      id: '6',
      userId: 'user2',
      content: '내일 할 일 정리',
      type: MemoType.todo,
      memoDate: DateTime.now().add(Duration(days: 1)),
      createdAt: DateTime.now(),
      isDone: false,
    ),
    Memo(
      id: '7',
      userId: 'user2',
      content: '주간 회의록 작성',
      type: MemoType.memo,
      memoDate: DateTime.now().subtract(Duration(days: 1)),
      createdAt: DateTime.now(),
    ),
    Memo(
      id: '8',
      userId: 'user3',
      content: '중요: 프로젝트 마감',
      type: MemoType.todo,
      memoDate: DateTime.now().add(Duration(days: 2)),
      createdAt: DateTime.now(),
      isDone: false,
    ),
    Memo(
      id: '9',
      userId: 'user1',
      content: '점심 약속',
      type: MemoType.memo,
      memoDate: DateTime.now().add(Duration(days: 3)),
      createdAt: DateTime.now(),
    ),
    Memo(
      id: '10',
      userId: 'user2',
      content: '할 일: 서류 제출',
      type: MemoType.todo,
      memoDate: DateTime.now().subtract(Duration(days: 2)),
      createdAt: DateTime.now(),
      isDone: true,
    ),
    Memo(
      id: '11',
      userId: 'user3',
      content: '회의 준비물 챙기기',
      type: MemoType.todo,
      memoDate: DateTime.now().add(Duration(days: 4)),
      createdAt: DateTime.now(),
      isDone: false,
    ),
    Memo(
      id: '12',
      userId: 'user1',
      content: '오늘의 할 일 체크',
      type: MemoType.todo,
      memoDate: DateTime.now(),
      createdAt: DateTime.now(),
      isDone: false,
    ),
    Memo(
      id: '13',
      userId: 'user2',
      content: '중요: 회의 일정 변경',
      type: MemoType.memo,
      memoDate: DateTime.now().add(Duration(days: 5)),
      createdAt: DateTime.now(),
    ),
    Memo(
      id: '14',
      userId: 'user3',
      content: '할 일: 코드 리뷰',
      type: MemoType.todo,
      memoDate: DateTime.now().subtract(Duration(days: 3)),
      createdAt: DateTime.now(),
      isDone: false,
    ),
    Memo(
      id: '15',
      userId: 'user1',
      content: '공지: 시스템 점검 안내',
      type: MemoType.memo,
      memoDate: DateTime.now().add(Duration(days: 6)),
      createdAt: DateTime.now(),
    ),
    // 16일에만 10개 추가
    ...List.generate(10, (i) {
      final now = DateTime.now();
      final day16 = DateTime(now.year, now.month, 16);
      final isTodo = i % 2 == 1;
      return Memo(
        id: '16-${i + 1}',
        userId: 'user1',
        content: '16일 테스트 메모 ${i + 1}',
        type: isTodo ? MemoType.todo : MemoType.memo,
        memoDate: day16,
        createdAt: DateTime.now(),
        isDone: isTodo ? false : null,
      );
    }),
  ];
});
