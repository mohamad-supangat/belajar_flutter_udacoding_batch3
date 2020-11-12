import 'package:flutter/material.dart';
import '../helpers/api.dart';
import '../components/BottomNavigationBars.dart';
import '../components/NoItems.dart';
import '../pages/ReadNewsPage.dart';
import '../helpers/auth.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  List _news = [];
  bool _isLoading = false;
  bool _hasNext = true;
  int _page = 1;
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

  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Berita Kesehatan'),
      ),
      body: _generateList(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) async {
          if (index == 1) {
            Navigator.pushReplacementNamed(context, '/kamus');
          } else if (index == 2) {
            String token = await Auth().token();
            Navigator.pushNamed(
                context, token != null ? '/myProfile' : '/login');
          }
        },
        currentIndex: 0,
        items: mainBottomNavigationBars(),
      ),
    );
  }

  Widget _generateList() {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _news.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == _news.length) {
            if (_isLoading) {
              return _buildProgressIndicator();
            } else {
              return Visibility(
                visible: _news.length == 0,
                child: NoItems(
                  message: 'Tidak ada berita yang dapat ditampikan',
                ),
              );
            }
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
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReadNewsPage(_news[index]),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          color: Colors.grey[300],
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      Icon(Icons.account_circle_sharp,
                                          size: 15),
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
              ),
            );
          }
        },
        controller: _scrollController,
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _getMoreData() {
    if (!_isLoading && _hasNext) {
      setState(() => _isLoading);
      try {
        callApi().get('/news?page=${_page++}').then((response) {
          List tempList = new List();
          for (int i = 0; i < response.data['data'].length; i++) {
            tempList.add(response.data['data'][i]);
          }

          setState(() {
            _hasNext = response.data['next_page_url'] != null ? true : false;
            _news.addAll(tempList);
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
