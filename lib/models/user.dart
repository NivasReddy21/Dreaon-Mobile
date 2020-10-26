class User {
  String id;
  String name;
  String username;
  String photo;
  int followers;
  int following;
  int likes;
  bool isFollowing;
  List posts;
  String location;
  String email;

  User(
      {this.id,
      this.name,
      this.username,
      this.photo,
      this.location,
      this.email,
      this.followers,
      this.following,
      this.likes,
      this.isFollowing = false,
      this.posts});

  factory User.fromMap(Map data) {
    return User(
        id: data["uid"],
        name: data["userName"],
        username: data["userName"],
        followers: data["followers"],
        following: data["following"],
        email: data["email"],
        location: "",
        likes: 0,
        photo: data["profile_url"],
        posts: data["posts"]);
  }
}
