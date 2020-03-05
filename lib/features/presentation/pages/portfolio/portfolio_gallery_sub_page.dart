import 'dart:convert';

import 'package:flutter/material.dart';

class PortfolioGallerySubPage extends StatelessWidget {
  const PortfolioGallerySubPage({Key key}) : super(key: key);

  //* BUILD METHOD FOR CUSTOMSCROLLVIEW WITH SLIVERS (SLIVERGRID)

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadImagePaths(context),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<String>> imagePathsSnapshot,
      ) {
        if (imagePathsSnapshot.connectionState == ConnectionState.done &&
            imagePathsSnapshot.hasData) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(10),
                sliver: _buildContent(imagePathsSnapshot.data),
              ),
            ],
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  //* SLIVERGRID

  SliverGrid _buildContent(List<String> imagePaths) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return _buildImageWidget(imagePaths[index]);
        },
        childCount: imagePaths.length,
      ),
    );
  }

  Future<List<String>> _loadImagePaths(BuildContext context) async {
    final String manifestContentJson =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContentJson);

    return manifestMap.keys
        .where((String key) => key.contains('assets/images/'))
        .toList();
  }

  Widget _buildImageWidget(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(2, 2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  //* BUILD METHOD FOR GRIDVIEW

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //     future: _loadImagePaths(context),
  //     builder: (
  //       BuildContext context,
  //       AsyncSnapshot<List<String>> imagePathsSnapshot,
  //     ) {
  //       if (imagePathsSnapshot.connectionState == ConnectionState.done &&
  //           imagePathsSnapshot.hasData) {
  //         return _buildContent(imagePathsSnapshot.data);
  //       }

  //       return Center(child: CircularProgressIndicator());
  //     },
  //   );
  // }

  //* GRIDVIEW CUSTOM EXTENT CHILDREN BUILDER DELEGATE

  // GridView _buildContent(List<String> imagePaths) {
  //   return GridView.custom(
  //     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
  //       maxCrossAxisExtent: 150,
  //       mainAxisSpacing: 10,
  //       crossAxisSpacing: 10,
  //     ),
  //     padding: const EdgeInsets.all(10),
  //     childrenDelegate: SliverChildBuilderDelegate(
  //       (BuildContext context, int index) {
  //         return _buildImageWidget(imagePaths[index]);
  //       },
  //       childCount: imagePaths.length,
  //     ),
  //   );
  // }

  //* GRIDVIEW CUSTOM EXTENT CHILDREN EXPLICIT DELEGATE

  // GridView _buildContent(List<String> imagePaths) {
  //   return GridView.custom(
  //     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
  //       maxCrossAxisExtent: 150,
  //       mainAxisSpacing: 10,
  //       crossAxisSpacing: 10,
  //     ),
  //     padding: const EdgeInsets.all(10),
  //     childrenDelegate: SliverChildListDelegate(
  //       imagePaths
  //           .map<Widget>((String imagePath) => _buildImageWidget(imagePath))
  //           .toList(),
  //     ),
  //   );
  // }

  //* GRIDVIEW BUILDER EXTENT DELEGATE

  // GridView _buildContent(List<String> imagePaths) {
  //   return GridView.builder(
  //     itemCount: imagePaths.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return _buildImageWidget(imagePaths[index]);
  //     },
  //     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
  //       maxCrossAxisExtent: 150,
  //       mainAxisSpacing: 10,
  //       crossAxisSpacing: 10,
  //     ),
  //     padding: const EdgeInsets.all(10),
  //   );
  // }

  //* GRIDVIEW EXPLICIT COUNT DELEGATE

  // GridView _buildContent(List<String> imagePaths) {
  //   return GridView(
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 5,
  //       mainAxisSpacing: 10,
  //       crossAxisSpacing: 10,
  //     ),
  //     padding: const EdgeInsets.all(10),
  //     children: imagePaths
  //         .map<Widget>((String imagePath) => _buildImageWidget(imagePath))
  //         .toList(),
  //   );
  // }

  //* GRIDVIEW EXPLICIT EXTENT DELEGATE

  // GridView _buildContent(List<String> imagePaths) {
  //   return GridView(
  //     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
  //       maxCrossAxisExtent: 150,
  //       mainAxisSpacing: 10,
  //       crossAxisSpacing: 10,
  //     ),
  //     padding: const EdgeInsets.all(10),
  //     children: imagePaths
  //         .map<Widget>((String imagePath) => _buildImageWidget(imagePath))
  //         .toList(),
  //   );
  // }

  //* GRIDVIEW.EXTENT EXPLICIT

  // GridView _buildContent(List<String> imagePaths) {
  //   return GridView.extent(
  //     maxCrossAxisExtent: 150,
  //     mainAxisSpacing: 10,
  //     crossAxisSpacing: 10,
  //     padding: const EdgeInsets.all(10),
  //     children: imagePaths
  //         .map<Widget>((String imagePath) => _buildImageWidget(imagePath))
  //         .toList(),
  //   );
  // }

  //* GRIDVIEW.COUNT EXPLICIT

  // GridView _buildContent(List<String> imagePaths) {
  //   return GridView.count(
  //     // scrollDirection: Axis.horizontal,
  //     crossAxisCount: 5,
  //     mainAxisSpacing: 10,
  //     crossAxisSpacing: 10,
  //     padding: const EdgeInsets.all(10),
  //     children: imagePaths
  //         .map<Widget>((String imagePath) => _buildImageWidget(imagePath))
  //         .toList(),
  //   );
  // }
}