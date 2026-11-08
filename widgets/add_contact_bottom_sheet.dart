import 'dart:io';
import 'package:contact/model/contact_model.dart';
import 'package:contact/utils/app_assets.dart';
import 'package:contact/utils/app_colors.dart';
import 'package:contact/utils/app_strings.dart';
import 'package:contact/utils/app_styles.dart';
import 'package:contact/utils/image_picker_utils.dart';
import 'package:contact/utils/validation.dart';
import 'package:contact/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AddContactBottomSheet extends StatefulWidget {
  const AddContactBottomSheet({super.key});

  @override
  State<AddContactBottomSheet> createState() => _AddContactBottomSheetState();
}

class _AddContactBottomSheetState extends State<AddContactBottomSheet> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String username = 'Username';
    String email = 'test@example.com';
    String phoneNumber = '+200000000000';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  height: height * 0.16,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.white),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: pickedImage == null
                      ? GestureDetector(
                          onTap: () async {
                            File? tempImage =
                                await ImagePickerUtils.galleryPicker();
                            if (tempImage != null) {
                              pickedImage = tempImage;
                            }
                            setState(() {});
                          },
                          child: Lottie.asset(AppAnimations.imagePicker),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: Image.file(
                            pickedImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                flex: 6,
                child: Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: usernameController,
                      builder: (context, value, child) => Text(
                        value.text.isEmpty ? username : value.text,
                        style: AppStyles.font16WhiteSemiBold,
                      ),
                    ),
                    Divider(color: AppColors.white),
                    ValueListenableBuilder(
                      valueListenable: emailController,
                      builder: (context, value, child) => Text(
                        value.text.isEmpty ? email : value.text,
                        style: AppStyles.font16WhiteSemiBold,
                      ),
                    ),
                    Divider(color: AppColors.white),
                    ValueListenableBuilder(
                      valueListenable: phoneController,
                      builder: (context, value, child) => Text(
                        value.text.isEmpty ? phoneNumber : value.text,
                        style: AppStyles.font16WhiteSemiBold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  validator: (value) {
                    return Validation.notEmptyField(
                      value,
                      'Please Enter a username',
                    );
                  },
                  controller: usernameController,
                  hintText: AppStrings.enterUsername,
                ),
                SizedBox(height: 8),
                CustomTextFormField(
                  validator: (value) {
                    return Validation.emailValidator(value);
                  },
                  controller: emailController,
                  hintText: AppStrings.enterEmail,
                ),
                SizedBox(height: 8),
                CustomTextFormField(
                  validator: (value) {
                    return Validation.notEmptyField(
                      value,
                      'Please enter user number',
                    );
                  },
                  controller: phoneController,
                  hintText: AppStrings.enterPhone,
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ContactModel.contactList.add(
                        ContactModel(
                          userName: usernameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          imageFile: pickedImage,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      AppStrings.addContact,
                      style: AppStyles.font20WhiteSemiBold.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
