import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';
import 'package:dio/dio.dart';

import '../pages/DetailPage.dart';
import '../models/Category.dart';
import '../models/Photo.dart';
import '../db/categorys.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Photo> _photos;
  int _page = 1;
  int _perPage = 10;
  bool _isLastPage = false;
  String _searchQuery;
  String _categoryKey;

  @override
  void initState() {
    _fetchPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Uda',
              style: TextStyle(
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              ' Wallpaper',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          generateCategorys(),
          generateGalleryWallpaper(),
        ],
      ),
    );
  }

  Widget generateCategorys() {
    return Container(
      height: 50,
      child: ListView.builder(
        itemCount: categorys.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: RaisedButton(
              color: _categoryKey == categorys[index].key
                  ? Colors.blue
                  : Colors.blueGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              onPressed: () {
                _categoryClick(categorys[index]);
              },
              child: Text(categorys[index].text),
            ),
          );
        },
      ),
    );
  }

  Widget generateGalleryWallpaper() {
    if (_photos == null) {
      return Expanded(
        child: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return Expanded(
        child: RefreshLoadmore(
          onRefresh: _refreshPhotos,
          onLoadmore: _fetchPhotos,
          noMoreText: 'tiak ada foto lain di temukan',
          isLastPage: _isLastPage,
          child: ResponsiveGridRow(
            children: _photos.map((photo) {
              return ResponsiveGridCol(
                xs: 6,
                sm: 6,
                md: 4,
                lg: 3,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 20,
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(photo),
                        ),
                      );
                    },
                    child: Container(
                      height: 200,
                      child: Image.network(
                        photo.webformatURL,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }
  }

  // trigger function kettika category di klik
  Future _categoryClick(Category category) async {
    if (_categoryKey == category.key) {
      setState(() => _categoryKey = null);
    } else {
      setState(() => _categoryKey = category.key);
    }
    await _refreshPhotos();
  }

  // trigger Function untuk refresh data foto
  Future _refreshPhotos() async {
    _page = 1;
    setState(() => _photos = null);
    await _fetchPhotos();
  }

  // trigger function untuk mendapatkan data foto
  Future _fetchPhotos() async {
    try {
      Dio dio = new Dio();
      Response response = await dio.get(
        'https://pixabay.com/api/',
        queryParameters: {
          'key': '19096336-746dbb9b8c592fb1e7f8a66b5',
          'q': _searchQuery,
          'per_page': _perPage,
          'page': _page++,
          'lang': 'id',
          'category': _categoryKey,
        },
      );

      // hitung halaman page terahir dan cek untuk last page
      int lastPage = (response.data['total'] / _perPage).ceil();
      _isLastPage = lastPage == _page;

      // generate temporary list untuk memasukan data json ke model
      List<Photo> _tmpPhotos = new List();
      response.data['hits']
          .forEach((photo) => _tmpPhotos.add(Photo.fromJson(photo)));

      // pastikan _photos tidak null
      if (_photos == null) _photos = new List();

      setState(() => _photos.addAll(_tmpPhotos));
    } catch (e) {
      print(e);
    }
  }
}
