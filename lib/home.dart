import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var newslist = ["General", "Sports", "International"];
    List<String> navBarItem = ["TopNews", "India", "Finance", "World"];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("News Application"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            //Search Container

            padding: EdgeInsets.symmetric(horizontal: 8),

            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if ((searchController.text).replaceAll(" ", " ") == "") {
                      print("Blank Search");
                    } else {}
                  },
                  child: Container(
                    child: Icon(Icons.search),
                    margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                  ),
                ),
                Expanded(
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      print("value");
                    },
                    controller: searchController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Search News"),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 60,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: navBarItem.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      print(navBarItem[index]);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        navBarItem[index],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
