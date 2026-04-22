import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List data = [];
  bool isLoading = true;

  Future<void> ambilData() async {
    var response = await http.get(Uri.parse('https://dummyjson.com/products'));

    // var hasil = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        var hasil = jsonDecode(response.body);
        data = hasil["products"];
        isLoading = false;
      });
    } else {
      print("Gagal");
    }
  }

  @override
  void initState() {
    super.initState();
    ambilData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Icon(Icons.shopping_bag, color: Colors.grey.shade400),
        actions: [
          Text(
            "Toko Sejahtera",
            style: GoogleFonts.albertSans(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              height: 0.9,
              letterSpacing: -0.1,
              color: Colors.grey.shade500,
            ),
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 15),
        backgroundColor: Colors.grey.shade200,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                width: double.infinity,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  // runSpacing: 10,
                  runAlignment: WrapAlignment.spaceEvenly,
                  alignment: WrapAlignment.spaceEvenly,
                  runSpacing: 10,
                  direction: Axis.horizontal,
                  children: data.take(10).map((item) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        spacing: 5,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Stack(
                              children: [
                                Image.network(
                                  item['images'][0],
                                  fit: BoxFit.contain,
                                  // width: 150,
                                  // height: 150,
                                ),
                                Positioned(
                                  bottom: 5,
                                  left: 5,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: 2.5,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.blueGrey.shade100,
                                    ),
                                    child: Text(
                                      "${item['stock']} in stock!",
                                      style: GoogleFonts.albertSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        // height: 0.9,
                                        letterSpacing: -0.2,
                                        // color: Colors.red.shade400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Text(
                              item["title"],
                              style: GoogleFonts.albertSans(
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0,
                                height: 1.3,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Row(
                            spacing: 10,
                            children: [
                              Row(
                                children: List.generate(
                                  item['rating'].round(),
                                  (index) => Icon(
                                    Icons.star,
                                    size: 20,
                                    color: Colors.yellow.shade700,
                                  ),
                                ),
                              ),
                              Text(item['reviews'].length.toString()),
                            ],
                          ),
                          Row(
                            spacing: 5,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['price'].toString(),
                                style: GoogleFonts.albertSans(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w600,
                                  height: 1,
                                  letterSpacing: -1,
                                ),
                              ),
                              Text(
                                "\$",
                                style: GoogleFonts.albertSans(
                                  fontSize: 18,
                                  // fontWeight: FontWeight.w800,
                                  height: 0.9,
                                  letterSpacing: -1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
    );
  }
}
