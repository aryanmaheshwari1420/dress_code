import 'dart:convert';

import 'package:dress_code/model/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];

  @override
  void initState() {
    fetchDataFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder<Product>(
                future: fetchDataFromAPI(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  } else if (snapshot.hasData) {
                    final data = snapshot.data?.object;
                    if (data != null) {
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 150,
                            height: 150,
                            color: Colors.green,
                            margin: EdgeInsets.all(8.0),
                            child: Text("hello world"),  
                          );
                          // return Column(
                          //   children: [
                          //     Container(
                          //       height: MediaQuery.of(context).size.height * .3,
                          //       width: MediaQuery.of(context).size.width * 1,
                          //       child: ListView.builder(
                          //         scrollDirection: Axis.horizontal,
                          //         itemCount: snapshot.data!.object.length,
                          //         itemBuilder: (context, index2) {
                          //           return Container(
                          //             height:
                          //                 MediaQuery.of(context).size.height *
                          //                     .25,
                          //             width: MediaQuery.of(context).size.width *
                          //                 .5,
                          //             decoration: BoxDecoration(
                          //                 image: DecorationImage(
                          //                   fit: BoxFit.cover,
                          //                     image: NetworkImage(snapshot.data!
                          //                         .object[index].mediaUrl))),
                          //           );
                          //         },
                          //       ),
                          //     )
                          //   ],
                          // );
                        },
                      );
                    } else {
                      return Text("Data is null");
                    }
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return Text("Unknown error");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Product> fetchDataFromAPI() async {
    final url = Uri.parse(
        'https://storeapi.wekreta.in/api/v4/product/customer?id=0&secondaryKey=3d70712a-26fb-11ee-b277-029ff3b26cce&productName=&categoryName=serveware,kitchenware&subCategoryName=&subSubCategoryName=&brandName=&isFeatured=0&search=&currentPage=1&itemsPerPage=27&sortBy=createdDate&sortOrder=desc&isFetchListing=0&searchTag=&storeUuid=cb910d4a-bf60-11ed-814d-0252190a7100');

    final response = await http.get(url);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return Product.fromJson(data);
    } else {
      return Product.fromJson(data);
    }
  }
}
