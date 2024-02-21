import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Core/UploadPost/ViewModel/upload_post_view_model.dart';
import 'package:instagram_clone/Utils/constant.dart';

class UploadPostView extends HookConsumerWidget {
  final viewModel = UploadPostViewModel();
  final Function resetAndNavigateToFeed;

  UploadPostView({super.key, required this.resetAndNavigateToFeed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _image = useState<XFile?>(null);
    final isLoading = useState(false);

    // ギャラリーにアクセス
    Future<void> _pickImage() async {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _image.value = image;
      }
    }

    final captionController = useTextEditingController();
    final isValidation = useState(false);
    useEffect(() {
      void listener() {
        isValidation.value =
            captionController.text.isNotEmpty && _image.value != null;
      }

      captionController.addListener(listener);
      _image.addListener(listener);
      return () {
        captionController.removeListener(listener);
        _image.removeListener(listener);
      };
    }, [captionController, _image]);

    void reset() {
      _image.value = null;
      captionController.clear();
      isLoading.value = false;
      resetAndNavigateToFeed();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text("Upload Post", style: kAppBarTitleTextStyle),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: _pickImage,
            child: AspectRatio(
              aspectRatio: 360 / 320,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: _image.value != null
                      ? DecorationImage(
                          image: FileImage(File(_image.value!.path)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _image.value == null
                    ? const Icon(
                        Icons.image,
                        color: Colors.white,
                        size: 80,
                      )
                    : null,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: captionController,
            decoration: const InputDecoration(
              hintText: "Caption..",
            ),
            maxLines: 5,
            maxLength: 120,
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: isValidation.value && !isLoading.value
                  ? () async {
                      isLoading.value = true;
                      await viewModel.uploadPost(
                          ref: ref,
                          imageFile: _image.value!,
                          caption: captionController.text);

                      reset();
                    }
                  : null,
              child: isLoading.value
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : const Text(
                      "Upload",
                      style: TextStyle(fontSize: 16),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
