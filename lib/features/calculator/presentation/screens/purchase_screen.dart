import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191818),
      appBar: AppBar(
        backgroundColor: const Color(0xFF191818),
        title: Text(
          'Remove Ads',
          style: TextStyle(color: Colors.grey.shade300, fontSize: 18.sp),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Icon
                  Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: Colors.blue.shade300, width: 2),
                    ),
                    child: Icon(
                      Icons.calculate,
                      size: 60.sp,
                      color: Colors.blue.shade300,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  
                  // Title
                  Text(
                    'Fraction Flow Pro',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  
                  // Description
                  Text(
                    'Upgrade to Pro and enjoy an ad-free experience while supporting the development of new features.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 16.sp,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  
                  // Features List
                  _buildFeatureItem('Remove all advertisements', Icons.block),
                  SizedBox(height: 16.h),
                  _buildFeatureItem('Support future development', Icons.favorite),
                  SizedBox(height: 16.h),
                  _buildFeatureItem('Priority customer support', Icons.support_agent),
                  SizedBox(height: 16.h),
                  _buildFeatureItem('Access to beta features', Icons.new_releases),
                ],
              ),
            ),
            
            // Purchase Button
            Container(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () {
                  _handlePurchase(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 4,
                ),
                child: Text(
                  'Purchase Pro Version - \$2.99',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            
            // Restore Purchase Button
            TextButton(
              onPressed: () {
                _handleRestorePurchase(context);
              },
              child: Text(
                'Restore Previous Purchase',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.green.shade400,
          size: 24.sp,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
        ),
      ],
    );
  }

  void _handlePurchase(BuildContext context) {
    // TODO: Implement actual purchase logic with in-app purchases
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2A2A),
          title: Text(
            'Purchase',
            style: TextStyle(color: Colors.white, fontSize: 18.sp),
          ),
          content: Text(
            'This will integrate with your app store\'s in-app purchase system. For now, this is a demo.',
            style: TextStyle(color: Colors.grey[300], fontSize: 14.sp),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(color: Colors.blue.shade400),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleRestorePurchase(BuildContext context) {
    // TODO: Implement restore purchase logic
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2A2A),
          title: Text(
            'Restore Purchase',
            style: TextStyle(color: Colors.white, fontSize: 18.sp),
          ),
          content: Text(
            'This will check for previous purchases and restore them if found.',
            style: TextStyle(color: Colors.grey[300], fontSize: 14.sp),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(color: Colors.blue.shade400),
              ),
            ),
          ],
        );
      },
    );
  }
}