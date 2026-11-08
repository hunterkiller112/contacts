import 'package:contact/model/contact_model.dart';
import 'package:contact/utils/app_assets.dart';
import 'package:contact/utils/app_colors.dart';
import 'package:contact/utils/app_strings.dart';
import 'package:contact/utils/app_styles.dart';
import 'package:contact/widgets/add_contact_bottom_sheet.dart';
import 'package:contact/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 16),
          child: Image.asset(AppImages.logo),
        ),
        leadingWidth: width * 0.25,
      ),
      floatingActionButton: CustomFloatingActionButton(
        isAddButtonVisible: ContactModel.contactList.length < 6,
        isDeleteButtonVisible: ContactModel.contactList.isNotEmpty,
        showAddContact: showContactBottomSheet,
        deleteContact: () {
          if (ContactModel.contactList.isNotEmpty) {
            ContactModel.contactList.removeLast();
            setState(() {});
          }
        },
      ),
      body: ContactModel.contactList.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(AppAnimations.emptyList),
                Text(
                  AppStrings.emptyListTitle,
                  style: AppStyles.font20WhiteSemiBold,
                ),
              ],
            )
          : GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.62,
              ),
              itemCount: ContactModel.contactList.length,
              itemBuilder: (context, index) {
                ContactModel contact = ContactModel.contactList[index];
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              child: contact.imageFile != null
                                  ? Image.file(
                                      contact.imageFile!,
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : Lottie.asset(AppAnimations.emptyUser),
                            ),
                            Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                contact.userName,
                                style: AppStyles.font14PrimaryColorSemiBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppIcons.emailIcon,
                                  width: 16,
                                  height: 16,
                                ),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    contact.email,
                                    style: AppStyles.font10PrimaryColorSemiBold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Image.asset(
                                  AppIcons.phoneIcon,
                                  width: 16,
                                  height: 16,
                                ),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    contact.phone,
                                    style: AppStyles.font10PrimaryColorSemiBold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.red,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  ContactModel.contactList.removeAt(index);
                                  setState(() {});
                                },
                                icon: Icon(Icons.delete, size: 16),
                                label: Text(AppStrings.delete),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  void showContactBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.primaryColor,
      builder: (context) {
        return AddContactBottomSheet();
      },
    ).then((value) {
      setState(() {});
    });
  }
}
