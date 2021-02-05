import 'package:flutter/material.dart';
import 'package:word_scramble_frontend/ui/history/widgets/history_list/history_list.dart';
import 'package:word_scramble_frontend/ui/history/widgets/user_detail/user_detail.dart';

class History extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserDetail(),
        Expanded(
          child: HistoryList(),
        )
      ],
    );
  }

}