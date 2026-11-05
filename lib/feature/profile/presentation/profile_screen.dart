import 'package:bookkia/feature/profile/data/model/profile_response_model.dart';
import 'package:bookkia/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookkia/feature/profile/presentation/ui/widget/profile_bar.dart';
import 'package:bookkia/feature/profile/presentation/ui/widget/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          children: [
            const ProfileBar(),
            20.h.verticalSpace,
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is GetProfileLoaded) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetProfileError) {
                  return const Center(
                    child: Text('Error loading profile'),
                  );
                } else if (state is GetProfileSuccess) {
                  final profile = state.profile;
                  final imageUrl = profile?.image;
                  final hasImage = imageUrl != null && imageUrl.trim().isNotEmpty;

                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 35.r,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: hasImage ? NetworkImage(imageUrl) : null,
                        child: !hasImage
                            ? Icon(Icons.person, size: 35.r, color: Colors.grey)
                            : null,
                      ),
                      16.w.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile?.name ?? '',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            6.h.verticalSpace,
                            Text(
                              profile?.email ?? '',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
            51.h.verticalSpace,
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                final profileItemData = [
                  Profile_item(Data: 'My Orders'),
                  Profile_item(Data: 'Edit Profile'),
                  Profile_item(Data: 'Reset Password'),
                  Profile_item(Data: 'FAQ'),
                  Profile_item(Data: 'Contact Us'),
                  Profile_item(Data: 'Privacy & Terms'),
                ];

                return Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: ProfileItem(Data: profileItemData[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
