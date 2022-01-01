import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';

import '../../helper_widgets/colors.dart';

class UploadFile extends StatefulWidget {
  final Function(List<Map<String, Object>>) pop;
  final List<Map<String, Object>> changeValue;

  const UploadFile({Key? key, required this.pop, required this.changeValue})
      : super(key: key);

  @override
  _UploadFileState createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  double progressValue = 0;
  String title = '';

  Future<CloudinaryResponse?> uploadFileOnCloudinary(
      {required String filePath,
      required int position,
      required CloudinaryResourceType resourceType}) async {
    CloudinaryResponse? response;
    try {
      var cloudinary = CloudinaryPublic('kikks', 'medease', cache: false);
      response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          filePath,
          resourceType: resourceType,
          folder: 'image/upload',
          context: {
            'alt': 'Hello',
            'caption': 'Passport',
          },
        ),
        onProgress: (count, total) {
          setState(() {
            progressValue =
                (((count / total) + position) / widget.changeValue.length);
          });
        },
      );
    } on CloudinaryException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? "")));
    }
    return response;
  }

  /*
  RECEIVED FILE TYPE
  changeValues.add({
      'position': healthCenterPos,
      'title': 'Health Center Bio Data',
      'value': newValues[passportPos]
    });
    */
  void pickFiles() async {
    List<Map<String, Object>> response = [];

    for (var element in widget.changeValue) {
      final index = widget.changeValue.indexOf(element);
      setState(() {
        title = element['title'] as String;
      });
      var uploadResponse = await uploadFileOnCloudinary(
        filePath: element['value'] as String,
        position: index,
        resourceType: CloudinaryResourceType.Auto,
      );
      if (uploadResponse != null && uploadResponse.secureUrl.isNotEmpty) {
        response.add({
          'position': element['position'] as int,
          'value': uploadResponse.secureUrl
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Error Occurred')));
        response
            .add({'position': element['position'] as int, 'value': 'error'});
      }
    }
    widget.pop(response);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      pickFiles();
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context).textTheme;
    var textTheme = themeData.bodyText1;

    return Container(
      width: 300,
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 200,
            alignment: Alignment.center,
            width: 280,
            decoration: const BoxDecoration(
                color: AppColors.color8,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: const Icon(
              Icons.drive_folder_upload,
              color: AppColors.color3,
              size: 100,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Uploading $title...',
            style: textTheme,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          LinearProgressIndicator(
            value: progressValue,
            backgroundColor: AppColors.color8,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            semanticsLabel: 'Linear progress indicator',
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
