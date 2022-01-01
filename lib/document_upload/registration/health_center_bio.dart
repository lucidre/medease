import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:medease/document_upload/registration/document_registration1.dart';
import 'package:medease/helper_widgets/colors.dart';

class HealthCenterBioDataScreen extends StatefulWidget {
  final String healthCenterBio;
  final Function(String, String) downloadFile;
  final Function(int, String) updateValue;
  final bool isVerified;

  const HealthCenterBioDataScreen(
      {Key? key,
      required this.healthCenterBio,
      required this.downloadFile,
      required this.isVerified,
      required this.updateValue})
      : super(key: key);

  @override
  _HealthCenterBioDataScreenState createState() =>
      _HealthCenterBioDataScreenState();
}

class _HealthCenterBioDataScreenState extends State<HealthCenterBioDataScreen> {
  String _healthCenterBio = '';

  @override
  void initState() {
    super.initState();
    _healthCenterBio = widget.healthCenterBio;
  }

  void showFilePicker(int position) async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.any, allowMultiple: false);

    if (result != null) {
      var filePath = result.files.single.path ?? "";
      if (filePath.isNotEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('File Selected')));
        widget.updateValue(position, filePath);
        setState(() {
          _healthCenterBio = filePath;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('File Selection Canceled')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File Picking Selection Canceled')));
    }
  }

  void showUploadDialog(int position) {
    var themeData = Theme.of(context).textTheme;
    var textTheme = themeData.bodyText1;
    var textStyle2 = themeData.bodyText2;

    Dialog dialog = Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 5,
      child: Container(
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
              'Please select file',
              style: textTheme,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  elevation: 5,
                ),
                onPressed: () {
                  var navigatorState = Navigator.of(context);
                  navigatorState.pop();
                  showFilePicker(position);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    'Select File',
                    style: textStyle2!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.blue, width: 2),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                    side: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                onPressed: () {
                  var navigatorState = Navigator.of(context);
                  navigatorState.pop();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    'Cancel',
                    style: textStyle2.copyWith(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showGeneralDialog(
      context: context,
      barrierLabel: "Pick Document",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context).textTheme;
    var bodyText2 = themeData.bodyText2;
    var bodyText1 = themeData.bodyText1;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: AppColors.color4,
      elevation: 4,
      shadowColor: AppColors.color2,
      margin: const EdgeInsets.all(5.0),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 6.0, right: 6.0, top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Health Center Bio Data',
              style: bodyText1,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              _healthCenterBio.isEmpty
                  ? 'Document not uploaded'
                  : _healthCenterBio,
              style: bodyText2!.copyWith(
                  color: _healthCenterBio.isEmpty
                      ? Colors.red
                      : Colors.blueAccent),
            ),
            const SizedBox(
              width: 3,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                widget.healthCenterBio.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          widget.downloadFile(
                              widget.healthCenterBio, 'Health Center Bio Data');
                        },
                        icon: const Icon(
                          Icons.download,
                          color: Colors.black45,
                        ))
                    : Container(),
                const SizedBox(
                  width: 3,
                ),
                widget.isVerified
                    ? Container()
                    : IconButton(
                        onPressed: () {
                          showUploadDialog(healthCenterPos);
                        },
                        icon: const Icon(
                          Icons.upload,
                          color: Colors.blueAccent,
                        )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
