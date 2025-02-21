import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      padding:  EdgeInsets.all(8.w),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding:  EdgeInsets.all(8.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.developer_mode, size: 24.w, color: Colors.blue),
              SizedBox(height: 8.h),
              Text(
                "🚀 Mobile & Desktop App Development",
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 6.h),
              Text(
                "iOS, Android, Windows, macOS, Linux with Flutter - Single Codebase!",
                style: TextStyle(fontSize: 10.sp),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _launchURL("mailto:your_email@example.com"), // Email link
                    icon:  Icon(Icons.email,size: 14.w,),
                    label:  Text("Contact Me",style: TextStyle(fontSize: 12.sp),),
                  ),
                  const SizedBox(width: 10), // Spacing between buttons
                  IconButton(
                    onPressed: () => _launchURL("https://www.linkedin.com/in/john-colani-43344a70/"), // LinkedIn profile
                    icon:  SizedBox(
                        height: 20.h,
                        width: 20.w,
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
