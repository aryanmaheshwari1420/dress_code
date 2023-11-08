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
  late Future<Product> productData;

  @override
  void initState() {
    super.initState();
    productData = fetchDataFromAPI();
  }

  Future<Product> fetchDataFromAPI() async {
    final url = Uri.parse(
        'https://storeapi.wekreta.in/api/v4/product/customer?id=0&secondaryKey=3d70712a-26fb-11ee-b277-029ff3b26cce&productName=&categoryName=serveware,kitchenware&subCategoryName=&subSubCategoryName=&brandName=&isFeatured=0&search=&currentPage=1&itemsPerPage=27&sortBy=createdDate&sortOrder=desc&isFetchListing=0&searchTag=&storeUuid=cb910d4a-bf60-11ed-814d-0252190a7100');

    final response = await http.get(url);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return Product.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: FutureBuilder<Product>(
        future: productData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data?.object;
            if (data != null) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    height: 200,
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          height: 100, // Adjust the height as needed
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(data[index].mediaUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: 80, // Adjust the height as needed
                          color: Colors
                              .white, // Background color for the text area
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                data[index]
                                    .category[0]
                                    .name, // Access the first category's name
                              ),
                              Text(
                                data[index].variants[0].sellingPrice.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text("Data is null"));
            }
          } else {
            return Center(child: Text("Unknown error"));
          }
        },
      ),
    );
  }
}
