import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  Future<void> createProduct() async {
    try {
      var response = await http.post(Uri.parse("http://10.0.2.2:8001/products"),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "name": _nameController.text,
            "description": _descriController.text,
            "price": double.parse(_priceController.text),
          }));
      if (response.statusCode == 201) {
        print("Product created successfully");
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
        title: const Text('Add Product'),
        backgroundColor: Colors.blue,
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
                        print(_nameController.text);
                        print(_descriController.text);
                        print('${_priceController.text}');
                        if (_formKey.currentState!.validate()){
                          createProduct();
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Add Product'),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
