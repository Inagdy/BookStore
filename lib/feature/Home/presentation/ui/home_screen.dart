import 'package:bookkia/core/routes/app_route.dart';
import 'package:bookkia/feature/Home/cubit/home_cubit.dart';
import 'package:bookkia/feature/Home/data/model/books_model.dart';
import 'package:bookkia/feature/Home/presentation/ui/widget/book_item.dart';
import 'package:bookkia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
            Assets.assests.images.spash.image(width: 99.w, height: 30.h),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoute.searchScreen);
              },
              child: SvgPicture.asset(Assets.assests.icons.searchNormal),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Best Saller",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 24.sp,
                ),
              ),
            ),
            12.h.verticalSpace,
            BlocListener<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is AddToCartSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Book added to cart successfully'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else if (state is AddToCartError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to add book to cart'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const SizedBox.shrink(),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  current is GetBestSaller_loadingState ||
                  current is GetBestSaller_SuccesState ||
                  current is GetBestSaller_ErrorState,
              builder: (context, state) {
                final cubitBooks = context.read<HomeCubit>().bestsellerBooks;
                final books = (state is GetBestSaller_SuccesState)
                    ? state.products
                    : cubitBooks;

                if (state is GetBestSaller_loadingState && books == null) {
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
                } else if (books != null && books.isNotEmpty) {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .50,
                        mainAxisSpacing: 10.h,
                        crossAxisSpacing: 18.w,
                      ),
                      itemBuilder: (context, index) =>
                          BookItem(products: books[index]),
                      itemCount: books.length,
                    ),
                  );
                } else if (state is GetBestSaller_ErrorState) {
                  return const Expanded(
                    child: Center(child: Text("Error loading books")),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
