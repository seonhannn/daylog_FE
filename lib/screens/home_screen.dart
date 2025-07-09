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
          Container(decoration: const BoxDecoration(color: Color(0xFFE3E5E8))),
          // 메인 컨텐츠
          SafeArea(
            child: Column(
              children: const [
                SizedBox(height: 8),
                DateSelector(),
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
