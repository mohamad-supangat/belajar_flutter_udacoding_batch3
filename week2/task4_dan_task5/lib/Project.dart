class Project {
  String image;
  String judul;
  String routeName;

  Project({this.image, this.judul, this.routeName});

  Project.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    judul = json['judul'];
    routeName = json['routeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['judul'] = this.judul;
    data['routeName'] = this.routeName;
    return data;
  }
}
