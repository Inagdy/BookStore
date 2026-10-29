import 'package:bookkia/core/widget/custome_text_form_feild.dart';
import 'package:bookkia/feature/Home/cubit/home_cubit.dart';
import 'package:bookkia/feature/Home/data/model/books_model.dart';
import 'package:bookkia/feature/Home/presentation/ui/widget/book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: CustomeTextFormFeild(
                      autofocus: false,
                      controller: _searchController,
                      hintText: "Search",
                      onChanged: (value) {
                        context.read<HomeCubit>().searchBookNames(value ?? "");
                      },
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
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
                  } else if (state is SearchLSuccess) {
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .50,
                          mainAxisSpacing: 10.h,
                          crossAxisSpacing: 18.w,
                        ),

                        itemBuilder: (context, index) => BookItem(
                          products: state.products?[index],
                        ),
                        itemCount: state.products?.length,
                      ),
                    );
                  } else {
                    return Center( child: Text("Data is Empty"));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
