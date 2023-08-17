

import 'package:flutter/material.dart';
import 'package:waiter/constants/styles.dart';

class CategoryItem extends StatelessWidget {
  final VoidCallback onTap;
  final Color ?borderColor;
  final Color? color;
  final String title;
  final Color titleColor;
  const CategoryItem({Key? key, required this.onTap,this.color,  this.borderColor ,required this.title, required this.titleColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          color: color ?? Colors.white,
          child: Row(
            children: [
              Container(
                width: 6,
                color: borderColor,
              ),
              SizedBox(width: 7,),
              Expanded(
                child: Text(title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: ConstantStyles.contextHeight(context) * 0.02,
                      color: titleColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
