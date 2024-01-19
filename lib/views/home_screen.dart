import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'dart:convert';

import 'DetailsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map data = {
    0: ['assets/images/villa.png', 'فيلا'],
    1: ['assets/images/villa (1).png', 'بيوت'],
    2: ['assets/images/appartment.png', 'شقق']
  };
  late List<Map>images;
  @override
  Future<void> initState() async {
    // TODO: implement initState
    super.initState();
    images =await GetImages();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30.0),
                ),
              ),
              title: const Text(
                'عقاراتي',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: primaryColor,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: Icon(Icons.menu),
                    color: Colors.white,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              )),
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20, left: 1, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 110,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(data.length, (index) {
                          return GestureDetector(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.grey.shade100,
                                  ),
                                  height: 60,
                                  width: 60,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(data[index][0]),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  data[index][1],
                                ),
                              ],
                            ),
                            onTap: () {
                              showSnackbar(
                                'لايوجد بيانات',
                                'لايوجد بيانات في هذه القائمة بعد',
                                Icons.info,
                              );
                            },
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "الاحدث: ",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                          onPressed: () {
                            showSnackbar('لايوجد بيانات',
                                'لايوجد بيانات في هذه القائمة بعد', Icons.info);
                          },
                          child: Container(
                            width: 50,
                            height: 25,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                                child: Text(
                              'المزيد',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: fetchDataFromAPI(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        print('Error: ${snapshot.error}');
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final apiDataList = snapshot.data!as Map<dynamic, dynamic>;
                        for (var image in images)
                        {
                          if (image['unit_ID']==apiDataList['ID']){
                            apiDataList['images'].add(image) ;
                          }
                        }
                        print(apiDataList);
                        return SizedBox(
                          height: 600,
                          child: ListView.builder(
                            itemCount: apiDataList.length,
                            itemBuilder: (context, index) {
                              final data = apiDataList[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(DetailsScreen(data:data));
                                },
                                child: Container(
                                  margin: EdgeInsets.all(15),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 9,
                                        offset: const Offset(0, 0),
                                        color: Colors.grey.shade400,
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                    ),
                                  ),
                                  height: 290,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 9,
                                              offset: const Offset(0, 0),
                                              color: Colors.grey.shade400,
                                            ),
                                          ],
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                30,
                                        child: Image.network(
                                          data['image'],
                                          scale: 18,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color: Colors.green,
                                            size: 15,
                                          ),
                                          SizedBox(width: 5),
                                          Text('${data['type']} للإجار '),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/bed.png',
                                            width: 15,
                                            height: 15,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text('${data['rooms']} غرف '),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(
                                            'assets/images/hall.png',
                                            width: 15,
                                            height: 15,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text('${data['halls']} صالون '),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(
                                            'assets/images/bath.png',
                                            width: 15,
                                            height: 15,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text('${data['bathroom']} حمامات '),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          (data['parking spot'] == "1")
                                              ? Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/parking.png',
                                                      width: 15,
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text('موقف سيارات'),
                                                  ],
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(data['location description']
                                          .toString()),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<List<Map<String, dynamic>>> fetchDataFromAPI() async {
    final url =
        'http://localhost/APIs/unitsAPI.php'; // Replace with your local API URL

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['data']);
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<List<Map<String, dynamic>>> GetImages() async {
    final url =
        'http://localhost/APIs/imageAPI.php'; // Replace with your local API URL

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['data']);
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
