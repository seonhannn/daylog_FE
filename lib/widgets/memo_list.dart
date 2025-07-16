import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/date_provider.dart';
import '../providers/memo_provider.dart';
import '../models/memo.dart';
import 'memo_bubble.dart';

class MemoList extends ConsumerWidget {
  final ScrollController? scrollController;
  final double topPadding;
  const MemoList({super.key, this.scrollController, this.topPadding = 0});

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

    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.only(bottom: 80, top: topPadding + 12, left: 0, right: 0),
      itemCount: filtered.isEmpty ? 1 : filtered.length,
      itemBuilder: (context, idx) {
        if (filtered.isEmpty) {
          return Container(
            alignment: Alignment.center,
            height: 120,
            child: const Text(
              '메모가 없습니다.',
              style: TextStyle(
                color: CupertinoColors.systemGrey,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }
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
