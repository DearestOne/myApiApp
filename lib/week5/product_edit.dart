import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ProductEdit extends StatefulWidget {
  final dynamic id;
  final String name;
  final String description;
  final double price;

  const ProductEdit({
    super.key,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  @override
  State<ProductEdit> createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _descriController.text = widget.description;
    _priceController.text = "${widget.price}";
  }

  Future<void> updateProduct(BuildContext context, dynamic idUpdate) async {
    try {
      var response =
          await http.put(Uri.parse("http://10.0.2.2:8001/products/$idUpdate"),
              headers: {
                "Content-Type": "application/json",
              },
              body: jsonEncode({
                "name": _nameController.text,
                "description": _descriController.text,
                "price": double.parse(_priceController.text)
              }));
      if (response.statusCode == 200) {
        print("update complete");
        Navigator.pop(context);
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        backgroundColor: const Color.fromARGB(206, 255, 119, 0),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text('Product Name'),
          const SizedBox(height: 10),
          Form(
              key: _formKey,
              child: Container(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter product name',
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Product Description'),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _descriController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter product description',
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Product Price'),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _priceController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter product price',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter product price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid decimal number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
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
                                        const Text('Confirm edit?'),
                                        const SizedBox(height: 15),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            if (_formKey.currentState!
                                                .validate()) {
                                              updateProduct(context, widget.id);
                                            }
                                          },
                                          child: const Text('Edit', style: TextStyle(color: Colors.redAccent),),
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
                      child: const Text('Edit Product'),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
