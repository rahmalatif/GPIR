import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  static Future<void> openWhatsApp({
    required String phone,
    required String message,
  }) async {
    final Uri url = Uri.parse(
      'https://wa.me/2$phone?text=${Uri.encodeComponent(message)}',
    );

    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }
}