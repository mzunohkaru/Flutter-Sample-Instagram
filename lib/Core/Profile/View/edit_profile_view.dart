import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Core/Profile/ViewModel/profile_view_model.dart';

class EditProfileView extends HookConsumerWidget {
  File? _imageFile;
  final String initialUsername;
  final String initialBio;
  final viewModel = ProfileViewModel();

  EditProfileView({
    super.key,
    required this.initialUsername,
    required this.initialBio,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController(text: initialUsername);
    final bioController = useTextEditingController(text: initialBio);
    final isLoading = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: !isLoading.value
                ? () async {
                    isLoading.value = true;
                    await viewModel.updateProfile(
                        ref: ref,
                        username: usernameController.text,
                        bio: bioController.text,
                        profileImage: _imageFile);
                    isLoading.value = false;
                    Navigator.pop(context);
                  }
                : null,
            child: isLoading.value
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : const Text(
                    "Dane",
                    style: TextStyle(fontSize: 16),
                  ),
          ),
        ],
      ),
      body: Column(
        children: [
          StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setState(() {
                          _imageFile = File(pickedFile.path);
                        });
                      }
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          _imageFile != null ? FileImage(_imageFile!) : null,
                      child: _imageFile == null
                          ? Icon(Icons.person, size: 40)
                          : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'ユーザー名',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: bioController,
                      decoration: InputDecoration(
                        labelText: '自己紹介',
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
