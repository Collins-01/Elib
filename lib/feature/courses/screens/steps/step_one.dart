import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class StepOneSearch extends StatefulWidget {
  const StepOneSearch({super.key});

  @override
  State<StepOneSearch> createState() => _StepOneSearchState();
}

class _StepOneSearchState extends State<StepOneSearch> {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title:"Pick Program",
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children: [
          
        ],
      ),

    );
  }
}