import 'package:flutter/material.dart';
import 'package:web/models/channel_model.dart';
import 'package:web/models/video_model.dart';
import 'package:web/services/api_service.dart';
import 'package:web/widgets/widgets.dart';

class HomeScreenYTB extends StatefulWidget {
  final String channelID;

  const HomeScreenYTB({Key key, @required this.channelID}) : super(key: key);

  @override
  _HomeScreenYTBState createState() => _HomeScreenYTBState();
}

class _HomeScreenYTBState extends State<HomeScreenYTB> {
  Channel _channel;
  bool _isLoading = false;
  bool _noVideoFound;

  @override
  void initState() {
    super.initState();
    _noVideoFound = true;
    _initChannel();
  }

  _initChannel() async {
    Channel channel =
        await APIService.instance.fetchChannel(channelId: widget.channelID);

    setState(() {

      if (channel.videos.length != 0){
        _noVideoFound = false;
        _channel = channel;
      }else {
        _noVideoFound = true;
        _channel = channel;
      }

    });
  }

  _buildProfileInfo() {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      height: 100.0,
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
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35.0,
            backgroundImage: NetworkImage(_channel.profilePictureUrl),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _channel.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${_channel.subscriberCount} subscribers',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Scaffold(),
        ),
      ),
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

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel.uploadPlaylistId);
    List<Video> allVideos = _channel.videos..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      //height:  MediaQuery.of(context).size.width,
      child: Container(
        child: !_noVideoFound && _channel != null
            ? PostContainerYoutube(channel: _channel)
            : Center(
                child:
                    CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor, // Red
                        ),
                      )
                    ,
              ),
      ),
    );
  }
}
