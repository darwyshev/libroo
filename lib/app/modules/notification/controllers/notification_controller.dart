import 'package:get/get.dart';

class NotificationController extends GetxController {
  final notifications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadNotifications();
  }

  void _loadNotifications() {
    // DATA DUMMY NOTIFIKASI
    notifications.value = [
      {
        'id': 1,
        'title': 'Lomba Membaca Cepat',
        'message': 'Jangan lewatkan kesempatan untuk mengikuti lomba membaca cepat dan dapatkan hadiah menarik!',
        'time': '2 jam yang lalu',
        'isRead': false,
        'type': 'event',
        'icon': 'trophy',
      },
      {
        'id': 2,
        'title': 'Buku Baru Tersedia',
        'message': 'Koleksi buku terbaru dari Tere Liye telah tersedia di perpustakaan digital.',
        'time': '5 jam yang lalu',
        'isRead': false,
        'type': 'book',
        'icon': 'book',
      },
      {
        'id': 3,
        'title': 'Reminder Pengembalian',
        'message': 'Buku "Janji" akan jatuh tempo dalam 2 hari. Jangan lupa untuk mengembalikan atau perpanjang.',
        'time': '1 hari yang lalu',
        'isRead': true,
        'type': 'reminder',
        'icon': 'schedule',
      },
      {
        'id': 4,
        'title': 'Pencapaian Baru',
        'message': 'Selamat! Anda telah menyelesaikan 10 buku bulan ini. Lanjutkan semangat membacanya!',
        'time': '2 hari yang lalu',
        'isRead': true,
        'type': 'achievement',
        'icon': 'star',
      },
      {
        'id': 5,
        'title': 'Rekomendasi Mingguan',
        'message': 'Berdasarkan riwayat bacaan Anda, kami merekomendasikan "Laut Bercerita" untuk dibaca minggu ini.',
        'time': '3 hari yang lalu',
        'isRead': true,
        'type': 'recommendation',
        'icon': 'recommend',
      },
    ];
  }

  void markAsRead(int notificationId) {
    final index = notifications.indexWhere((n) => n['id'] == notificationId);
    if (index != -1) {
      notifications[index]['isRead'] = true;
      notifications.refresh();
    }
  }

  void markAllAsRead() {
    for (var notification in notifications) {
      notification['isRead'] = true;
    }
    notifications.refresh();
  }

  void deleteNotification(int notificationId) {
    notifications.removeWhere((n) => n['id'] == notificationId);
  }

  int get unreadCount => notifications.where((n) => !n['isRead']).length;
}