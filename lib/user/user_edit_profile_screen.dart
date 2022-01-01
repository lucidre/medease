import 'package:flutter/material.dart';

import '../helper_widgets/blue_image.dart';
import '../helper_widgets/colors.dart';

class UserEditProfileScreen extends StatefulWidget {
  const UserEditProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserEditProfileScreen> createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  static const String _phoneNumber = "phoneNumber";
  static const String _firstName = "firstName";
  static const String _lastName = "lastName";
  static const String _contactAddress = "contactAddress";

  final Map<String, dynamic> _initValues = {
    _contactAddress: '',
    _phoneNumber: '',
    _firstName: '',
    _lastName: '',
  };
  static const String select = "Please select item";
  String _genotype = select;
  String _bloodGroup = select;
  final _form = GlobalKey<FormState>();
  final _contactAddressFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();

  final GlobalKey<ScaffoldState> _genotypeKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _bloodGroupKey = GlobalKey<ScaffoldState>();

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if ((isValid ?? false) == false) {
      return;
    }
    _form.currentState?.save();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Save clicked')));
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
    _contactAddressFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textStyle1 = textTheme.bodyText1;
    final textStyle2 = textTheme.bodyText2;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          BlueImageContainer(
              height: height * 0.4,
              width: double.infinity,
              showHeader: false,
              headerTopSpacer: height * 0.15,
              imageLocation: 'assets/images/dummy9.jpg'),
          SizedBox(
            height: height,
            child: SingleChildScrollView(
              child: Form(
                key: _form,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).padding.top,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: Text(
                                'Edit Profile',
                                textAlign: TextAlign.center,
                                style:
                                    textStyle1!.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                _saveForm();
                              },
                              icon: const Icon(Icons.save, color: Colors.white))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 25, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'First Name',
                              style: textStyle2!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Enter your first name',
                            ),
                            style: textStyle2.copyWith(fontSize: 18),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_lastNameFocusNode);
                            },
                            onSaved: (value) {
                              _initValues[_firstName] = value ?? "";
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please provide your first name.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Last Name',
                              style: textStyle2.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextFormField(
                            focusNode: _lastNameFocusNode,
                            decoration: const InputDecoration(
                              hintText: 'Enter your last name',
                            ),
                            style: textStyle2.copyWith(fontSize: 18),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_phoneNumberFocusNode);
                            },
                            onSaved: (value) {
                              _initValues[_lastName] = value ?? "";
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please provide your last name.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Phone Number',
                              style: textStyle2.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextFormField(
                            focusNode: _phoneNumberFocusNode,
                            decoration: const InputDecoration(
                              hintText: 'Enter your phone number',
                            ),
                            style: textStyle2.copyWith(fontSize: 18),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_contactAddressFocusNode);
                            },
                            onSaved: (value) {
                              _initValues[_phoneNumber] = value ?? "";
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please provide your phone number.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Contact Address',
                              style: textStyle2.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextFormField(
                            focusNode: _contactAddressFocusNode,
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                              hintText: "Please provide your contact address",
                            ),
                            style: textStyle2.copyWith(fontSize: 18),
                            onSaved: (value) {
                              _initValues[_contactAddress] = value ?? "";
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please provide your contact address.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                              width: double.infinity,
                              child: Text('Genotype',
                                  style: textStyle2.copyWith(
                                      fontWeight: FontWeight.bold))),
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
                                    hint: const Text(
                                        'Please select your genotype'),
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 20,
                                    decoration: const InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent))),
                                    style: textStyle2,
                                    onChanged: (value) {
                                      _genotype =
                                          (value as String?) ?? "Others";
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                              width: double.infinity,
                              child: Text('Blood Group',
                                  style: textStyle2.copyWith(
                                      fontWeight: FontWeight.bold))),
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
                                    hint: const Text(
                                        'Please select your blood group'),
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 20,
                                    decoration: const InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent))),
                                    style: textStyle2,
                                    onChanged: (value) {
                                      _bloodGroup =
                                          (value as String?) ?? "Others";
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                elevation: 5,
                              ),
                              onPressed: () {
                                _saveForm();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 10.0),
                                child: Text(
                                  'Update Data',
                                  style: textStyle2.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
