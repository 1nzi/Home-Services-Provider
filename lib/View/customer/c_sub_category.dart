import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../services/panting_service.dart';
import '../services/plumbing_services.dart';
import 'c_drawer.dart';
import 'c_select_subCategory.dart';

class SubJob extends StatefulWidget {
  _MySubCategoryPageState createState() => _MySubCategoryPageState();
}

class _MySubCategoryPageState extends State<SubJob> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<SubCategory> _subCategory = SubCategoryList.getCatogery();

  Widget _buildSubCategoryList() {
    return Container(
      child: _subCategory.length > 0
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _subCategory.length,
              itemBuilder: (BuildContext context, int index) {
                return SubCategoryCard(
                  subCategory: _subCategory[index],
                );
              },
            )
          : Center(child: Text('No Items')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomerDrawerOnly(),
      appBar: new AppBar(
        leading: new IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        title: new Text(
          "SubCategory",
          style: new TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: new BottomNavigationBar(items: [
        new BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text('Home'),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.search),
          title: new Text("Search"),
        )
      ]),
      body: _buildSubCategoryList(),
    );
  }
}

class SubCategory {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String id;

  SubCategory(this.title, this.subtitle, this.imageUrl, this.id);
}

class SubCategoryList {
  static List<SubCategory> getCatogery() {
    return [
      SubCategory('Electrical', 'home Electric Applience...',
          'Images/electric.jpg', '1'),
      SubCategory('Ac Technician', 'Ac Repair, gas filling...',
          'Images/AcTech.jpg', '2'),
      SubCategory('Fridge Technician', 'Fridge Repair, gas filling...',
          'Images/fridgeTech.jpg', '3'),
      SubCategory(
          'TV Technician', 'TV , LED, Repair...', 'Images/tvTech.jpg', '4'),
    ];
  }
}

class SubCategoryCard extends StatelessWidget {
  final SubCategory subCategory;

  const SubCategoryCard({this.subCategory});

  @override
  Widget build(BuildContext cxt) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: InkWell(
          onTap: () {
//            Navigator.pop(
//                cxt,
//                new MaterialPageRoute(builder: (context) => new SubJob()));
            if (subCategory.id == '1') {
              Navigator.push(
                  cxt,
                  new MaterialPageRoute(
                      builder: (context) => new SelectSubCategory()));
            } else if (subCategory.id == '2') {
              Navigator.push(
                  cxt,
                  new MaterialPageRoute(
                      builder: (context) => new SelectSubCategory()));
            } else if (subCategory.id == '3') {
              Navigator.push(
                  cxt,
                  new MaterialPageRoute(
                      builder: (context) => new PlumbingServices()));
            } else if (subCategory.id == '4') {
              Navigator.push(
                  cxt,
                  new MaterialPageRoute(
                      builder: (context) => new PaintingService()));
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.asset(subCategory.imageUrl,
                    height: 150, fit: BoxFit.fill),
              ),
              ListTile(
                title: Text(
                  subCategory.title,
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(subCategory.subtitle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
