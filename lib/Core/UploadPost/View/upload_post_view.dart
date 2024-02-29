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
    final xFiles = useState<List<XFile>>([]); // 画像を複数管理する
    final isLoading = useState(false);

    // ギャラリーから複数の画像を選択
    Future<void> pickImage() async {
      final ImagePicker picker = ImagePicker();
      final List<XFile>? images = await picker.pickMultiImage(); // 複数画像選択
      if (images != null && images.length <= 3) {
        // 選択された画像が3枚以下であることを確認
        xFiles.value = images;
      }
    }

    final captionController = useTextEditingController();
    final isValidation = useState(false);
    useEffect(() {
      void listener() {
        isValidation.value =
            captionController.text.isNotEmpty && xFiles.value != [];
      }

      captionController.addListener(listener);
      xFiles.addListener(listener);
      return () {
        captionController.removeListener(listener);
        xFiles.removeListener(listener);
      };
    }, [captionController, xFiles]);

    void reset() {
      xFiles.value = [];
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
          // 画像選択部分のUIを調整
          InkWell(
            onTap: pickImage,
            child: AspectRatio(
              aspectRatio: 360 / 320,
              child: xFiles.value.isEmpty
                  ? Container(
                      color: Colors.grey,
                      child: const Icon(
                        Icons.image,
                        color: Colors.white,
                        size: 80,
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        crossAxisCount: xFiles.value.length,
                        childAspectRatio: 1.0
                      ),
                      itemCount: xFiles.value.length,
                      itemBuilder: (context, index) {
                        return Image.file(File(xFiles.value[index].path),
                            fit: BoxFit.cover);
                      },
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
                          imageFiles: xFiles.value,
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
