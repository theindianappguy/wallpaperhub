import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/data/data.dart';
import 'package:wallpaper/models/photos_model.dart';
import 'package:wallpaper/widget/widget.dart';

class CategorieScreen extends StatefulWidget {
  final String categorie;
  CategorieScreen({@required this.categorie});

  @override
  _CategorieScreenState createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {

  List<PhotosModel> photos = new List();


  getCategorieWallpaper() async {
    await http.get("https://api.pexels.com/v1/search?query=${widget.categorie}&per_page=30&page=1",
        headers: {
          "Authorization": apiKEY}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        PhotosModel photosModel = new PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);

      });

      setState(() {

      });
    });
  }

  @override
  void initState() {
    getCategorieWallpaper();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
        actions: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.add, color: Colors.white,))
        ],
      ),
      body: SingleChildScrollView(
        child: wallPaper(photos, context)
         /* Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: const EdgeInsets.all(4.0),
            mainAxisSpacing: 6.0,
            crossAxisSpacing: 6.0,
            children: photos.map((PhotosModel photoModel) {
              return GridTile(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ImageView(
                            imgPath: photoModel.src.portrait,
                          )
                      ));
                    },
                    child: Hero(
                      tag: photoModel.src.portrait,
                      child: Container(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                                imageUrl: photoModel.src.portrait,
                                placeholder: (context, url) => Container(color: Color(0xfff5f8fd),),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ));
            }).toList()),
      )*/,),
    );
  }
}
