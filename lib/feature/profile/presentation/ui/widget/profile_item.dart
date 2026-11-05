import 'package:bookkia/feature/profile/data/model/profile_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileItem extends StatelessWidget {
  final Profile_item Data ;
  const ProfileItem({super.key, required this.Data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        color: Colors.white,
      ),
      width: 356.w,
      height: 54.h,
      child: Row(
        children: [
          Padding(
            padding:EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(Data.Data, style: TextStyle(fontSize: 16)),
          ),

          Spacer(),
          Padding(
            padding:EdgeInsets.symmetric(horizontal: 10.w),
            child: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
