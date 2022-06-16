import 'dart:convert';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news/Articles.dart';
import 'package:news/category.dart';
import 'package:news/homePage.dart';
import 'package:news/live.dart';
import 'package:news/myCity.dart';

import 'NavigationDrawerWidget.dart';
import 'model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  List<NewsQueryModel> newsModelList = <NewsQueryModel>[];
  List<NewsQueryModel> newsModelListCarousel = <NewsQueryModel>[];
  List<String> navBarItem = ["Top News", "India", "World", "Finance", "Health"];
  int currentIndex = 0;
  final screens = [
    Homepage(),
    Articles(),
    MyCity(),
    Live(),
  ];

  bool isLoading = true;

  getNewsByQuery() async {
    String url =
        "https://newsapi.org/v2/everything?q=India&apiKey=9446b0c6b2ef4c16989531660f4692b2";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data["articles"].forEach((element) {
        NewsQueryModel newsQueryModel = new NewsQueryModel();
        newsQueryModel = NewsQueryModel.fromMap(element);
        newsModelList.add(newsQueryModel);
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  getNewsofIndia() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=9446b0c6b2ef4c16989531660f4692b2";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data["articles"].forEach((element) {
        NewsQueryModel newsQueryModel = new NewsQueryModel();
        newsQueryModel = NewsQueryModel.fromMap(element);
        newsModelListCarousel.add(newsQueryModel);
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsByQuery();
    getNewsofIndia();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text(
          "NEWS",
          textAlign: TextAlign.left,
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            //Search Wala Container

            padding: EdgeInsets.symmetric(horizontal: 8),
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(24)),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if ((searchController.text).replaceAll(" ", "") == "") {
                      print("Blank search");
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Category(Query: searchController.text)));
                    }
                  },
                  child: Container(
                    child: Icon(
                      Icons.search,
                      color: Colors.blueAccent,
                    ),
                    margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Category(Query: value)));
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Search..."),
                  ),
                )
              ],
            ),
          ),
          Container(
              height: 50,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: navBarItem.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Category(Query: navBarItem[index])));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text(navBarItem[index],
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    );
                  })),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: isLoading
                ? CircularProgressIndicator()
                : CarouselSlider(
                    options: CarouselOptions(
                        height: 200, autoPlay: true, enlargeCenterPage: true),
                    items: newsModelListCarousel.map((instance) {
                      return Builder(builder: (BuildContext context) {
                        return Container(
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Stack(children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        instance.newsImg,
                                        fit: BoxFit.fitHeight,
                                        width: double.infinity,
                                      )),
                                  Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient: LinearGradient(
                                                colors: [
                                                  Colors.black12.withOpacity(0),
                                                  Colors.black
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter)),
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 10),
                                            child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(
                                                  instance.newsHead,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))),
                                      )),
                                ])));
                      });
                    }).toList(),
                  ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(15, 25, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "LATEST NEWS ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: newsModelList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 1.0,
                            child: Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      newsModelList[index].newsImg,
                                      fit: BoxFit.fitHeight,
                                      height: 230,
                                      width: double.infinity,
                                    )),
                                Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            gradient: LinearGradient(
                                                colors: [
                                                  Colors.black12.withOpacity(0),
                                                  Colors.black
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter)),
                                        padding:
                                            EdgeInsets.fromLTRB(15, 15, 10, 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              newsModelList[index].newsHead,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              newsModelList[index]
                                                          .newsDes
                                                          .length >
                                                      50
                                                  ? "${newsModelList[index].newsDes.substring(0, 55)}...."
                                                  : newsModelList[index]
                                                      .newsDes,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            )
                                          ],
                                        )))
                              ],
                            )),
                      );
                    }),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Category(Query: "Technology")));
                          },
                          child: Text("SHOW MORE")),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red.shade900,
        unselectedItemColor: Colors.red.shade300,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.red,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.airplay,
              color: Colors.red,
            ),
            label: "Articles",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_balance,
              color: Colors.red,
            ),
            label: "My City",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_box,
              color: Colors.red,
            ),
            label: "Live",
          ),
        ],
      ),
    );
  }

  final List items = ["Testing1 ", "Testing2", "Testing3"];
}
