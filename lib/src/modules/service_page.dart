import 'package:anainfo_flutter/src/model/ServicesModel.dart';
import 'package:anainfo_flutter/src/utils/constant_strings.dart';
import 'package:anainfo_flutter/src/widget/list_widget.dart';
import 'package:anainfo_flutter/src/widget/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

import '../utils/constant_color.dart';
import '../widget/style_card.dart';

class ServicePage extends StatefulWidget {
  static const String routeName = '/servicePage';

  @override
  State<StatefulWidget> createState() {
    return _ServicePage();
  }
}

class _ServicePage extends State<ServicePage> {
  final List<Widget> styleCards = [
    StyleCard(
      image: Image.asset("assets/images/card_one.jpg"),
      title: ConstantString.serviceTitleAndroid,
      description: ConstantString.serviceDescAndroid,
    ),
    StyleCard(
      image: Image.asset("assets/images/card_one.jpg"),
      title: ConstantString.serviceTitleIos,
      description: ConstantString.serviceDescIos,
    ),
    StyleCard(
      image: Image.asset("assets/images/card_one.jpg"),
      title: ConstantString.serviceTitleWeb,
      description: ConstantString.serviceDescWeb,
    ),
    StyleCard(
      image: Image.asset("assets/images/card_one.jpg"),
      title: ConstantString.serviceTitleUI,
      description: ConstantString.serviceDescUI,
    ),
    StyleCard(
      image: Image.asset("assets/images/card_one.jpg"),
      title: ConstantString.serviceTitleProject,
      description: ConstantString.serviceDescProject,
    ),
    StyleCard(
      image: Image.asset("assets/images/card_one.jpg"),
      title: ConstantString.serviceTitleQA,
      description: ConstantString.serviceDescQA,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Service"),
        ),
        drawer: NavDrawer(),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                  ConstantColor.bgGradientStart,
                  ConstantColor.bgGradientEnd
                ])),
            child: StackedCardCarousel(
              initialOffset: 40,
              spaceBetweenItems: 400,
              items: styleCards,
            ),
          ),
        )

/*        body: ListView.builder(
            itemCount: ServicesModel.items.length,
            itemBuilder: (context, index) {
              return ItemWidget(item: ServicesModel.items[index]);
            })*/
        );
  }
}
