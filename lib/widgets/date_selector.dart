import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/date_provider.dart';
import '../providers/memo_provider.dart';
import '../models/memo.dart';

class DateSelector extends ConsumerWidget {
  const DateSelector({super.key});

  List<DateTime> getThisWeekDates(DateTime today) {
    final startOfWeek = today.subtract(Duration(days: today.weekday % 7));
    return List.generate(7, (i) => startOfWeek.add(Duration(days: i)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final memoList = ref.watch(memoListProvider);
    final weekDates = getThisWeekDates(selectedDate);

    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            weekDates.map((date) {
              final todos =
                  memoList
                      .where(
                        (m) =>
                            m.type == MemoType.todo &&
                            m.memoDate.year == date.year &&
                            m.memoDate.month == date.month &&
                            m.memoDate.day == date.day &&
                            (m.isDone != true),
                      )
                      .toList();
              final isSelected =
                  date.year == selectedDate.year &&
                  date.month == selectedDate.month &&
                  date.day == selectedDate.day;
              return GestureDetector(
                onTap: () => ref.read(selectedDateProvider.notifier).state = date,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (todos.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Color(0xFF4A90E2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${todos.length}',
                          style: const TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${date.day}',
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(_weekdayKor(date.weekday), style: const TextStyle(fontSize: 12)),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }
}

String _weekdayKor(int weekday) {
  const days = ['일', '월', '화', '수', '목', '금', '토'];
  return days[(weekday - 1) % 7];
}
