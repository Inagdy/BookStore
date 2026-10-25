import 'package:bookkia/core/theme/app_colors.dart';
import 'package:bookkia/feature/Home/data/model/books_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookItem extends StatelessWidget {
  final Products? products;
  const BookItem({super.key, this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      width: 163.w,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              products?.image??" ",
              width: 140.w,
              height: 175.h,
              fit: BoxFit.cover,
            ),
          ),
          20.verticalSpace,
          Text(products?.name??""),
          8.verticalSpace,
          Row(
            children: [
              Expanded(child: Text(products?.price??'')),
              IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
            ],
          ),
        ],
      ),
    );
  }
}
