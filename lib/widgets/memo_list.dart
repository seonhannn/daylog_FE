import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/date_provider.dart';
import '../providers/memo_provider.dart';
import '../models/memo.dart';
import 'memo_bubble.dart';

class MemoList extends ConsumerWidget {
  const MemoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final memoList = ref.watch(memoListProvider);
    final filtered =
        memoList
            .where(
              (m) =>
                  m.memoDate.year == selectedDate.year &&
                  m.memoDate.month == selectedDate.month &&
                  m.memoDate.day == selectedDate.day,
            )
            .toList();

    if (filtered.isEmpty) {
      return const Center(child: Text('메모가 없습니다.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80, top: 8),
      itemCount: filtered.length,
      itemBuilder: (context, idx) {
        final memo = filtered[idx];
        return MemoBubble(
          memo: memo,
          onTodoCheck:
              memo.type == MemoType.todo
                  ? (checked) {
                    ref
                        .read(memoListProvider.notifier)
                        .update(
                          (state) => [
                            for (final m in state)
                              if (m.id == memo.id) m.copyWith(isDone: checked) else m,
                          ],
                        );
                  }
                  : null,
        );
      },
    );
  }
}
