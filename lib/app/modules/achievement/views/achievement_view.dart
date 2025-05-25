import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/achievement_controller.dart';

class AchievementView extends GetView<AchievementController> {
  const AchievementView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2334),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF6E40F3),
                    ),
                  );
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStatsHeader(),
                        SizedBox(height: 24),
                        _buildCategoryFilter(),
                        SizedBox(height: 24),
                        _buildAchievementsList(),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Top Bar
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF2A2E43),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Color(0xFFF7F7F7),
              ),
              onPressed: () => Get.back(),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'Prestasi',
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
                Icons.refresh_rounded,
                color: Color(0xFF6E40F3),
              ),
              onPressed: controller.refreshAchievements,
            ),
          ),
        ],
      ),
    );
  }

  // Stats Header
  Widget _buildStatsHeader() {
    return Obx(() => Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6E40F3), Color(0xFF8A62FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            top: -30,
            child: Icon(
              Icons.emoji_events_rounded,
              size: 120,
              color: Color(0xFFF7F7F7).withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.emoji_events_rounded,
                      color: Color(0xFFF7F7F7),
                      size: 32,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Total Prestasi',
                      style: TextStyle(
                        color: Color(0xFFF7F7F7),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${controller.getUnlockedCount()}/${controller.achievements.length}',
                            style: TextStyle(
                              color: Color(0xFFF7F7F7),
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Achievement Terbuka',
                            style: TextStyle(
                              color: Color(0xFFF7F7F7).withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 1,
                      color: Color(0xFFF7F7F7).withOpacity(0.3),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${controller.getTotalPoints()}',
                            style: TextStyle(
                              color: Color(0xFFF7F7F7),
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Total Poin',
                            style: TextStyle(
                              color: Color(0xFFF7F7F7).withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  // Category Filter
  Widget _buildCategoryFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kategori',
          style: TextStyle(
            color: Color(0xFFF7F7F7),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Obx(() => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: controller.categories.map((category) {
              final isSelected = controller.selectedCategory.value == category;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () => controller.changeCategory(category),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFF6E40F3) : Color(0xFF2A2E43),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Color(0xFF6E40F3) : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: Color(0xFFF7F7F7),
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )),
      ],
    );
  }

  // Achievements List
  Widget _buildAchievementsList() {
    return Obx(() {
      final filteredAchievements = controller.getFilteredAchievements();
      
      if (filteredAchievements.isEmpty) {
        return Center(
          child: Column(
            children: [
              SizedBox(height: 40),
              Icon(
                Icons.emoji_events_outlined,
                size: 80,
                color: Color(0xFFF7F7F7).withOpacity(0.3),
              ),
              SizedBox(height: 16),
              Text(
                'Belum ada prestasi di kategori ini',
                style: TextStyle(
                  color: Color(0xFFF7F7F7).withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daftar Prestasi',
            style: TextStyle(
              color: Color(0xFFF7F7F7),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredAchievements.length,
            separatorBuilder: (context, index) => SizedBox(height: 12),
            itemBuilder: (context, index) {
              final achievement = filteredAchievements[index];
              return _buildAchievementCard(achievement);
            },
          ),
        ],
      );
    });
  }

  // Achievement Card
  Widget _buildAchievementCard(Map<String, dynamic> achievement) {
    final isUnlocked = achievement['isUnlocked'];
    final progress = controller.getProgressPercentage(achievement);
    
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF2A2E43),
        borderRadius: BorderRadius.circular(16),
        border: isUnlocked ? Border.all(
          color: achievement['color'].withOpacity(0.5),
          width: 1,
        ) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                // Achievement Icon
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isUnlocked 
                        ? achievement['color'].withOpacity(0.2)
                        : Color(0xFFF7F7F7).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    achievement['icon'],
                    color: isUnlocked 
                        ? achievement['color']
                        : Color(0xFFF7F7F7).withOpacity(0.5),
                    size: 24,
                  ),
                ),
                SizedBox(width: 16),
                // Achievement Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              achievement['title'],
                              style: TextStyle(
                                color: isUnlocked 
                                    ? Color(0xFFF7F7F7) 
                                    : Color(0xFFF7F7F7).withOpacity(0.7),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (isUnlocked)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: achievement['color'].withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '+${achievement['points']} pts',
                                style: TextStyle(
                                  color: achievement['color'],
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        achievement['description'],
                        style: TextStyle(
                          color: Color(0xFFF7F7F7).withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                      if (isUnlocked && achievement['unlockedDate'] != null) ...[
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              color: achievement['color'],
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Dibuka pada ${achievement['unlockedDate']}',
                              style: TextStyle(
                                color: achievement['color'],
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            // Progress Bar for locked achievements
            if (!isUnlocked) ...[
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: TextStyle(
                          color: Color(0xFFF7F7F7).withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '${achievement['progress']}/${achievement['target']}',
                        style: TextStyle(
                          color: Color(0xFFF7F7F7).withOpacity(0.7),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Color(0xFFF7F7F7).withOpacity(0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        achievement['color'].withOpacity(0.8),
                      ),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}