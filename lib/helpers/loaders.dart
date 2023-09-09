import 'package:elib/helpers/page_layout/text_formating.dart';
import 'package:flutter/material.dart';
import 'package:elib/helpers/colors.dart';

const spinner = CircularProgressIndicator(
  color: Colors.white,
  strokeWidth: 2.0,
);

const spinnerPry = CircularProgressIndicator(
  color: bluePrimaryColor,
  strokeWidth: 2.0,
);

loadingDialog(context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: SizedBox(
            width: 40.0,
            height: 40.0,
            child: spinner,
          ),
        );
      });
}

class Pageloader extends StatelessWidget {
  const Pageloader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 150.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: bluePrimaryColor,
            strokeWidth: 2.0,
          ),
        ],
      ),
    );
  }
}

futureLoadingModal(context) {
  showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 150,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 5.0,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close, size: 14.0),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 27.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Pageloader(),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "Loading..., Please wait",
                          style: textStyle,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}



// drag to refresh block 
