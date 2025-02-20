import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceAdBanner extends StatelessWidget {
  ServiceAdBanner({super.key}); // Constructor remains the same

  static Future<void> _launchURL(String url) async { // Now a static function
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.developer_mode, size: 50, color: Colors.blue),
              const SizedBox(height: 10),
              const Text(
                "🚀 Mobile & Desktop App Development",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                "iOS, Android, Windows, macOS, Linux with Flutter - Single Codebase!",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _launchURL("mailto:your_email@example.com"), // Email link
                    icon: const Icon(Icons.email),
                    label: const Text("Contact Me"),
                  ),
                  const SizedBox(width: 10), // Spacing between buttons
                  IconButton(
                    onPressed: () => _launchURL("https://www.linkedin.com/in/john-colani-43344a70/"), // LinkedIn profile
                    icon:  SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset("assets/icons/linkedin.png")),

                    // style: ElevatedButton.styleFrom(
                    //   backgroundColor: Colors.blue[700], // LinkedIn blue color
                    //   foregroundColor: Colors.white,
                    // ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
