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
