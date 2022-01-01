import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../helper_widgets/auth.dart';
import '../../helper_widgets/blue_image.dart';
import '../../helper_widgets/colors.dart';
import '../../main/drawer_screen.dart';
import 'ecg_text.dart';
import 'eye_test.dart';
import 'haematology_test.dart';
import 'upload_file.dart';
import 'urine_test.dart';

const haematologyPos = 0;
const eyeTestPos = 1;
const urineTestPos = 2;
const ecgTestPos = 3;

class DocumentUpload2Screen extends StatefulWidget {
  const DocumentUpload2Screen({Key? key}) : super(key: key);

  @override
  _DocumentUpload2ScreenState createState() => _DocumentUpload2ScreenState();
}

class _DocumentUpload2ScreenState extends State<DocumentUpload2Screen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> serverValues = ['', '', '', ''];
  List<String> newValues = ['', '', '', ''];
  bool _isInitializing = true;
  var _comments = [];

  int statusPosition = 0;
  final List<String> statuses = [
    "Please provide these documents to continue your registration",
    //in complete
    "Document(s) submitted are being review",
    // in review
    "Document(s) uploaded has been declined, please see comment below",
    //declined
    "Uploaded document(s) have been verified"
    //complete
  ];

  void download(String url, String fileName) async {
    try {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Download Started')));
      const platform = MethodChannel('native_communication');
      await platform.invokeMethod(
          'downloadFile', {'file_url': url, 'file_name': fileName});
    } catch (exception) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Error Occurred')));
    }
  }

  void showDownloadDialog(String url, String fileName) {
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
                Icons.file_download,
                color: AppColors.color3,
                size: 100,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Do you want to download this file',
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
                  download(url, fileName);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    'Download',
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
      barrierLabel: "Download Document",
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

  void getUserStatus() async {
    var stageTwoStatus = await stageTwoVPStatus(context);
    var error = stageTwoStatus['error'] as String;

    if (error == '') {
      var eyeTest = (stageTwoStatus['eye_test_result']) as String? ?? "";
      var ecgTest = (stageTwoStatus['ecg_test_result'] as String?) ?? "";
      var urineTest = (stageTwoStatus['urine_test_result'] as String?) ?? "";
      var haematologyTest =
          (stageTwoStatus['hermatology_test_result'] as String?) ?? "";

      _comments = (stageTwoStatus['comments'] as List<dynamic>?) ?? [];
      var status = (stageTwoStatus['status'] as String?) ?? "incomplete";

      if (status == 'incomplete') {
        statusPosition = 0;
      } else if (status == 'in review') {
        statusPosition = 1;
      } else if (status == "declined") {
        statusPosition = 2;
      } else if (status == "complete") {
        statusPosition = 3;
      }

      serverValues[eyeTestPos] = eyeTest;
      newValues[eyeTestPos] = eyeTest;

      serverValues[ecgTestPos] = ecgTest;
      newValues[ecgTestPos] = ecgTest;

      serverValues[urineTestPos] = urineTest;
      newValues[urineTestPos] = urineTest;

      serverValues[haematologyPos] = haematologyTest;
      newValues[haematologyPos] = haematologyTest;

      setState(() {
        _isInitializing = false;
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
    }
  }

  /// if new value has an empty item show snack bar to upload missing file,
  /// check for the file that has changed and add it to a new list of items to upload
  ///
  void submit() async {
    List uploadValues = ['', '', '', ''];
    List<Map<String, Object>> changedValues = [];

    if (newValues[eyeTestPos].isEmpty ||
        newValues[ecgTestPos].isEmpty ||
        newValues[urineTestPos].isEmpty ||
        newValues[haematologyPos].isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please attach missing file(s)')));
    } else {
      if (newValues[eyeTestPos] != serverValues[eyeTestPos]) {
        changedValues.add({
          'position': eyeTestPos,
          'title': 'Eye Test',
          'value': newValues[eyeTestPos]
        });
      } else {
        uploadValues[eyeTestPos] = newValues[eyeTestPos];
      }
      if (newValues[ecgTestPos] != serverValues[ecgTestPos]) {
        changedValues.add({
          'position': ecgTestPos,
          'title': 'ECG Test',
          'value': newValues[ecgTestPos]
        });
      } else {
        uploadValues[ecgTestPos] = newValues[ecgTestPos];
      }
      if (newValues[urineTestPos] != serverValues[urineTestPos]) {
        changedValues.add({
          'position': urineTestPos,
          'title': 'Urine Test',
          'value': newValues[urineTestPos]
        });
      } else {
        uploadValues[urineTestPos] = newValues[urineTestPos];
      }
      if (newValues[haematologyPos] != serverValues[haematologyPos]) {
        changedValues.add({
          'position': haematologyPos,
          'title': 'Haematology Test',
          'value': newValues[haematologyPos]
        });
      } else {
        uploadValues[haematologyPos] = newValues[haematologyPos];
      }

      if (changedValues.isEmpty) {
        //noting was changed
        var message = await uploadDocument2(
          eyeTest: uploadValues[eyeTestPos],
          ecgTest: uploadValues[ecgTestPos],
          context: context,
          urineTest: uploadValues[urineTestPos],
          haematologyTest: uploadValues[haematologyPos],
        );

        if (message == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Verification profile Submitted")));
          if (statusPosition == 0) {
            setState(() {
              statusPosition = 1;
            });
          }
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        }
      } else {
        Dialog dialog = Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          elevation: 5,
          child: UploadFile(
            pop: (values) async {
              /*  response format
              response.add({
                'position': element['position'] as int,
                'value': uploadResponse.secureUrl
              });*/
              for (var element in values) {
                final position = element['position'] as int;
                final value = element['value'];
                uploadValues[position] = value;
              }
              var message = await uploadDocument2(
                eyeTest: uploadValues[eyeTestPos],
                ecgTest: uploadValues[ecgTestPos],
                urineTest: uploadValues[urineTestPos],
                haematologyTest: uploadValues[haematologyPos],
                context: context,
              );

              Navigator.of(context).pop();
              if (message == 'success') {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Verification profile Submitted")));
                if (statusPosition == 0) {
                  setState(() {
                    statusPosition = 1;
                  });
                }
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message)));
              }
            },
            changeValue: changedValues,
          ),
        );
        showGeneralDialog(
          context: context,
          barrierLabel: "Uploading Document",
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => dialog,
          transitionBuilder: (_, anim, __, child) => FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
            child: child,
          ),
        );
      }
    }
  }

  Widget buildHeader(ThemeData themeData) {
    var heading1 = themeData.textTheme.headline1;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/full_logo.png',
                height: 40,
                color: Colors.white,
                width: 100,
                fit: BoxFit.contain,
              ),
              IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ))
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            'Document Upload',
            style: heading1!.copyWith(color: Colors.white, fontSize: 35),
          ),
          const SizedBox(
            height: 25,
          ),
        ]),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      getUserStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var themeData = Theme.of(context);
    var textStyle1 = themeData.textTheme.bodyText1;
    var textStyle2 = themeData.textTheme.bodyText2;
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerScreen(),
      body: Stack(
        children: [
          BlueImageContainer(
              height: height * 0.5,
              width: double.infinity,
              imageLocation: 'assets/images/dummy2.jpg'),
          SizedBox(
            height: height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildHeader(themeData),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 8),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Health Center Registration',
                            style: textStyle1!.copyWith(
                                color: AppColors.color3, fontSize: 30),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            statuses[statusPosition],
                            style: textStyle2!.copyWith(
                                color: statusPosition == 2
                                    ? Colors.red
                                    : Colors.lightBlue),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ...(_isInitializing
                            ? buildBodyOnLoading(height)
                            : buildBodyOnSuccess(textStyle2)),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildBodyOnSuccess(TextStyle textStyle2) {
    return [
      ...(statusPosition == 2 ? buildCommentsSection() : [Container()]),
      HaematologyTestScreen(
        haematologyTest: serverValues[haematologyPos],
        downloadFile: showDownloadDialog,
        isVerified: statusPosition == 3,
        updateValue: (position, value) {
          newValues[position] = value;
        },
      ),
      const SizedBox(
        height: 8,
      ),
      EyeTestScreen(
        eyeTest: serverValues[eyeTestPos],
        downloadFile: showDownloadDialog,
        isVerified: statusPosition == 3,
        updateValue: (position, value) {
          newValues[position] = value;
        },
      ),
      const SizedBox(
        height: 8,
      ),
      EcgTestScreen(
        ecgTest: serverValues[ecgTestPos],
        downloadFile: showDownloadDialog,
        isVerified: statusPosition == 3,
        updateValue: (position, value) {
          newValues[position] = value;
        },
      ),
      const SizedBox(
        height: 8,
      ),
      UrineTestScreen(
        urineTest: serverValues[urineTestPos],
        downloadFile: showDownloadDialog,
        isVerified: statusPosition == 3,
        updateValue: (position, value) {
          newValues[position] = value;
        },
      ),
      const SizedBox(
        height: 30,
      ),
      statusPosition == 3
          ? Container()
          : SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  elevation: 5,
                ),
                onPressed: () {
                  statusPosition == 3
                      ? ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Next Clicked')))
                      : submit();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    'Submit',
                    style: textStyle2.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
    ];
  }

  List<Widget> buildCommentsSection() {
    var themeData = Theme.of(context);
    var textStyle1 = themeData.textTheme.bodyText1;
    var textStyle2 = themeData.textTheme.bodyText2;
    return [
      SizedBox(
        width: double.infinity,
        child: Text(
          'Comments',
          style: textStyle1!.copyWith(color: AppColors.color3, fontSize: 26),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      ..._comments
          .map((comment) => SizedBox(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: AppColors.color4,
                  elevation: 5,
                  shadowColor: AppColors.color2,
                  margin: const EdgeInsets.all(5.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 15, bottom: 15),
                    child: Text(
                      comment,
                      style: textStyle2!.copyWith(color: Colors.red),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ))
          .toList(),
      const SizedBox(
        height: 10,
      ),
    ];
  }

  List<Widget> buildBodyOnLoading(double height) {
    return [
      SizedBox(
        height: height * 0.25,
      ),
      const SizedBox(
          width: 50, height: 50, child: CircularProgressIndicator.adaptive()),
    ];
  }
}
