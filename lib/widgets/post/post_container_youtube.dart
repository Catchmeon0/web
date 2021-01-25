import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:web/config/palette.dart';
import 'package:web/models/channel_model.dart';
import 'package:web/models/channel_model.dart';
import 'package:web/widgets/profile_avatar.dart';
import 'dart:js' as js;
class PostContainerYoutube extends StatelessWidget {
  final Channel channel;

  const PostContainerYoutube({Key key, @required this.channel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PostHeader(channel: channel),
                const SizedBox(height: 4.0),
              //  Text(channel.title),
                /*channel.profilePictureUrl != null
                    ? const SizedBox.shrink()
                    : const SizedBox(
                  height: 6.0,
                ),*/
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: _PostStats(channel: channel),
                ),
              ],
            ),
          ),
          channel.videos[0].thumbnailUrl != null
              ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CachedNetworkImage(imageUrl: channel.videos[0].thumbnailUrl),
          )
              : const SizedBox.shrink(),
          Text(channel.videos[0].thumbnailUrl != null
              ? channel.videos[0].title :  Scaffold())
        ],
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Channel channel;

  const _PostHeader({Key key, @required this.channel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: channel.profilePictureUrl),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                channel.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
        /*      Row(
                children: [
                  Text(
                    '${channel.subscriberCount}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12.0),
                  ),
                  Icon(
                    MdiIcons.youtubeSubscription,
                    color: Colors.red[600],
                    size: 12.0,
                  ),
                ],
              )*/
            ],
          ),
        ),
        Row(
          children: [
            Text(
              '${channel.subscriberCount} Subscriber.s',
              style: TextStyle(color: Colors.grey[600], fontSize: 12.0),
            ),
            Icon(
              MdiIcons.youtubeSubscription,
              color: Colors.red[600],
              size: 12.0,
            ),
          ],
        )
      ],
    );
  }
}

class _PostStats extends StatelessWidget {
  final Channel channel;

  const _PostStats({
    Key key,
    @required this.channel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
/*            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Palette.facebookBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.thumb_up,
                size: 10.0,
                color: Colors.white,
              ),
            ),*/
            const SizedBox(width: 4.0),
          /*  Expanded(
              child: Text(
                '${channel.likes}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),*/
/*            Text(
              '${channel.comments} Comments',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              '${channel.shares} Shares',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            )*/
          ],
        ),
        const Divider(),
        Row(
          children: [
            _PostButton(
              icon: Icon(
                MdiIcons.shareOutline,
                color: Colors.grey[600],
                size: 25.0,
              ),
              label: 'Check the channel',
              onTap: () {print('check the video');

    js.context.callMethod('open', ['https://www.youtube.com/watch?v=${channel.videos[0].id}']);},
            )
          ],
        ),
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onTap;

  const _PostButton({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
