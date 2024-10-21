import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HompageInstagramPos extends StatefulWidget {
  const HompageInstagramPos({super.key});

  @override
  State<HompageInstagramPos> createState() => _HompageInstagramPosState();
}

class _HompageInstagramPosState extends State<HompageInstagramPos> {
  List<a> post = [
    a(
      images: [
        "images/1.jpg",
        "images/2.jpg",
        "images/3.jpg",
      ],
      nom: "joshua_l",
      commit:
          "Liked by craig_love and 44,686 others\n The game in Japan was amazing and I want to share some photos",
      location: "Tokyo, Japan",
    ),
  ];

  int _currentIndex = 0; // Carousel index

  Widget postmap(a postItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile and location
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("images/profile.jpg"),
                radius: 25,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    postItem.nom!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(postItem.location!),
                ],
              ),
            ],
          ),
        ),
        // Carousel Slider
        Stack(
          alignment: Alignment.topCenter,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 400.0,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: postItem.images!.map((image) {
                return Container(
                  width: double.infinity,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                );
              }).toList(),
            ),
            // Image index in top right
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "${_currentIndex + 1}/${postItem.images!.length}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        // Dots indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: postItem.images!.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => setState(() {
                _currentIndex = entry.key;
              }),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? Colors.blueAccent
                      : Colors.grey,
                ),
              ),
            );
          }).toList(),
        ),
        // Like and caption section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                postItem.commit!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: postItem.nom!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: ' '),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: post.length,
      itemBuilder: (context, index) {
        return postmap(post[index]);
      },
    );
  }
}

class a {
  String? nom;
  String? commit;
  String? location;
  List<String>? images;
  a({this.nom, this.commit, this.location, this.images});
}
