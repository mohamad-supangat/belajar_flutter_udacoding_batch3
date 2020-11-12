import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import '../helpers/api.dart';
import '../components/BottomNavigationBars.dart';
import '../components/NoItems.dart';
import 'dart:async';

class KamusPage extends StatefulWidget {
  @override
  _KamusPageState createState() => _KamusPageState();
}

class _KamusPageState extends State<KamusPage> {
  List _kamus = [];
  bool _isLoading = false;
  bool _hasNext = true;
  String searchQuery;
  int page = 1;

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer _debounce;

  // app bar
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Kamus Kesehatan');

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
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _appBarTitle,
        actions: [
          FlatButton(
            onPressed: () {},
            child: IconButton(
              onPressed: () => _searchPressed(),
              color: Colors.white,
              icon: _searchIcon,
            ),
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
                      header: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.book_outlined),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _kamus[index]['title'],
                              style: TextStyle(
                                height: 1.5,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
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
                          ),
                        ],
                      ),
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
        callApi()
            .get('/kamus?page=${page++}&search=${searchQuery}')
            .then((response) {
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

  // fungsi ketika text field pencarian diedit maka akan melakukan pencarian
  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchQuery = _searchController.text;
      page = 1;
      _kamus = [];
      _getMoreData();
    });
  }

  // trigger fungsi ketika icon pencarian di appbar di tekan
  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close);
        this._appBarTitle = TextField(
          controller: _searchController,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            focusColor: Colors.white,
            hintText: 'Pencarian...',
            hintStyle: TextStyle(color: Colors.white),
          ),
        );
      } else {
        this._searchIcon = Icon(Icons.search);
        this._appBarTitle = Text('Kamus Kesehatan');
      }
    });
  }
}
