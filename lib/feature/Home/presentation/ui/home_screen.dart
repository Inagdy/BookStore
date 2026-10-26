import 'package:bookkia/feature/Home/cubit/home_cubit.dart';
import 'package:bookkia/feature/Home/data/model/books_model.dart';
import 'package:bookkia/feature/Home/presentation/ui/widget/book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assests/images/spash.png", width: 99.w, height: 30.h),
            Spacer(),
            Icon(Icons.search),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text(
                "Best Saller",
                style: TextStyle(fontWeight: FontWeight(400), fontSize: 24.sp),
              ),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is GetBestSaller_loadingState) {
                  return Expanded(
                    child: Skeletonizer(
                      enabled: true,
                      effect: const ShimmerEffect(),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .50,
                          mainAxisSpacing: 10.h,
                          crossAxisSpacing: 18.w,
                        ),
                        itemBuilder: (context, index) => BookItem(
                          products: Products(
                            name: "Lorem ipsum dolor sit amet",
                            price: "\$00.00",
                            image: "",
                          ),
                        ),
                        itemCount: 8,
                      ),
                    ),
                  );
                } else if (state is GetBestSaller_SuccesState) {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .50,
                        mainAxisSpacing: 10.h,
                        crossAxisSpacing: 18.w,
                      ),

                      itemBuilder: (context, index) =>
                          BookItem(products: state.products![index]),
                      itemCount: state.products?.length,
                    ),
                  );
                } else {
                  return Center(child: Text("error"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
