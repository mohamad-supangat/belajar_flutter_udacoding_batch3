import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import '../models/Photo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Photo> _photos = new List();
  int _page = 1;
  bool _isLoading = false;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPhotos();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        _loadMore();
      }
    });
  }

  _getPhotos() {
    setState(() {
      _isLoading = true;
    });
    http
        .get('https://picsum.photos/v2/list?limit=10&page=${_page}')
        .then((response) {
      final result = json.decode(response.body);
      result.forEach((photo) {
        setState(() => _photos.add(Photo.fromJson(photo)));
      });
      setState(() => _isLoading = false);
    });
  }

  _loadMore() {
    setState(() => _page++);
    _getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hantam',
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
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            ResponsiveGridRow(
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
                      onTap: () {},
                      child: Container(
                        height: 200,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Stack(
                            children: [
                              Image.network(photo.downloadUrl),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 20,
            ),
            Visibility(
              visible: _isLoading,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      Text('sedang mengambil wallpaper'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
