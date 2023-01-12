import 'package:elib/helpers/components/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
        // noAppBar: true,
        navPop: false,
        title: "Home",
        fontSize:30,
        appBarColor:primaryColor,
        titleTextColor:Colors.white,
        appBarElevation:2.0,
        appBarActions:[
          IconButton(
            onPressed:()=>null, 
            icon: Icon(Icons.search,color:Colors.white,)
          )
        ],
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height:100.0,),
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: const [
                  AppIcon(
                    width:200.0,
                  ),
        
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child:Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        textAlign:TextAlign.center,
                        style:textStyle(
                          fontSize:18.0
                        ),
                      ) 
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}
