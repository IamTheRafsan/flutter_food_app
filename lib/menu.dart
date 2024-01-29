import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:food_app/styles.dart';

class FetchMenu extends StatefulWidget {

  var searchFood = " ";

  FetchMenu(String searchFood){

    this.searchFood = searchFood;

  }

  @override
  _FetchMenuState createState() => _FetchMenuState();

}

class _FetchMenuState extends State<FetchMenu> {
  List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
          Uri.parse('https://www.digitalrangersbd.com/app/ladidh/menu.php?f='+widget.searchFood));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        _items = List<Map<String, dynamic>>.from(data.map((item) => {
              'name': item['name'] ?? '',
              'description': item['description'] ?? '',
              'price': item['price'] ?? '',
              'image': item['image'] ?? '',
            }));

        setState(() {});
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              height: 350,
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> item =
                      _items[index]; // Access the item using _items[index]
                  return InkWell(
                    onTap: () {
                      // Handle item tap
                    },
                    child: Container(
                      width: 290,
                      margin: EdgeInsets.only(
                        left: 15,
                        right: 5,
                        top: 5,
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.network(
                              item['image'],
                              height: 250,
                              width: MediaQuery.of(context).size.width / 1.4,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['name'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Fast Food",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black45,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: styles.primaryColor,
                                            size: 20,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "4.7",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "(947)",
                                            style:
                                                TextStyle(color: Colors.black45),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: styles.primaryColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          "${item['price']}.tk",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
