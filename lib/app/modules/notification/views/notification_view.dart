import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2334),
      appBar: AppBar(
        backgroundColor: Color(0xFF1F2334),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Notifikasi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Obx(() => controller.unreadCount > 0
              ? TextButton(
                  onPressed: controller.markAllAsRead,
                  child: Text(
                    'Tandai Semua',
                    style: TextStyle(
                      color: Color(0xFF6E40F3),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Container()),
        ],
      ),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return _buildEmptyState();
        }
        
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return _buildNotificationCard(notification);
          },
        );
      }),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            color: Colors.white54,
            size: 80,
          ),
          SizedBox(height: 16),
          Text(
            'Tidak ada notifikasi',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Semua notifikasi Anda akan muncul di sini',
            style: TextStyle(
              color: Colors.white38,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    final bool isRead = notification['isRead'];
    
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isRead ? Color(0xFF2A2E43) : Color(0xFF2A2E43).withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: isRead ? null : Border.all(
          color: Color(0xFF6E40F3).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          if (!isRead) {
            controller.markAsRead(notification['id']);
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNotificationIcon(notification['type']),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification['title'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: isRead ? FontWeight.w500 : FontWeight.bold,
                            ),
                          ),
                        ),
                        if (!isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Color(0xFF6E40F3),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      notification['message'],
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Text(
                      notification['time'],
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white54,
                  size: 20,
                ),
                color: Color(0xFF2A2E43),
                onSelected: (value) {
                  switch (value) {
                    case 'mark_read':
                      controller.markAsRead(notification['id']);
                      break;
                    case 'delete':
                      controller.deleteNotification(notification['id']);
                      break;
                  }
                },
                itemBuilder: (context) => [
                  if (!isRead)
                    PopupMenuItem(
                      value: 'mark_read',
                      child: Row(
                        children: [
                          Icon(Icons.check, color: Colors.white, size: 18),
                          SizedBox(width: 8),
                          Text('Tandai Dibaca', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, color: Colors.red, size: 18),
                        SizedBox(width: 8),
                        Text('Hapus', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(String type) {
    IconData iconData;
    Color backgroundColor;
    
    switch (type) {
      case 'event':
        iconData = Icons.event;
        backgroundColor = Color(0xFF6E40F3);
        break;
      case 'book':
        iconData = Icons.book;
        backgroundColor = Color(0xFF43A047);
        break;
      case 'reminder':
        iconData = Icons.schedule;
        backgroundColor = Color(0xFFFF7043);
        break;
      case 'achievement':
        iconData = Icons.star;
        backgroundColor = Color(0xFFFFB300);
        break;
      case 'recommendation':
        iconData = Icons.recommend;
        backgroundColor = Color(0xFF1E88E5);
        break;
      default:
        iconData = Icons.notifications;
        backgroundColor = Color(0xFF6E40F3);
    }
    
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        iconData,
        color: backgroundColor,
        size: 20,
      ),
    );
  }
}