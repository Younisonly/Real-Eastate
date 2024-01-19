import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:real_estate_assignment/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({super.key, required this.data});

  Map data;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool marked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.only(right: 20),
          height: 10,
          width: 10,
          decoration:
              BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
          child: IconButton(
            color: Colors.white,
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        title: Text(
          'تفاصيل الوحده',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 9,
                    offset: Offset(2, 4),
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.data['images'][1],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: -9,
                    left: 30,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          marked = !marked;
                          print(marked);
                        });
                      },
                      icon: Icon(
                        Icons.bookmark,
                        color: marked ? primaryColor : Colors.white,
                        size: 33,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 200,
                    left: 30,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.image_outlined,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'نوع الوحدة:  ${widget.data['type']}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  'الإجار السنوي',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'رقم الوحدة: ${widget.data['ID']}  ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${widget.data['annual price']}  ',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: widget.data['price currency'],
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ShapedTabBar(Data: widget.data),
            // Add other content here
          ],
        ),
      ),
    );
  }
}

class ShapedTabBar extends StatefulWidget {
  Map Data;

  ShapedTabBar({required this.Data});

  @override
  _ShapedTabBarState createState() => _ShapedTabBarState();
}

class _ShapedTabBarState extends State<ShapedTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;
  bool isMaximized = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animation?.addListener(_handleTabAnimation);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _handleTabAnimation() {
    final currentIndex = _tabController.animation?.value?.round();
    if (currentIndex != null) {
      setState(() {
        _selectedTabIndex = currentIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 514,
      child: ListView(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelPadding: EdgeInsets.zero,
              indicator: BoxDecoration(
                borderRadius: (_selectedTabIndex == 0)
                    ? BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20))
                    : (_selectedTabIndex == 1)
                        ? BorderRadius.circular(60)
                        : BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            topRight: Radius.circular(20)),
                color: primaryColor,
              ),
              labelColor: Colors.white,
              tabAlignment: TabAlignment.fill,
              unselectedLabelColor: Colors.black,
              onTap: _onTabTapped,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.diamond_outlined,
                        color: (_selectedTabIndex == 0)
                            ? Colors.white
                            : Colors.black54,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'المميزات',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: (_selectedTabIndex == 1)
                            ? Colors.white
                            : Colors.black54,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'الموقع',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.list_outlined,
                        color: (_selectedTabIndex == 2)
                            ? Colors.white
                            : Colors.black54,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'شروط الحجز',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 564,
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'بيت انيق للإجار',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/bed.png',
                            width: 25,
                            height: 25,
                          ),
                          SizedBox(width: 10),
                          Text('${widget.Data['rooms']} غرف '),
                          SizedBox(
                            width: 75,
                          ),
                          Image.asset(
                            'assets/images/hall.png',
                            width: 25,
                            height: 25,
                          ),
                          SizedBox(width: 10),
                          Text('${widget.Data['halls']} صالون '),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/bath.png',
                            width: 25,
                            height: 25,
                          ),
                          SizedBox(width: 10),
                          Text('${widget.Data['bathroom']} حمامات '),
                          SizedBox(
                            width: 50,
                          ),
                          SizedBox(width: 10),
                          (widget.Data['parking spot'] == "1")
                              ? Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/parking.png',
                                      width: 25,
                                      height: 25,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('موقف سيارات'),
                                  ],
                                )
                              : SizedBox(),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('${widget.Data['features']}')
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ألموقع',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('${widget.Data['location description']}'),
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width - 30,
                        height: 150,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Stack(
                          children: [
                            FlutterMap(
                              options: MapOptions(
                                initialCenter: LatLng(widget.Data['latitude'],
                                    widget.Data['longitude']),
                                initialZoom: 9.2,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  userAgentPackageName: 'com.example.app',
                                ),
                                RichAttributionWidget(
                                  attributions: [
                                    TextSourceAttribution(
                                      'OpenStreetMap contributors',
                                      onTap: () => launchUrl(Uri.parse(
                                          'https://openstreetmap.org/copyright')),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: FloatingActionButton(
                                backgroundColor: primaryColor,
                                onPressed: () {
                                  setState(() {
                                    isMaximized = !isMaximized;
                                  });
                                },
                                child: Icon(
                                  Icons.fullscreen,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'شروط الاستأجار',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text('${widget.Data['renting conditions']}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
