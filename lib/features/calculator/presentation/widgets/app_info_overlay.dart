import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:handi_calc/features/calculator/presentation/widgets/service_banner.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInfoOverlay extends StatefulWidget {
  const AppInfoOverlay({super.key});

  @override
  _AppInfoOverlayState createState() => _AppInfoOverlayState();
}

class _AppInfoOverlayState extends State<AppInfoOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;

  final List<AppItem> _apps = [
    AppItem(
      name: 'Absolute Stone Design',
      iconPath: 'assets/icons/absolute.png',
      androidUrl: 'https://play.google.com/store/apps/details?id=com.JohnColani.asdapp',
      iosUrl: 'https://apps.apple.com/us/app/asdusa/id1588331742?platform=iphone',
    ),
    AppItem(
      name: 'Phillips Rear-VU',
      iconPath: 'assets/icons/phillips.png',
      androidUrl: 'https://play.google.com/store/apps/details?id=com.phillipsind.phillips_rear_vu_mobile_app',
      iosUrl: 'https://apps.apple.com/us/app/phillips-rear-vu/id1669085162',
    ),
    AppItem(
      name: 'Infinite Note Plus',
      iconPath: 'assets/icons/note.png',
      androidUrl: 'https://play.google.com/store/apps/details?id=com.johncolani.greate_note_app',
      iosUrl: 'https://apps.apple.com/app/infinitenotesplus/id6737788298',
    ),
    AppItem(
      name: 'Twin Scripture',
      iconPath: 'assets/icons/scripture.png',
      androidUrl: 'https://play.google.com/store/apps/details?id=com.johncolani.twin.scripture',
      iosUrl: 'https://apps.apple.com/app/twin-scriptures/id6740755381',
    ),

    AppItem(
      name: 'Solomon Prayers Compass',
      iconPath: 'assets/icons/temple.png',
      androidUrl: 'https://apps.apple.com/app/solomon-prayers-compass/id6670187898',
      iosUrl: 'https://apps.apple.com/app/solomon-prayers-compass/id6670187898',
    ),
    AppItem(
      name: 'Dream Whisperer',
      iconPath: 'assets/icons/dream.png',
      androidUrl: 'https://apps.apple.com/us/app/dream-whisperer/id6547866253?platform=iphone',
      iosUrl: 'https://apps.apple.com/us/app/dream-whisperer/id6547866253?platform=iphone',
    ),
    // Add 4 more apps here
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _widthAnimation = Tween<double>(begin: 0, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchStore(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.3),
        body: SafeArea(
          child: Center(
            child: AnimatedBuilder(
              animation: _widthAnimation,
              builder: (context, child) {
                return Container(
                  width: size.width * _widthAnimation.value,
                  constraints: BoxConstraints(
                    maxWidth: size.width * 0.8,
                    maxHeight: size.height * 0.8,
                  ),
                  margin:  EdgeInsets.only(top: 50.h),
                  decoration:  BoxDecoration(
                    color: Color(0xFF191818),
                    borderRadius: BorderRadius.all(Radius.circular(20.r)),
                    border: GradientBoxBorder(
                      gradient: LinearGradient(colors: [
                        Colors.blueAccent,
                        Colors.purpleAccent
                      ]),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Column(
                      children: [
                        ServiceAdBanner(),

                        Padding(
                          padding:  EdgeInsets.only(bottom: 8.h),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                height: 100.h,
                                width: 100.w,
                                child: Image.asset("assets/images/Melody.jpg",fit: BoxFit.cover,)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            'My Applications',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _apps.length,
                            itemBuilder: (context, index) {
                              return _AppListItem(
                                app: _apps[index],
                                onAndroidTap: () => _launchStore(_apps[index].androidUrl),
                                onIosTap: () => _launchStore(_apps[index].iosUrl),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class AppItem {
  final String name;
  final String iconPath;
  final String androidUrl;
  final String iosUrl;

  AppItem({
    required this.name,
    required this.iconPath,
    required this.androidUrl,
    required this.iosUrl,
  });
}

class _AppListItem extends StatelessWidget {
  final AppItem app;
  final VoidCallback onAndroidTap;
  final VoidCallback onIosTap;

  const _AppListItem({
    required this.app,
    required this.onAndroidTap,
    required this.onIosTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border:  GradientBoxBorder(
          gradient: LinearGradient(colors: [
            Colors.blueAccent,
            Colors.purpleAccent
          ]),
          width: 1.r,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                image: DecorationImage(
                  image: AssetImage(app.iconPath),
                  fit: BoxFit.cover,
                ),
                border:  GradientBoxBorder(
                  gradient: LinearGradient(colors: [
                    Colors.blue,
                    Colors.purple
                  ]),
                  width: 1.r,
                ),
              ),
            ),
            title: Text(
              app.name,
              style:  TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Platform.isAndroid ?  _PlatformButton(
                  icon: Icons.android,
                  label: 'Android',
                  onTap: onAndroidTap,
                ): Platform.isIOS ?
                _PlatformButton(
                  icon: Icons.phone_iphone,
                  label: 'iOS',
                  onTap: onIosTap,
                ): Container(),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlatformButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PlatformButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 14.r),
            SizedBox(width: 6.w),
            Text(
              label,
              style:  TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}