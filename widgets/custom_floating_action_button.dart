import 'package:contact/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  bool isAddButtonVisible;
  bool isDeleteButtonVisible;
  VoidCallback showAddContact;
  VoidCallback deleteContact;

  CustomFloatingActionButton({
    required this.showAddContact,
    required this.deleteContact,
    this.isAddButtonVisible = false,
    this.isDeleteButtonVisible = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Visibility(
          visible: isDeleteButtonVisible,
          child: FloatingActionButton(
            onPressed: deleteContact,
            backgroundColor: AppColors.red,
            child: Icon(Icons.delete, color: AppColors.white),
          ),
        ),
        SizedBox(height: 8),
        Visibility(
          visible: isAddButtonVisible,
          child: FloatingActionButton(
            onPressed: showAddContact,
            backgroundColor: AppColors.white,
            child: Icon(Icons.add, color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
