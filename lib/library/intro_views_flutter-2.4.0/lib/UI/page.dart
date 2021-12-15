import 'package:flutter/material.dart';
import 'package:medease/library/intro_views_flutter-2.4.0/lib/Models/page_view_model.dart';

/// This is the class which contains the Page UI.
class PageIntro extends StatelessWidget {
  ///page details
  final PageViewModel pageViewModel;

  ///percent visible of page
  final double percentVisible;

  /// [MainAxisAligment]
  final MainAxisAlignment columnMainAxisAlignment;

  //Constructor
  const PageIntro({
    Key? key,
    required this.pageViewModel,
    this.percentVisible = 1.0,
    this.columnMainAxisAlignment = MainAxisAlignment.spaceAround,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Container(
      width: double.infinity,
      color: pageViewModel.pageColor,
      child: Opacity(
        //Opacity is used to create fade in effect
        opacity: percentVisible,
        child: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitPage(width, height)
              : __buildLandscapePage();
        }), //OrientationBuilder
      ),
    );
  }

  /// when device is Portrait place title, image and body in a column
  Widget _buildPortraitPage(double width, double height) {
    return Stack(
      /*   mainAxisAlignment: columnMainAxisAlignment,
      mainAxisSize: MainAxisSize.max,*/

      children: <Widget>[
        _ImagePageTransform(
          percentVisible: percentVisible,
          pageViewModel: pageViewModel,
          height: height * 0.6,
        ),
        Container(
          margin: EdgeInsets.only(top: height * 0.5),
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: pageViewModel.pageColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
              mainAxisAlignment: columnMainAxisAlignment,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 1,
                  child: _TitlePageTransform(
                    percentVisible: percentVisible,
                    pageViewModel: pageViewModel,
                  ),
                ), //Transform
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                  flex: 2,
                  child: _BodyPageTransform(
                    percentVisible: percentVisible,
                    pageViewModel: pageViewModel,
                  ),
                ),
              ] //Transform
              ),
        )
      ],
    );
  }

  /// if Device is Landscape reorder with row and column
  Widget __buildLandscapePage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: _ImagePageTransform(
            percentVisible: percentVisible,
            pageViewModel: pageViewModel,
            height: 200,
          ),
        ), //Transform

        Flexible(
          child: Column(
            mainAxisAlignment: columnMainAxisAlignment,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _TitlePageTransform(
                percentVisible: percentVisible,
                pageViewModel: pageViewModel,
              ), //Transform
              _BodyPageTransform(
                percentVisible: percentVisible,
                pageViewModel: pageViewModel,
              ), //Transform
            ],
          ), // Column
        ),
      ],
    );
  }
}

/// Body for the Page.
class _BodyPageTransform extends StatelessWidget {
  final double percentVisible;

  final PageViewModel pageViewModel;

  const _BodyPageTransform({
    Key? key,
    required this.percentVisible,
    required this.pageViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      //Used for vertical transformation
      transform:
          Matrix4.translationValues(0.0, 30.0 * (1 - percentVisible), 0.0),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 15.0,
          left: 10.0,
          right: 10.0,
        ),
        child: DefaultTextStyle.merge(
          style: pageViewModel.bodyTextStyle,
          textAlign: TextAlign.center,
          child: pageViewModel.body,
        ),
      ), //Padding
    );
  }
}

/// Main Image of the Page
class _ImagePageTransform extends StatelessWidget {
  final double percentVisible;
  final double height;
  final PageViewModel pageViewModel;

  const _ImagePageTransform({
    Key? key,
    required this.percentVisible,
    required this.pageViewModel,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      //Used for vertical transformation
      transform:
          Matrix4.translationValues(0.0, 50.0 * (1 - percentVisible), 0.0),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: pageViewModel.mainImage, //Loading main
      ), //Padding
    );
  }
}

/// Title for the Page
class _TitlePageTransform extends StatelessWidget {
  final double percentVisible;

  final PageViewModel pageViewModel;

  const _TitlePageTransform({
    Key? key,
    required this.percentVisible,
    required this.pageViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      //Used for vertical transformation
      transform:
          Matrix4.translationValues(0.0, 30.0 * (1 - percentVisible), 0.0),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 0.0,
          left: 10.0,
          right: 10.0,
        ),
        child: DefaultTextStyle.merge(
          style: pageViewModel.titleTextStyle,
          child: pageViewModel.title,
        ),
      ), //Padding
    );
  }
}
