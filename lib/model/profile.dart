class Profile {
  String name;
  String imagePath;
  String country;
  String city;
  int followers;
  int posts;
  int following;

  Profile({
    this.name,
    this.imagePath,
    this.country,
    this.city,
    this.followers,
    this.posts,
    this.following,
  });
}

final List<Profile> profiles = [
  Profile(
    imagePath: 'assets/images/profile1.jpg',
    name: 'Lori Perez',
    country: 'France',
    city: 'Nantes',
    followers: 869,
    posts: 135,
    following: 485,
  ),
  Profile(
    imagePath: 'assets/images/profile2.jpg',
    name: 'Lauren Turner',
    country: 'France',
    city: 'Paris',
    followers: 1500,
    posts: 350,
    following: 900,
  ),
  Profile(
    imagePath: 'assets/images/profile3.jpg',
    name: 'Carla Pitt',
    country: 'U.S.',
    city: 'Springfield, Missouri',
    followers: 17674,
    posts: 1244,
    following: 4913,
  ),
];
