import 'package:flutter/material.dart';
import 'package:DaporMerah/models/Recipe.dart';

class DetailRecipePage extends StatefulWidget {
  final Recipe recipe;

  DetailRecipePage({
    @required this.recipe,
  });
  @override
  _DetailRecipePageState createState() => _DetailRecipePageState();
}

class _DetailRecipePageState extends State<DetailRecipePage> {
  final double expandedHeight = 200;
  final double roundedContainerHeight = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.share_rounded),
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                actions: [
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                ],
                expandedHeight: 300,
                stretch: true,
                stretchTriggerOffset: 150,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                    StretchMode.fadeTitle,
                  ],
                  background: () {
                    if (widget.recipe.image == null) {
                      return SizedBox();
                    } else {
                      return Image.network(
                        widget.recipe.image,
                        fit: BoxFit.cover,
                      );
                    }
                  }(),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.recipe.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 15),
                      CardWithHeaderIcon(
                        icon: Icons.info_outline,
                        iconColor: Colors.blue,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            top: 15,
                            right: 20,
                            bottom: 15,
                          ),
                          child: Text(widget.recipe.description),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CardWithHeaderIcon(
                        icon: Icons.folder,
                        iconColor: Colors.blueGrey,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            top: 15,
                            right: 20,
                            bottom: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Bahan - bahan',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 0),
                              Column(
                                children: widget.recipe.ingredients
                                    .map(
                                      (ingredient) => Row(
                                        children: [
                                          Icon(Icons.arrow_right),
                                          Expanded(
                                            child: Text(ingredient),
                                          )
                                        ],
                                      ),
                                    )
                                    .toList(),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      CardWithHeaderIcon(
                        icon: Icons.book,
                        iconColor: Colors.lightBlue,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            top: 15,
                            right: 20,
                            bottom: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Langkah - langkah',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 0),
                              Column(
                                children: widget.recipe.steps
                                    .map(
                                      (step) => Row(
                                        children: [
                                          Icon(Icons.arrow_right),
                                          Expanded(
                                            child: Text(step),
                                          )
                                        ],
                                      ),
                                    )
                                    .toList(),
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          SizedBox(width: 10),
                          Text(
                            'Bagikan dengan :',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Colors.blue,
                              textColor: Colors.white,
                              onPressed: () {},
                              child: Text('Facebook'),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Colors.red,
                              textColor: Colors.white,
                              onPressed: () {},
                              child: Text('Google'),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CardWithHeaderIcon extends StatelessWidget {
  final IconData icon;
  final Widget child;
  final MaterialColor iconColor;

  CardWithHeaderIcon({
    @required this.icon,
    @required this.child,
    this.iconColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -15,
            left: 15,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: iconColor,
              ),
              width: 40,
              height: 40,
              child: Center(
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: child,
          )
        ],
      ),
    );
  }
}
