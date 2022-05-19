import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifewallpoc/constant/customcolor.dart';
import 'package:lifewallpoc/constant/string.dart';
import 'package:lifewallpoc/model/ProductListResponse.dart';
import 'package:lifewallpoc/provider/dataprodivider.dart';
import 'package:lifewallpoc/screens/login.dart';
import 'package:lifewallpoc/widget/primarybutton.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';


class AllServices extends StatefulWidget {

  @override
  AllServicesState createState() => AllServicesState();

}


List<ProductListResponse> _products = [];
int rowsPerPage = 10;
List newList = [];

class AllServicesState extends State<AllServices> {
  static const double dataPagerHeight = 60.0;
  bool showLoadingIndicator = false;
  double pageCount = 0;
  bool showindicate1 = true;

  @override
  void initState() {
    super.initState();
    _getdata(context);
  }

  void rebuildList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SafeArea(
          bottom: true,
          top: false,
          child: Scaffold(
            body: showindicate1 == true
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  showindicate1 = true;
                  _getdata(context);
                });
              },
              child: LayoutBuilder(builder: (context, constraint) {
                return Column(
                  children: [
                    Container(
                      height: constraint.maxHeight - dataPagerHeight,
                      child: loadListView(),
                    ),
                    Container(
                      height: dataPagerHeight,
                      child: SfDataPagerTheme(
                          data: SfDataPagerThemeData(
                            itemBorderRadius: BorderRadius.circular(5),
                          ),
                          child: SfDataPager(
                              pageCount: pageCount,
                              onPageNavigationStart: (pageIndex) {
                                setState(() {
                                  showLoadingIndicator = true;
                                });
                              },
                              onPageNavigationEnd: (pageIndex) {
                                setState(() {
                                  showLoadingIndicator = false;
                                });
                              },
                              delegate: CustomSliverChildBuilderDelegate(
                                  indexBuilder)
                                ..addListener(rebuildList))),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      );
  }

  Widget loadListView() {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (_products.isNotEmpty) {
        stackChildren.add(ListView.custom(
            childrenDelegate: CustomSliverChildBuilderDelegate(indexBuilder)));
      }

      double device_width = MediaQuery.of(context).size.width;
      double device_height = MediaQuery.of(context).size.height;

      if (showLoadingIndicator) {
        stackChildren.add(Container(
          color: Colors.black12,
          width: device_width,
          height: device_height,
          child: const Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          ),
        ));
      }
      return stackChildren;
    }

    return Stack(
      children: _getChildren(),
    );
  }

  Widget indexBuilder(BuildContext context, int index) {
    //final ProductListResponse data = _paginatedProductData[index];
    //   final data = _paginatedProductData[index];
    //int len = newList.length;
    var _byteImage;
    var data;
    var price;

    if (index < 10) {
      data = newList[index];
      if (data.imageBase64 == " " ||
          data.imageBase64 == "" ||
          data.imageBase64.toString().isEmpty) {
        _byteImage = "";
      } else {
        _byteImage = Base64Decoder().convert(data.imageBase64);
      }

      if(price == 0) {
        price = 0;
      } else {
        price = data.price;
      }


    }

    double device_width = MediaQuery.of(context).size.width;
    double device_height = MediaQuery.of(context).size.height;

    return index < 10
        ? Container(
      width: device_width,
      height: device_height * 0.11,
      padding: EdgeInsets.fromLTRB(10, 3, 5, 3),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: _byteImage == ""
                      ? Image.asset(
                    "asset/image/no_img.jpg",
                    width: device_width * 0.3,
                    height: device_height * 0.11,
                    fit: BoxFit.fitWidth,
                  )
                      : Image.memory(
                    _byteImage,
                    width: device_width * 0.3,
                    height: device_height * 0.11,
                    fit: BoxFit.fitWidth,
                  ))),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: device_width * 0.6,
                child: Text(data.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        fontSize: 15)),
              ),
              Container(
                width: device_width * 0.6,
                child: Text("Rs. " + price.toString() ?? "0.0",
                    style:
                    TextStyle(color: Colors.black87, fontSize: 16)),
              ),
            ],
          ),
        ],
      ),
    )
        : SizedBox();
  }

  Future _getdata(BuildContext context) async {
    return await Provider.of<Dataprovider>(context, listen: false)
        .getproduct("rohan", "1234")
        .then((value) {
      _products = [];
      if (value.result.productsList.length != null) {
        setState(() {
          _products.add(value);
          showindicate1 = false;
          pageCount =
              (value.result.productsList.length / rowsPerPage).ceilToDouble();
        });
      } else {
        setState(() {
          showindicate1 = false;
        });
      }
    });
  }

  Future updateData(BuildContext context) {
    CustomSliverChildBuilderDelegate(indexBuilder);
    showindicate1 = false;
  }




}

class CustomSliverChildBuilderDelegate extends SliverChildBuilderDelegate
    with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegate(builder) : super(builder);


  @override
  int get childCount => newList.length;

  @override
  int get rowCount => _products[0].result.productsList.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    final length = _products[0].result.productsList.length;
    final int _startIndex = newPageIndex * rowsPerPage;
    int _endIndex = _startIndex + rowsPerPage;
    if (_endIndex > length) {
      _endIndex = length;
    }

    newList.length = 0;
    if (_startIndex < length && _endIndex <= length) {
      /*  for(var i=_startIndex;i<_endIndex;i++)
        {
          newList.add(_products[0].result.productsList[i]);

        }*/

      await Future.delayed(Duration(milliseconds: 1000));
      newList = _products[0]
          .result
          .productsList
          .getRange(_startIndex, _endIndex)
          .toList();
    } else {
      newList = [];
    }

    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(covariant CustomSliverChildBuilderDelegate oldDelegate) {
    return true;
  }
}
