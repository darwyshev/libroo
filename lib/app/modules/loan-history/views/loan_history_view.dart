import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/loan_history_controller.dart';

class LoanHistoryView extends GetView<LoanHistoryController> {
  const LoanHistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoanHistoryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LoanHistoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
