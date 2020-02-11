import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_well/Controller/CustomerController/customerProfile.dart';
import 'c_drawer.dart';
import 'c_sub_category.dart';


class CustomerHome extends StatefulWidget {



  _MyHomePageState createState() => _MyHomePageState();
}

CustomerDataFromFireStore customerDataFromFireStore = new CustomerDataFromFireStore();


class _MyHomePageState extends State<CustomerHome> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<Category> category = CategoryList.getCategory();

  _MyHomePageState();

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  Widget _buildCatogeryList() {
    return Container(
      child: category.length > 0
          ? ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: category.length,
          itemBuilder: (BuildContext context, int index) {
            return CategoryCard(category: category[index]);
          }
      )
          : Center(child: Text('No Items')),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomerDrawerOnly(user: customerDataFromFireStore.getCustomerData(user.uid)),

      appBar: new AppBar(
        leading: new IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        title: new Text("Home",
          style: new TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),

      ),

      bottomNavigationBar: new BottomNavigationBar(items: [
        new BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text("Home"),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.search),
          title: new Text("Search"),
        )
      ]),


      body: _buildCatogeryList(),


    );

  }
}
class Category {
  final String title;
  final String subtitle;
  final String imageUrl;

  Category(this.title, this.subtitle, this.imageUrl);

}

class CategoryList {
  static List<Category> getCategory() {
    return [
      Category(
          'Electrical',
          'TV & home Applience',
          'Images/electrical.jpg'
      ),
      Category(
          'Mechanical',
          'TV & home Applience',
          'Images/mechanical.jpg'
      ),
      Category(
          'Painter',
          'TV & home Applience',
          'Images/painter.jpg'
      ),
      Category(
          'Plumber',
          'TV & home Applience',
          'Images/plumber.jpg'
      ),
      Category(
          'Cleaner',
          'TV & home Applience',
          'Images/cleaner-boy.png'
      ),
    ];
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({ this.category});


  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),

        child: Container(
            decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(
                  color: Colors.lightGreen,
                  width: 2.0

                )),


            child:
            ListTile(
              leading: Container(
                width: 100.0,
                height: 100.0,
                decoration: new BoxDecoration(
                    image: new DecorationImage(fit: BoxFit.fill, image:AssetImage( category.imageUrl))),
              ),

              title: Text(category.title,
                  style: TextStyle(color: Colors.black)),
              subtitle: Text(category.subtitle,
                  style: TextStyle(color: Colors.black54)),
              trailing: IconButton(icon: Icon(Icons.arrow_forward_ios, color: Colors.lightGreen), onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new SubJobs()));
              },),
            )
        )
    );
  }
}