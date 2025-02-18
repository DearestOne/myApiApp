import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myapiapp/week5/product_add.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myapiapp/week5/product_detail.dart';
import 'package:myapiapp/week5/product_edit.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _Apitest2State();
}

class _Apitest2State extends State<Product> {
  List<dynamic> products = [];

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2), // Adjust duration if needed
        behavior: SnackBarBehavior
            .floating, // Makes it appear above bottom navigation
      ),
    );
  }

  void _toDetailPage(
      BuildContext context, String name1, String description1, double price1) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetail(
          name: name1,
          description: description1,
          price: price1,
        ),
      ),
    );
  }

  void _toEditPage(BuildContext context, dynamic id1, String name1,
      String description1, double price1) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductEdit(
          id: id1,
          name: name1,
          description: description1,
          price: price1,
        ),
      ),
    );
    fetchData();
  }

  Future<void> deleteProduct(BuildContext context,dynamic idDelete) async {
    try {
      var response = await http
          .delete(Uri.parse("http://10.0.2.2:8001/products/$idDelete"));
      if (response.statusCode == 200) {
        print("Deleted Successful");
        _showSnackBar(context, 'Deleted');
      } else {
        throw Exception("Failed to delete products");
      }
    } catch (e) {
      print(e);
    }
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var response = await http.get(Uri.parse('http://10.0.2.2:8001/products'));
      if (response.statusCode == 200) {
        setState(() {
          products = jsonDecode(response.body);
        });
        print('${products.length} products fetched');
        print(products);
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Product', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
      ),
      body: SlidableAutoCloseBehavior(
        child: ListView.separated(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Slidable(
              endActionPane: ActionPane(
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      _toDetailPage(
                          context,
                          products[index]['name'],
                          products[index]['description'],
                          products[index]['price']);
                    },
                    backgroundColor: Colors.black45,
                    foregroundColor: Colors.white,
                    icon: Icons.more_horiz,
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      _toEditPage(
                          context,
                          products[index]['id'],
                          products[index]['name'],
                          products[index]['description'],
                          products[index]['price']);
                    },
                    backgroundColor: const Color.fromARGB(206, 255, 119, 0),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      showDialog(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text('Confirm delete?'),
                                        const SizedBox(height: 15),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            deleteProduct(context, products[index]['id']);
                                          },
                                          child: const Text('Delete!', style: TextStyle(color: Colors.redAccent),),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                      },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                  ),
                ],
              ),
              child: Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: Text('${index + 1}'),
                    title: Text(products[index]['name']),
                    subtitle: Text(products[index]['description']),
                    trailing: Text('${products[index]['price']}',
                        style: const TextStyle(color: Colors.green)),
                    onTap: () {},
                  )),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductPage()),
          );
          fetchData();
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
