import 'package:get/get.dart';

import '../controllers/loan_history_controller.dart';

class LoanHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoanHistoryController>(
      () => LoanHistoryController(),
    );
  }
}
