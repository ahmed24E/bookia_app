import 'dart:io';

import 'package:bookia_app/core/functions/dialogs.dart';
import 'package:bookia_app/core/functions/navigation.dart';
import 'package:bookia_app/core/utils/colors.dart';
import 'package:bookia_app/core/utils/text_styles.dart';
import 'package:bookia_app/core/widgets/custom_button.dart';
import 'package:bookia_app/core/widgets/nav_bar_widget.dart';
import 'package:bookia_app/features/profile/data/model/request/edit_user_model_params.dart';
import 'package:bookia_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key, required this.model});

  final UpdateUserModelParams model;

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  String path = '';

  @override
  void initState() {
    super.initState();

    usernameController = TextEditingController(text: widget.model.name);
    phoneController = TextEditingController(text: widget.model.phone);
    addressController = TextEditingController(text: widget.model.address);
  }

  uploadImage() async {
    var pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        path = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is UpdateProfileLoadingState) {
            showLoadingDialog(context);
          } else if (state is UpdateProfileSuccessState) {
            pushAndRemoveUntil(
                context,
                const NavBarWidget(
                  preIndex: 3,
                ));
          } else if (state is ProfileErrorState) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.redColor,
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: const Text('Edit Profile'),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (path.isNotEmpty) {
                      context.read<ProfileBloc>().add(UpdateProfileEvent(
                              params: UpdateUserModelParams(
                            name: usernameController.text,
                            phone: phoneController.text,
                            address: addressController.text,
                            image: path,
                          )));
                    } else {
                      context.read<ProfileBloc>().add(UpdateProfileEvent(
                              params: UpdateUserModelParams(
                            name: usernameController.text,
                            phone: phoneController.text,
                            address: addressController.text,
                          )));
                    }
                  }
                },
                text: 'Save Changes',
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // update image using circle avater
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundImage: path.isNotEmpty
                                ? FileImage(File(path)) as ImageProvider
                                : NetworkImage(
                                    widget.model.image ?? '',
                                  ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.whiteColor,
                              child: IconButton(
                                  onPressed: () {
                                    uploadImage();
                                  },
                                  icon: const Icon(Icons.camera_alt)),
                            ),
                          ),
                        ],
                      ),
                      const Gap(20),
                      const Divider(),
                      const Gap(20),
                      Row(
                        children: [
                          Text(
                            'Customer Information',
                            style: getFont18TextStyle(),
                          ),
                        ],
                      ),
                      const Gap(15),
                      TextFormField(
                        controller: usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Name',
                        ),
                      ),

                      const Gap(15),
                      TextFormField(
                        controller: phoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Phone',
                        ),
                      ),
                      const Gap(15),
                      TextFormField(
                        controller: addressController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Address',
                        ),
                      ),
                      const Gap(15),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
