import 'package:flutter/material.dart';
import '../widgets/date_selector.dart';
import '../widgets/memo_list.dart';
import '../widgets/memo_input.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 회색 그라데이션 배경
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFE3E5E8), Color(0xFFB0B3B8), Color(0xFF7A7D81)],
              ),
            ),
          ),
          // 메인 컨텐츠
          SafeArea(
            child: Column(
              children: const [
                SizedBox(height: 8),
                DateSelector(),
                Divider(height: 1),
                Expanded(child: MemoList()),
                MemoInput(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
