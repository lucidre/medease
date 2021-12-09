import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper_widgets/colors.dart';

class UserEditProfileScreen extends StatefulWidget {
  const UserEditProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserEditProfileScreen> createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  String _phoneNumber = "";
  String _contactAddress = "";
  static const String select = "Please select item";
  String _genotype = select;
  String _bloodGroup = select;
  final _contactAddressFocusNode = FocusNode();
  final _phoneNumberController = TextEditingController(text: "");
  final _contactAddressController = TextEditingController(text: "");

  final GlobalKey<ScaffoldState> _genotypeKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _bloodGroupKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _phoneNumberController.addListener(() {
      _phoneNumber = _phoneNumberController.text;
    });
    _contactAddressController.addListener(() {
      _contactAddress = _contactAddressController.text;
    });
  }

  void openItemsList(GlobalKey<ScaffoldState> key) {
    GestureDetector? detector;
    void search(BuildContext? ctx) {
      ctx?.visitChildElements((element) {
        if (detector != null) return;
        if (element.widget is GestureDetector) {
          detector = element.widget as GestureDetector;
        } else {
          search(element);
        }
      });
    }

    search(key.currentContext);
    if (detector != null) detector!.onTap!();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _contactAddressController.dispose();
    _contactAddressFocusNode.dispose();
    super.dispose();
  }

  Container buildHeaderLayout(TextStyle? textStyle1, TextStyle? textStyle2) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        color: AppColors.primary,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 25,
          ),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(83),
              ),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(80)),
              child: Image.asset(
                'assets/images/avatar_1.jpg',
                width: 160,
                height: 160,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Lorem Ipisidom Swep',
            style: textStyle1!.copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Lorem/2025/004',
            style: textStyle2!.copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textStyle1 = textTheme.bodyText1;
    final textStyle2 = textTheme.bodyText2;
    final heading1 = textTheme.headline1;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: Text(
            'Edit Profile',
            style: heading1!.copyWith(fontSize: 22, color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Save clicked')));
              },
              icon: const Icon(Icons.save, color: Colors.black))
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              buildHeaderLayout(textStyle1, textStyle2),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 3))),
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_contactAddressFocusNode);
                    },
                    style: textStyle2,
                    controller: _phoneNumberController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    focusNode: _contactAddressFocusNode,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        labelText: 'Contact Address',
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 3))),
                    style: textStyle2,
                    controller: _contactAddressController,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: Text('Genotype', style: textStyle1)),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: AppColors.color4,
                      elevation: 3,
                      shadowColor: AppColors.color2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 5, bottom: 5),
                        child: GestureDetector(
                          onTap: () => openItemsList(_genotypeKey),
                          child: DropdownButtonFormField(
                            key: _genotypeKey,
                            items: [select, 'AS', 'SS', 'O', "Others"]
                                .map(
                                  (val) => DropdownMenuItem<String>(
                                    child: Text(val),
                                    value: val,
                                  ),
                                )
                                .toList(),
                            value: _genotype,
                            hint: const Text('Please select your genotype'),
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 20,
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent))),
                            style: textStyle2,
                            onChanged: (value) {
                              _genotype = (value as String?) ?? "Others";
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: Text('Blood Group', style: textStyle1)),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: AppColors.color4,
                      elevation: 3,
                      shadowColor: AppColors.color2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 5, bottom: 5),
                        child: GestureDetector(
                          onTap: () => openItemsList(_bloodGroupKey),
                          child: DropdownButtonFormField(
                            key: _bloodGroupKey,
                            items: [select, 'AS', 'SS', 'O', "Others"]
                                .map(
                                  (val) => DropdownMenuItem<String>(
                                    child: Text(val),
                                    value: val,
                                  ),
                                )
                                .toList(),
                            value: _bloodGroup,
                            hint: const Text('Please select your blood group'),
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 20,
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent))),
                            style: textStyle2,
                            onChanged: (value) {
                              _bloodGroup = (value as String?) ?? "Others";
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
