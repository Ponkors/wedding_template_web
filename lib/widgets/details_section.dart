import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_constants.dart';
import 'section_title.dart';
import 'section_divider.dart';

class DetailsSection extends StatelessWidget {
  const DetailsSection({super.key});


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;
    final textFontSize = isSmallScreen ? 16.0 : 20.0;
    final padding = isSmallScreen ? 20.0 : 30.0;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: padding),
      decoration: BoxDecoration(
        color: const Color(AppConstants.backgroundColorValue),
        image: const DecorationImage(
          image: AssetImage('assets/images/pattern.png'),
          repeat: ImageRepeat.repeat,
          opacity: 0.05,
        ),
      ),
      child: Column(
        children: [
          const SectionDivider(),
          const SectionTitle(
            title: 'Детали',
            subtitle: 'Важная информация',
          ),
          const SizedBox(height: 40),
          Container(
            padding: EdgeInsets.all(padding),
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
              children: [
                _buildDetailItem(
                  context,
                  'Нам будет очень приятно если вместо цветов вы возьмете что-то, что можно прочесть, что можно выпить или во что можно поиграть.',
                  Icons.card_giftcard,
                  textFontSize,
                ),
                const SizedBox(height: 30),
                _buildDetailItem(
                  context,
                  'До места проведения мероприятия будет организован трансфер.',
                  Icons.directions_bus,
                  textFontSize,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(
    BuildContext context,
    String text,
    IconData icon,
    double fontSize,
  ) {
    if (icon == Icons.card_giftcard) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: const Color(AppConstants.primaryColorValue),
                size: 24,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  'Нам будет очень приятно если вместо цветов вы возьмете:',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: fontSize,
                    color: const Color(AppConstants.textColorValue),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 39),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSubItem('📚 Что можно прочесть', fontSize),
                const SizedBox(height: 10),
                _buildSubItem('🍷 Что можно выпить', fontSize),
                const SizedBox(height: 10),
                _buildSubItem('🎮 Во что можно поиграть', fontSize),
              ],
            ),
          ),
        ],
      ).animate().fadeIn(duration: const Duration(milliseconds: 500))
        .slideX(begin: 0.2, end: 0);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: const Color(AppConstants.primaryColorValue),
          size: 24,
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.playfairDisplay(
              fontSize: fontSize,
              color: const Color(AppConstants.textColorValue),
              height: 1.5,
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: const Duration(milliseconds: 500))
      .slideX(begin: 0.2, end: 0);
  }

  Widget _buildSubItem(String text, double fontSize) {
    return Row(
      children: [
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.playfairDisplay(
            fontSize: fontSize - 2,
            color: const Color(AppConstants.textColorValue),
            height: 1.5,
          ),
        ),
      ],
    );
  }
} 