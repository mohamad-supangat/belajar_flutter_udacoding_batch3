import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/Photo.dart';

class DetailPage extends StatefulWidget {
  final Photo photo;
  DetailPage(this.photo);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
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
                      Text('Di Upload Oleh: '),
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
          )
        ],
      ),
    );
  }
}
