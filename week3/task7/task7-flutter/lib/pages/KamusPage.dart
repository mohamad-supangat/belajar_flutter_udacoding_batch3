import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import '../helpers/api.dart';
import '../components/BottomNavigationBars.dart';
import '../components/NoItems.dart';

class KamusPage extends StatefulWidget {
  @override
  _KamusPageState createState() => _KamusPageState();
}

class _KamusPageState extends State<KamusPage> {
  List _kamus = [];
  bool _isLoading = false;
  bool _hasNext = true;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Kamus Kesehatan'),
        actions: [
          FlatButton(
            onPressed: () {},
            child: Icon(Icons.search),
          )
        ],
      ),
      body: _generateList(),
      bottomNavigationBar: BottomNavigationBar(
        items: mainBottomNavigationBars(),
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/news');
          }
        },
      ),
    );
  }

  Widget _generateList() {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _kamus.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == _kamus.length) {
            if (!_isLoading && _kamus.length == 0) {
              return NoItems(
                message: 'Tidak ada kamus kesehatan yang dapat ditampilkan',
              );
            } else {
              return _buildProgressIndicator();
            }
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
              child: Container(
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: ExpandablePanel(
                      header: Text(
                        _kamus[index]['title'],
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      expanded: Column(
                        children: [
                          Divider(),
                          Text(
                            _kamus[index]['description'],
                            style: TextStyle(
                              fontSize: 11,
                              height: 1.5,
                            ),
                          )
                        ],
                      ),
                      tapHeaderToExpand: true,
                      hasIcon: false,
                    ),
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
    if (!_isLoading && _hasNext) {
      setState(() => _isLoading = true);
      try {
        callApi().get('/kamus').then((response) {
          List tempList = new List();
          for (int i = 0; i < response.data['data'].length; i++) {
            tempList.add(response.data['data'][i]);
          }

          setState(() {
            _hasNext = response.data['next_page_url'] != null ? true : false;
            _kamus.addAll(tempList);
            _isLoading = false;
          });
        }).catchError(() {
          setState(() => _isLoading = false);
        });
      } catch (e) {
        setState(() => _isLoading = false);
      }
    }
  }
}
