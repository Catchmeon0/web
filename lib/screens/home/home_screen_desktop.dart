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
                      final Post post = posts[index];
                      return PostContainer(post: post);
                    },
                    childCount: posts.length,
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
