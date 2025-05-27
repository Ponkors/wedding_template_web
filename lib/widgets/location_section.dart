import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_constants.dart';
import 'section_title.dart';

class LocationSection extends StatefulWidget {
  const LocationSection({super.key});

  @override
  State<LocationSection> createState() => _LocationSectionState();
}

class _LocationSectionState extends State<LocationSection> {
  bool _isImageReady = false;

  @override
  void initState() {
    super.initState();
    _isImageReady = true;
  }

  Future<void> _openYandexMaps() async {
    final url = Uri.parse(AppConstants.getYandexMapsUrl());
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  String _getMapUrl() {
    final latitude = AppConstants.weddingLatitude;
    final longitude = AppConstants.weddingLongitude;
    final zoom = 10;
    return 'https://static-maps.yandex.ru/1.x/?ll=$longitude,$latitude&z=$zoom&size=650,400&l=map&pt=$longitude,$latitude,comma';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      color: Colors.white,
      child: Column(
        children: [
          const SectionTitle(
            title: AppConstants.locationTitleText,
            subtitle: 'Как нас найти',
          ),
          const SizedBox(height: 40),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height * 0.1,
            constraints: const BoxConstraints(
              minHeight: 200,
              maxHeight: 500,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  if (_isImageReady)
                    GestureDetector(
                      onTap: _openYandexMaps,
                      child: Image.network(
                        _getMapUrl(),
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              ),
            ),
          ).animate().fadeIn(duration: const Duration(milliseconds: 800)).slideY(begin: 0.2, end: 0),
          const SizedBox(height: 30),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey[200]!,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.amber[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.location_city, color: Colors.amber),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppConstants.weddingLocation,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            AppConstants.weddingAddress,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.access_time, color: Colors.blue),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Время начала',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            AppConstants.weddingDateString,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn(duration: const Duration(milliseconds: 800)).slideY(begin: 0.2, end: 0),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _openYandexMaps,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.green[100]!,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.directions_car, color: Colors.green[700]),
                  const SizedBox(width: 10),
                  Text(
                    'Нажмите, чтобы построить маршрут',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(duration: const Duration(milliseconds: 800)).slideY(begin: 0.2, end: 0),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}