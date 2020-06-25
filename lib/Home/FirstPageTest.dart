import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Home/Model/product.dart';
import 'package:flutterapp/supporter/asymmetric_view.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import 'Model/product_repo.dart';

class FirstPage extends StatefulWidget{
  FirstPage();
  @override
  FirstPageState createState() => FirstPageState();
}
class FirstPageState extends State<FirstPage>{
  var logger = Logger();
  List<Card> _buildGridCard(BuildContext context){
    List<Product> products = ProductsRepository.loadProducts(Category.all);
    logger.i('Show product $products');
    if (products == null || products.isEmpty) {
      return const <Card>[];
    }
    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());
    return products.map((product){
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                // TODO: Adjust the box size (102)
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      product.name,
                      style: TextStyle(fontSize: 12),
                      maxLines: 1,
                    ),
                    Text(
                      formatter.format(product.price),
                      style: theme.textTheme.bodyText2,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
   return AsymmetricView(products: ProductsRepository.loadProducts(Category.all));
    /* Scaffold(
     appBar: AppBar(
       brightness: Brightness.dark,
       title: Text('TTKS Home page',
       style: TextStyle(color: Colors.white),),
       leading: IconButton(
         icon: Icon(Icons.menu),
         onPressed: (){

         },
       ),
       actions: <Widget>[
         IconButton(
           icon: Icon(Icons.search),
           onPressed: (){

           },
         ),
         IconButton(
           icon: Icon(Icons.tune, color: Colors.white,),
         )
       ],
     ),
     body:AsymmetricView(products: ProductsRepository.loadProducts(Category.all))
     *//*GridView.count(crossAxisCount: 2,
         padding: EdgeInsets.all(8),
         childAspectRatio: 8.0/9.0,
         children: _buildGridCard(context)
       //<Widget>[
       *//**//* Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 18.0 / 11.0,
                  child: Image.asset('assets/diamond.png'),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Title'),
                      SizedBox(height: 8,),
                      Text('SecondTitle')
                    ],
                  ),
                )
              ],
            ),
          )*//**//*
       // ],
     )*//*
   );*/
  }

}