import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
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
                  margin: const EdgeInsets.only(top: 50),
                  decoration: const BoxDecoration(
                    color: Color(0xFF191818),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: GradientBoxBorder(
                      gradient: LinearGradient(colors: [
                        Colors.blueAccent,
                        Colors.purpleAccent
                      ]),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'My Applications',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: const GradientBoxBorder(
          gradient: LinearGradient(colors: [
            Colors.blueAccent,
            Colors.purpleAccent
          ]),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(app.iconPath),
                  fit: BoxFit.cover,
                ),
                border: const GradientBoxBorder(
                  gradient: LinearGradient(colors: [
                    Colors.blue,
                    Colors.purple
                  ]),
                  width: 1.5,
                ),
              ),
            ),
            title: Text(
              app.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _PlatformButton(
                  icon: Icons.android,
                  label: 'Android',
                  onTap: onAndroidTap,
                ),
                _PlatformButton(
                  icon: Icons.phone_iphone,
                  label: 'iOS',
                  onTap: onIosTap,
                ),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}