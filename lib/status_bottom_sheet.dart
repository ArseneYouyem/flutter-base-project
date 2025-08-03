import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum StatusType { success, error }

class StatusBottomSheet extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onPressed;
  final StatusType type;

  const StatusBottomSheet({
    Key? key,
    required this.title,
    required this.message,
    this.buttonText = 'Ok',
    this.onPressed,
    this.type = StatusType.success,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        left: 24.w,
        right: 24.w,
        top: 24.h,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            height: 5.h,
            width: 80.w,
            decoration: BoxDecoration(
              color: type == StatusType.success ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          SizedBox(height: 32.h),

          // Icon
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: (type == StatusType.success ? Colors.green : Colors.red)
                  .withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              type == StatusType.success ? Icons.check_circle : Icons.error,
              color: type == StatusType.success ? Colors.green : Colors.red,
              size: 40.w,
            ),
          ),
          SizedBox(height: 24.h),

          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 12.h),

          // Message
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  height: 1.5,
                ),
          ),
          SizedBox(height: 32.h),
          // Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed ?? () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                    color:
                        type == StatusType.success ? Colors.green : Colors.red),
                backgroundColor:
                    type == StatusType.success ? Colors.green : Colors.red,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
