import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/help_controller.dart';

class HelpView extends GetView<HelpController> {
  const HelpView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2334),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopBar(),
                SizedBox(height: 24),
                _buildSearchBar(),
                SizedBox(height: 24),
                _buildQuickActions(),
                SizedBox(height: 24),
                _buildFAQSection(),
                SizedBox(height: 24),
                _buildContactSection(),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TOP BAR
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF6E40F3).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xFFF7F7F7),
                size: 20,
              ),
              onPressed: () => Get.back(),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'Bantuan & Dukungan',
              style: TextStyle(
                color: Color(0xFFF7F7F7), 
                fontSize: 24, 
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF6E40F3).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.feedback_outlined,
                color: Color(0xFFF7F7F7),
                size: 22,
              ),
              onPressed: controller.showFeedbackDialog,
            ),
          ),
        ],
      ),
    );
  }

  // SEARCH BAR UNTUK FAQ
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF2A2E43),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller.searchController,
        onChanged: controller.searchFAQ,
        style: TextStyle(color: Color(0xFFF7F7F7)),
        decoration: InputDecoration(
          hintText: 'Cari pertanyaan atau topik...',
          hintStyle: TextStyle(color: Color(0xFFF7F7F7).withOpacity(0.5)),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Color(0xFF6E40F3),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  // AKSI CEPAT
  Widget _buildQuickActions() {
    final quickActions = [
      {
        'title': 'Cara Pinjam',
        'icon': Icons.book_outlined,
        'color': Color(0xFF43A047),
        'onTap': () => controller.toggleFAQ(0),
      },
      {
        'title': 'Reset Password',
        'icon': Icons.lock_reset_outlined,
        'color': Color(0xFFE53935),
        'onTap': () => controller.toggleFAQ(6),
      },
      {
        'title': 'Live Chat',
        'icon': Icons.chat_bubble_outline_rounded,
        'color': Color(0xFF6E40F3),
        'onTap': () => controller.handleContactAction('livechat', ''),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Paling Umum',
          style: TextStyle(
            color: Color(0xFFF7F7F7),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: quickActions.map((action) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: action == quickActions.last ? 0 : 12,
                ),
                child: GestureDetector(
                  onTap: action['onTap'] as VoidCallback,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFF2A2E43),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: (action['color'] as Color).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: (action['color'] as Color).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            action['icon'] as IconData,
                            color: action['color'] as Color,
                            size: 24,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          action['title'] as String,
                          style: TextStyle(
                            color: Color(0xFFF7F7F7),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // SESI FAQ DENGAN PERTANYAAN UMUM
  Widget _buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Pertanyaan yang Sering Diajukan',
              style: TextStyle(
                color: Color(0xFFF7F7F7),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFF6E40F3).withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Obx(() {
                return Text(
                  '${controller.filteredFAQ.length} FAQ',
                  style: TextStyle(
                    color: Color(0xFF6E40F3),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }),
            ),
          ],
        ),
        SizedBox(height: 16),
        Obx(() {
          return Container(
            decoration: BoxDecoration(
              color: Color(0xFF2A2E43),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.filteredFAQ.length,
              separatorBuilder: (context, index) => Divider(
                color: Color(0xFFF7F7F7).withOpacity(0.1),
                height: 1,
              ),
              itemBuilder: (context, index) {
                final faq = controller.filteredFAQ[index];
                final originalIndex = controller.faqList.indexOf(faq);
                final isExpanded = controller.expandedFAQIndex.value == originalIndex;
                
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  child: ExpansionTile(
                    key: Key('faq_$originalIndex'),
                    tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    childrenPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    title: Text(
                      faq['question']!,
                      style: TextStyle(
                        color: Color(0xFFF7F7F7),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Icon(
                      isExpanded ? Icons.remove_rounded : Icons.add_rounded,
                      color: Color(0xFF6E40F3),
                    ),
                    iconColor: Color(0xFF6E40F3),
                    collapsedIconColor: Color(0xFF6E40F3),
                    onExpansionChanged: (expanded) {
                      if (expanded) {
                        controller.toggleFAQ(originalIndex);
                      } else {
                        controller.expandedFAQIndex.value = -1;
                      }
                    },
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFF1F2334),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          faq['answer']!,
                          style: TextStyle(
                            color: Color(0xFFF7F7F7).withOpacity(0.8),
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }

  // SESI KONTAK
  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hubungi Kami',
          style: TextStyle(
            color: Color(0xFFF7F7F7),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Masih butuh bantuan? Tim support kami siap membantu',
          style: TextStyle(
            color: Color(0xFFF7F7F7).withOpacity(0.7),
            fontSize: 14,
          ),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF2A2E43),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.contactOptions.length,
            separatorBuilder: (context, index) => Divider(
              color: Color(0xFFF7F7F7).withOpacity(0.1),
              height: 1,
            ),
            itemBuilder: (context, index) {
              final contact = controller.contactOptions[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF6E40F3).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    contact['icon'],
                    color: Color(0xFF6E40F3),
                    size: 24,
                  ),
                ),
                title: Text(
                  contact['title'],
                  style: TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  contact['subtitle'],
                  style: TextStyle(
                    color: Color(0xFFF7F7F7).withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                trailing: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFF6E40F3).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    contact['action'] == 'livechat' 
                        ? Icons.arrow_forward_rounded 
                        : Icons.copy_rounded,
                    color: Color(0xFF6E40F3),
                    size: 16,
                  ),
                ),
                onTap: () => controller.handleContactAction(
                  contact['action'], 
                  contact['subtitle'],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20),
        
        // JAM OPERASIONAL
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6E40F3), Color(0xFF8A62FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    color: Color(0xFFF7F7F7),
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Jam Operasional Perpustakaan',
                    style: TextStyle(
                      color: Color(0xFFF7F7F7),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                'Senin - Jumat: 07:00 - 17:00 WIB\nSabtu - Minggu: 09:00 - 12:00 WIB',
                style: TextStyle(
                  color: Color(0xFFF7F7F7).withOpacity(0.9),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Live chat tersedia 24/7 untuk pertanyaan mendesak',
                style: TextStyle(
                  color: Color(0xFFF7F7F7).withOpacity(0.8),
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}