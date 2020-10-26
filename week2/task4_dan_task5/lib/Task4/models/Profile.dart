class Profile {
  String name;
  String username;
  String email;
  String profileImage;
  String password;

  Profile(
      {this.name, this.username, this.email, this.profileImage, this.password});

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    email = json['email'];
    profileImage = json['profile_image'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['password'] = this.password;
    return data;
  }
}
