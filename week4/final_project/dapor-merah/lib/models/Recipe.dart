List<Recipe> transactionFromJson(List recipes) =>
    List<Recipe>.from(recipes.map((x) => Recipe.fromJson(x)));

class Recipe {
  int id;
  String title;
  String image;
  String createdBy;
  List<String> categories;
  String description;
  List<String> ingredients;
  List<String> steps;

  Recipe(
      {this.id,
      this.title,
      this.image,
      this.createdBy,
      this.categories,
      this.description,
      this.ingredients,
      this.steps});

  Recipe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    createdBy = json['created_by'];
    categories = json['categories'].cast<String>();
    description = json['description'];
    ingredients = json['ingredients'].cast<String>();
    steps = json['steps'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['created_by'] = this.createdBy;
    data['categories'] = this.categories;
    data['description'] = this.description;
    data['ingredients'] = this.ingredients;
    data['steps'] = this.steps;
    return data;
  }
}
