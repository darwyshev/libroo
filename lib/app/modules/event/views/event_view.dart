import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/event_controller.dart';

class EventView extends GetView<EventController> {
  const EventView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EventView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EventView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
