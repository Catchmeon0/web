import 'package:flutter/material.dart';
import 'package:web/data/data.dart';
import 'package:web/models/models.dart';
import 'package:web/widgets/widgets.dart';

class HomeScreenDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;

  const HomeScreenDesktop({Key key, @required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Container(
            color: Colors.grey[100],
          ),
        ),
        //const Spacer(),
        Container(
          width: 1000,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Column(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 200, vertical: 20),
                          child: Image.asset(
                              "assets/images/CMO_CatchMeOn_black.png")),
                      SizedBox(
                        height: 100,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 150, vertical: 20),
                                child: Expanded(
                                    child: Text(
                                        "CatchMeOn let you see the last content that your favourite creator put all over his social media in one place, no more wasting time switching between all the apps + you can't get lost in algorithm anymore!", style: TextStyle(fontWeight:FontWeight.bold ))),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 20),
                                  child: Image.asset("assets/gifs/cmo.gif"))),
                        ],
                      ),
                    ],
                  );
                },
                childCount: 1,
              )),
            ],
          ),
        ),
        // const Spacer(),
        Flexible(
          flex: 2,
          child: Container(
            color: Colors.grey[100],
          ),
        ),
      ],
    );
  }
}
