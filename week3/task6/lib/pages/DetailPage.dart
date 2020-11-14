import 'package:flutter/material.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../models/Photo.dart';

class DetailPage extends StatefulWidget {
  final Photo photo;
  DetailPage(this.photo);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String res;
  bool downloading = false;
  String home = "Home Screen",
      lock = "Lock Screen",
      both = "Both Screen",
      system = "System";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _setAsWallpaper,
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.format_paint,
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          GestureDetector(
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Image(
                    image: NetworkImage(widget.photo.webformatURL),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(10),
              color: Color.fromRGBO(0, 0, 0, 0.45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Di upload oleh: '),
                      Text(
                        '@${widget.photo.user}',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text('tags: '),
                      Text(
                        widget.photo.tags,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.favorite_border),
                          SizedBox(width: 10),
                          Text(widget.photo.likes.toString()),
                        ],
                      ),
                      SizedBox(width: 20),
                      Row(
                        children: [
                          Icon(Icons.visibility_outlined),
                          SizedBox(width: 10),
                          Text(widget.photo.views.toString()),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: downloading,
            child: Dialog(
              child: Container(
                width: 200.0,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(height: 20.0),
                    Container(
                      child: Text(
                        "Mendownload foto dan menerapkan wallpaper",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _setAsWallpaper() async {
    setState(() => downloading = true);
    int location = WallpaperManager.HOME_SCREEN;
    var file =
        await DefaultCacheManager().getSingleFile(widget.photo.largeImageURL);

    final String result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);

    setState(() => downloading = false);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(result == 'Wallpaper set'
            ? 'Wallpaper diterapkan'
            : 'Gagal Menerapkan wallpaper'),
        actions: [
          FlatButton(
            child: Text('Tutup'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
