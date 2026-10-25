import 'package:bookkia/feature/Home/cubit/home_cubit.dart';
import 'package:bookkia/feature/Home/presentation/ui/widget/book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
 BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is GetBestSaller_loadingState) {
                    return CircularProgressIndicator();
                  } else if (state is GetBestSaller_SuccesState) {
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .50,
                          mainAxisSpacing: 10.h,
                          crossAxisSpacing: 18.w,
                        ),
                      
                        itemBuilder: (context, index) => BookItem(
                          products: state.products![index],
                        ),
                        itemCount: state.products?.length,
                      ),
                    );
                  } else {
                    return Center( child: Text("error"));
                  }
                },
              ),

          ],
        ),
      ),
    );
  }
}
