import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/foundation.dart' show kIsWeb;
import '../constants/app_constants.dart';
import 'section_title.dart';

class RSVPSection extends StatefulWidget {
  const RSVPSection({super.key});

  @override
  State<RSVPSection> createState() => _RSVPSectionState();
}

class _RSVPSectionState extends State<RSVPSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _guestsController = TextEditingController();
  bool _isAttending = true;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _guestsController.dispose();
    super.dispose();
  }

  void submitViaForm(Map<String, String> fields) {
    final uri = Uri.parse(
      'https://script.google.com/macros/s/AKfycbzwV_OXzU010n0a541SfEGNYyjMkOYUYSE3DIb3a1sg8V_S_MAbgd-lzXsoYjyUyZB-yg/exec',
    );

    final encodedData = fields.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');

    html.HttpRequest.request(
      uri.toString(),
      method: 'POST',
      sendData: encodedData,
      requestHeaders: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    ).then((response) {
      print('Форма успешно отправлена: ${response.responseText}');
    }).catchError((error) {
      print('Ошибка при отправке формы: $error');
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      try {
        submitViaForm({
          'name': _nameController.text,
          'phone': _phoneNumberController.text,
          'guests': _guestsController.text,
          'isAttending': _isAttending.toString(),
        });

        // Ждём пару секунд для имитации отправки
        await Future.delayed(const Duration(seconds: 2));

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Спасибо за ответ! Мы свяжемся с вами в ближайшее время.'),
              backgroundColor: Color(AppConstants.primaryColorValue),
            ),
          );
          _formKey.currentState!.reset();
          setState(() {
            _isAttending = true;
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Произошла ошибка при отправке формы. Пожалуйста, попробуйте позже.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
      color: const Color(AppConstants.backgroundColorValue),
      child: Column(
        children: [
          const SectionTitle(
            title: 'RSVP',
            subtitle: 'Подтвердите свое присутствие',
          ),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Пожалуйста, указывайте полные инициалы',
                      hintStyle: const TextStyle(
                        fontSize: 13,
                      ),
                      labelText: 'ФИО',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, введите ваше имя';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      labelText: 'Номер телефона',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixText: '+375 ',
                      // prefixStyle: const TextStyle(
                      //   color: Colors.black,
                      //   fontWeight: FontWeight.bold,
                      // ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, введите ваш номер телефона';
                      }
                      if (value.length != 9) {
                        return 'Пожалуйста, введите корректный номер';
                      }
                      if (!RegExp(r'^\d+$').hasMatch(value)) {
                        return 'Пожалуйста, введите корректный номер';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _guestsController,
                    decoration: InputDecoration(
                      labelText: 'Количество гостей',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, укажите количество гостей';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Пожалуйста, введите корректное число';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('Приду'),
                          value: true,
                          groupValue: _isAttending,
                          onChanged: (value) {
                            setState(() {
                              _isAttending = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('Не приду'),
                          value: false,
                          groupValue: _isAttending,
                          onChanged: (value) {
                            setState(() {
                              _isAttending = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(AppConstants.primaryColorValue),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      disabledBackgroundColor: const Color(AppConstants.primaryColorValue).withOpacity(0.5),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Отправить',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 