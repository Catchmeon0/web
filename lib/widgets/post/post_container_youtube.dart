import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:web/config/palette.dart';
import 'package:web/models/channel_model.dart';
import 'package:web/models/channel_model.dart';
import 'package:web/models/video_model.dart';
import 'package:web/widgets/profile_avatar.dart';
import 'dart:js' as js;

class PostContainerYoutube extends StatefulWidget {
  final Channel channel;

  const PostContainerYoutube({Key key, @required this.channel})
      : super(key: key);

  @override
  _PostContainerYoutubeState createState() => _PostContainerYoutubeState();
}

class _PostContainerYoutubeState extends State<PostContainerYoutube> {
  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        height: 140.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                video.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(width: 0.6, color: Colors.redAccent[400]),
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),

      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PostHeader(channel: widget.channel),
                const SizedBox(height: 4.0),
              ],
            ),
          ),

          _buildVideo(widget.channel.videos[0]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: _PostStats(channel: widget.channel),
          ),
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
            _PostButton(
              icon: Icon(
                MdiIcons.shareOutline,
                color: Colors.red[600],
                size: 25.0,
              ),
              label: 'Check the video',
              onTap: () {
                print('check the video');

                js.context.callMethod('open', [
                  'https://www.youtube.com/watch?v=${channel.videos[0].id}'
                ]);
              },
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
