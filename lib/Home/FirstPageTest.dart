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
  int counter = 0;
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

   return Scaffold(
     appBar: AppBar(
       title: Text('TTKS HOme'),
       actions: <Widget>[
         new Stack(
           children: <Widget>[
             new IconButton(icon: Icon(Icons.notifications), onPressed: () {
               setState(() {
                 counter = 0;
               });
             }),
             counter != 0 ? new Positioned(
               right: 11,
               top: 11,
               child: new Container(
                 padding: EdgeInsets.all(2),
                 decoration: new BoxDecoration(
                   color: Colors.red,
                   borderRadius: BorderRadius.circular(6),
                 ),
                 constraints: BoxConstraints(
                   minWidth: 14,
                   minHeight: 14,
                 ),
                 child: Text(
                   '$counter',
                   style: TextStyle(
                     color: Colors.white,
                     fontSize: 8,
                   ),
                   textAlign: TextAlign.center,
                 ),
               ),
             ) : new Container()
           ],
         ),
       ],
     ),
     body:AsymmetricView(products: ProductsRepository.loadProducts(Category.all)) ,
     floatingActionButton: FloatingActionButton(onPressed: () {
       print("Increment Counter$counter");
       setState(() {
         counter++;
       });
     }, child: Icon(Icons.add),),
   );
  }

}