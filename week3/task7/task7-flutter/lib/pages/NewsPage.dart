import 'package:flutter/material.dart';
import '../helpers/api.dart';
import 'dart:developer';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  List _news = [];
  bool _isLoading = false;
  bool _hasNext = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    this._getMoreData();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _news.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == _news.length) {
            return _buildProgressIndicator();
          } else {
            return Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.network(_news[index]['image']),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.date_range, size: 15),
                                    Text(_news[index]['create_date'] == null
                                        ? ''
                                        : _news[index]['create_date']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.account_circle_sharp, size: 15),
                                    Text(_news[index]['user']),
                                  ],
                                ),
                              ],
                            ),
                            Divider(),
                            Text(
                              _news[index]['title'],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
        controller: _scrollController,
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: _isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  void _getMoreData() {
    if (!_isLoading) {
      setState(() => _isLoading = true);
      callApi().get('/news').then((response) {
        List tempList = new List();
        for (int i = 0; i < response.data['data'].length; i++) {
          tempList.add(response.data['data'][i]);
        }

        setState(() {
          _isLoading = false;
          _hasNext = response.data['next_page_url'] != null ? true : false;
          _news.addAll(tempList);
        });
      });
    }
  }
}
