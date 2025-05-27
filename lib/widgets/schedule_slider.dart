import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedding/widgets/section_title.dart';
import '../constants/app_constants.dart';

class ScheduleSlider extends StatefulWidget {
  final GlobalKey locationKey;
  
  const ScheduleSlider({
    super.key,
    required this.locationKey,
  });

  @override
  State<ScheduleSlider> createState() => _ScheduleSliderState();
}

class _ScheduleSliderState extends State<ScheduleSlider> {
  int _currentIndex = 0;
  final List<Map<String, dynamic>> _schedules = [
    {
      'time': '12:50',
      'title': 'Венчание',
      'location': AppConstants.churchName,
      'address': AppConstants.churchAddress,
      'image': AppConstants.churchImage,
      'showLocationButton': false,
      'showAttentionButton': true,
    },
    {
      'time': '14:30',
      'title': 'Фуршет',
      'location': 'Название локации',
      'address': AppConstants.weddingAddress,
      'image': 'assets/images/franopol.jpg',
      'showLocationButton': true,
      'showAttentionButton': false,
    },
    {
      'time': '15:00',
      'title': 'Регистрация',
      'location': 'Название локации',
      'address': AppConstants.weddingAddress,
      'image': 'assets/images/wedding_registration.jpg.webp',
      'showLocationButton': false,
      'showAttentionButton': false,
    },
  ];

  void _scrollToLocation() {
    final context = widget.locationKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
      decoration: const BoxDecoration(
        color: const Color(AppConstants.backgroundColorValue),
        image: DecorationImage(
          image: const AssetImage('assets/images/pattern.png'),
          repeat: ImageRepeat.repeat,
          opacity: 0.05,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SectionTitle(
              title: 'Тайминг дня',
              subtitle: 'Расписание',
            ),
            const SizedBox(height: 30),
            CarouselSlider.builder(
              itemCount: _schedules.length,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.7,
                viewportFraction: 0.8,
                enlargeCenterPage: true,
                autoPlay: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              itemBuilder: (context, index, realIndex) {
                return _buildScheduleCard(_schedules[index], isSmallScreen);
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _schedules.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(AppConstants.primaryColorValue).withOpacity(
                      _currentIndex == entry.key ? 0.9 : 0.4,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleCard(Map<String, dynamic> schedule, bool isSmallScreen) {
    final titleFontSize = isSmallScreen ? 20.0 : 24.0;
    final locationFontSize = isSmallScreen ? 16.0 : 20.0;
    final addressFontSize = isSmallScreen ? 14.0 : 16.0;
    final timeFontSize = isSmallScreen ? 36.0 : 42.0;
    final noteFontSize = isSmallScreen ? 12.0 : 14.0;
    final imageHeight = isSmallScreen ? 180.0 : 250.0;
    final padding = isSmallScreen ? 20.0 : 30.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            child: Image.asset(
              schedule['image'] as String,
              height: imageHeight,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    schedule['time'] as String,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: timeFontSize,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(93,92,88,1),
                      letterSpacing: 1,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: const Duration(milliseconds: 500))
                    .scale(begin: const Offset(0.8, 0.8)),
                  Text(
                    schedule['title'] as String,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w500,
                      color: const Color(AppConstants.textColorValue),
                    ),
                  ).animate().fadeIn(duration: const Duration(milliseconds: 500))
                    .slideY(begin: 0.3, end: 0),
                  Text(
                    schedule['location'] as String,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: locationFontSize,
                      fontWeight: FontWeight.w500,
                      color: const Color(AppConstants.textColorValue),
                    ),
                  ).animate().fadeIn(duration: const Duration(milliseconds: 500))
                    .slideY(begin: 0.3, end: 0),
                  Text(
                    schedule['address'] as String,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: addressFontSize,
                      color: const Color(AppConstants.textColorValue).withOpacity(0.8),
                    ),
                  ).animate().fadeIn(duration: const Duration(milliseconds: 500))
                    .slideY(begin: 0.3, end: 0),
                  const SizedBox(height: 25),
                  if (schedule['showLocationButton'] == true)
                    GestureDetector(
                      onTap: _scrollToLocation,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(AppConstants.backgroundColorValue),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(AppConstants.primaryColorValue).withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: const Color(AppConstants.primaryColorValue),
                              size: isSmallScreen ? 16 : 18,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Где находится?',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.playfairDisplay(
                                fontSize: noteFontSize,
                                fontWeight: FontWeight.w500,
                                color: const Color(AppConstants.textColorValue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(duration: const Duration(milliseconds: 500))
                      .slideY(begin: 0.3, end: 0)
                  else
                    if (schedule['showAttentionButton'] == true)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(AppConstants.backgroundColorValue),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(AppConstants.primaryColorValue).withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time,
                            color: const Color(AppConstants.primaryColorValue),
                            size: isSmallScreen ? 16 : 18,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Пожалуйста, приходите\nза 15-20 минут до начала',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: noteFontSize,
                              fontWeight: FontWeight.w500,
                              color: const Color(AppConstants.textColorValue),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: const Duration(milliseconds: 500))
                      .slideY(begin: 0.3, end: 0),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 800))
      .slideY(begin: 0.2, end: 0);
  }
} 