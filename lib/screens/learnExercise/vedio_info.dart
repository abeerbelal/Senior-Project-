import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'colors.dart' as color;

class VideoInfo extends StatefulWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  List videoinfo =[];
  bool _playArea = false;
  VideoPlayerController? _controller;
  bool _isPlaying = false;
  bool _disposed = false;
  int _isPlayingIndex = -1;
  _initData() async{
    await DefaultAssetBundle.of(context).loadString("json/videoinfo.json").then((value){
      setState(() {
        videoinfo = json.decode(value);
      });
    });
  }

  @override
  void initState(){
    super.initState();
    _initData();
  }
  @override
  void dispose(){
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    // _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:_playArea == false? BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.AppColor.gradientFirst.withOpacity(0.9),
                color.AppColor.gradientSecond,
              ],
              begin:const FractionalOffset(0.0,0.4),
              end: Alignment.topRight,
            )
        ):BoxDecoration(
          color: color.AppColor.gradientSecond,
        ),
        child: Column(
          children: [
            _playArea == false?Container(
              padding: const EdgeInsets.only(top: 40,left: 30,right: 30),
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap:(){
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back_ios,size: 20,color: color.AppColor.secondPageIconColor,)),
                      Expanded(child: Container()),
                      Icon(Icons.info_outline,size: 20,
                        color: color.AppColor.secondPageIconColor,)
                    ],
                  ),
                  Text("legs toning ",
                    style: TextStyle(
                        fontSize: 25 ,
                        color: color.AppColor.secondPageTitleColor
                    ),),
                  SizedBox(height: 5,),
                  Text("and glutes workout ",
                    style: TextStyle(
                        fontSize: 25 ,
                        color: color.AppColor.secondPageTitleColor
                    ),
                  ),
                  SizedBox(height: 50,),
                  Row(

                    children: [
                      Container(
                        width: 90,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                color.AppColor.secondPageContainerGradient1stColor,
                                color.AppColor.secondPageContainerGradient2ndColor,
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.timer,size: 20,
                              color: color.AppColor.secondPageIconColor,),
                            SizedBox(width: 5,),
                            Text("68 min",style: TextStyle(
                                fontSize: 16,
                                color: color.AppColor.secondPageIconColor
                            ),)
                          ],
                        ),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        width: 220,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                color.AppColor.secondPageContainerGradient1stColor,
                                color.AppColor.secondPageContainerGradient2ndColor,
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.handyman_outlined,size: 20,
                              color: color.AppColor.secondPageIconColor,),
                            SizedBox(width: 5,),
                            Text("resestant band ,kett",style: TextStyle(
                                fontSize: 16,
                                color: color.AppColor.secondPageIconColor
                            ),)
                          ],
                        ),
                      ),
                    ],
                  )


                ],
              ),
            ):Container(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    padding: EdgeInsets.only(top: 50,left: 30,right: 30),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Get.back();
                          },
                          child:Icon(Icons.arrow_back_ios,
                            size: 20,
                            color: color.AppColor.secondPageIconColor,) ,
                        ),
                        Expanded(child: Container()),
                        Icon(Icons.info_outline,size: 20,
                          color: color.AppColor.secondPageIconColor,)
                      ],
                    ),
                  ),
                  _playView(context),
                  _controlView(context),

                ],
              ),
            ),
            Expanded(child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(70)
                  )
              ),
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Row(

                    children: [
                      SizedBox(width: 30,),
                      Text("circit 1 : legs toning",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color.AppColor.circuitsColor
                      ),
                      ),
                      Expanded(child: Container()),
                      Row(
                        children: [
                          Icon(Icons.loop,size: 30,color: color.AppColor.loopColor,),
                          SizedBox(width: 10,),
                          Text("3 sets",
                            style: TextStyle(
                                fontSize: 15,
                                color: color.AppColor.setsColor
                            ),)
                        ],
                      ),
                      SizedBox(width: 20,),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Expanded(child: _listView())
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  String convertTwo(int value){
    return value <10 ? "0$value" : "$value";
  }

  Widget _controlView(BuildContext context){
    final noMute = (_controller?.value?.volume??0)>0;
    final duration = _duration?.inSeconds ?? 0;
    final head = _position?.inSeconds ??0;
    final remained = max(0,duration - head);
    final mins = convertTwo(remained ~/ 60.0);
    final secs = convertTwo(remained % 60);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SliderTheme(data:SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.red[700],
            inactiveTrackColor: Colors.red[100],
            trackShape: RoundedRectSliderTrackShape(),
            trackHeight: 2.0,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
            thumbColor: Colors.redAccent,
            overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
            overlayColor: Colors.red.withAlpha(32),
            tickMarkShape: RoundSliderTickMarkShape(),
            activeTickMarkColor: Colors.red[700],
            inactiveTickMarkColor: Colors.red[100],
            valueIndicatorShape: PaddleSliderValueIndicatorShape(),
            valueIndicatorColor: Colors.redAccent,
            valueIndicatorTextStyle: TextStyle(
              color: Colors.white,
            )
        ),
            child: Slider(
              value: max(0,min(_progress*100,100)),
              min: 0,
              max: 100,
              divisions: 100,
              label: _position?.toString().split(".")[0],
              onChanged: (value){
                setState(() {
                  _progress = value*0.01;
                });
              },
              onChangeStart: (value){
                _controller?.pause();
              },
              onChangeEnd: (value){
                final duration = _controller?.value?.duration;
                if(duration != null){
                  var newValue = max(0,min(value,99))*0.01;
                  var millis = (duration.inMilliseconds*newValue).toInt();
                  _controller?.seekTo(Duration(milliseconds: millis));
                  _controller?.play();
                }
              },
            )),
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          margin:EdgeInsets.only(bottom: 5) ,
          color: color.AppColor.gradientSecond,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0.0,0.0),
                            blurRadius: 4.0,
                            color: Color.fromARGB(50, 0,0,0),
                          )
                        ]
                    ),
                    child: Icon(
                      noMute?Icons.volume_up:Icons.volume_off,
                      color: Colors.white,),
                  ),
                ),
                onTap: (){
                  if(noMute){
                    _controller?.setVolume(0);
                  }else{
                    _controller?.setVolume(1.0);
                  }
                  setState(() {});
                },
              ),
              TextButton(onPressed: () async{
                final index = _isPlayingIndex-1;
                //back one to the previous(index) video
                if(index >=0 && videoinfo.length >= 0){
                  _initializeVideo(index);
                }else{
                  Get.snackbar("Video List", "",
                      snackPosition: SnackPosition.BOTTOM,
                      icon: Icon(Icons.face,
                        size: 30,
                        color: Colors.white,),
                      backgroundColor: color.AppColor.gradientSecond,
                      colorText: Colors.white,
                      messageText: Text(
                        "No videos ahead",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                        ),
                      )
                  );
                }
              },
                  child: Icon(Icons.fast_rewind,
                    size: 36,
                    color: Colors.white,)),
              TextButton(onPressed: ()async {
                if(_isPlaying){
                  setState(() {
                    _isPlaying = false;
                  });
                  _controller?.pause();
                }else{
                  setState(() {
                    _isPlaying = true;
                  });
                  _controller?.play();
                }

              },
                  child: Icon(_isPlaying?Icons.pause: Icons.play_arrow,
                    size: 36,
                    color: Colors.white,)),
              TextButton(onPressed: () async {
                final index = _isPlayingIndex+1;
                if(index <= videoinfo.length-1){
                  _initializeVideo(index);
                }else{
                  Get.snackbar("Video List", "",
                      snackPosition: SnackPosition.BOTTOM,
                      icon: Icon(Icons.face,
                        size: 30,
                        color: Colors.white,),
                      backgroundColor: color.AppColor.gradientSecond,
                      colorText: Colors.white,
                      messageText: Text(
                        "You finished watching all the videos ,Congrats!",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                        ),
                      )
                  );

                }
              },
                  child: Icon(Icons.fast_forward,
                    size: 36,
                    color: Colors.white,)),
              Text("$mins:$secs",
                style: TextStyle(
                    color: Colors.white,
                    shadows:[
                      Shadow(
                        offset: Offset(0.0,1.0),
                        blurRadius: 4.0,
                        color: Color.fromARGB(150,0,0,0),
                      )
                    ]
                ),)
            ],
          ),
        ),
      ],
    );
  }
  Widget _playView(BuildContext context) {
    final controller2 = _controller;
    if(controller2 != null && controller2.value.isInitialized){
      return AspectRatio(
        aspectRatio: 16/9,
        child:  VideoPlayer(controller2),
      );
    }else{
      return AspectRatio(
          aspectRatio: 16/9,
          child: Center(child: Text("Preparing...",
            style: TextStyle(
                fontSize: 20,
                color: Colors.white
            ),
          )));

    }
  }
  var _onUpdateControllerTime;
  Duration? _duration;
  Duration? _position;
  var _progress = 0.0;
  void _onControllerUpdate ()async{
    if(_disposed){
      return;
    }
    _onUpdateControllerTime = 0;
    final now = DateTime.now().microsecondsSinceEpoch;
    if(_onUpdateControllerTime > now){
      return;
    }
    _onUpdateControllerTime = now+500;//millsec

    final controller = _controller;
    if(controller == null){
      debugPrint("controller is null");
      return;
    }
    if(!controller.value.isInitialized){
      debugPrint("controller can not be initialized");
      return;
    }

    if(_duration == null){
      _duration = _controller?.value.duration;
    }
    var duration = _duration;
    if(duration == null)return;

    var position = await controller.position;
    _position = position;

    final playing = controller.value.isPlaying;
    if(playing){
      //handle progress indicator
      if(_disposed)return;
      setState(() {
        _progress = position!.inMilliseconds.ceilToDouble() / duration.inMilliseconds.ceilToDouble();
      });
    }
    _isPlaying = playing;
  }

  _initializeVideo(int index) async{
    final controller1 = VideoPlayerController.network(videoinfo[index]['videoUrl']);
    final old = _controller;//save the old controller which is the old video

    _controller = controller1;
    if(old != null){
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});
    controller1
      ..initialize().then((_){
        old?.dispose();
        _isPlayingIndex = index;
        //just the init done then play the video
        controller1.addListener(_onControllerUpdate);
        _controller?.play();
        setState(() {});
      });
  }
  _onTapVideo(int index) async {
    _initializeVideo(index);
  }
  _listView(){
    return  ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
        itemCount:videoinfo.length
        ,itemBuilder: (_, int index){


      return GestureDetector(
        onTap: (){
          _onTapVideo(index);
          debugPrint(index.toString());
          setState(() {
            if(_playArea == false){
              _playArea = true;
            }
          });
        },
        child: _bulidCard(index),
      );
    });
  }
  _bulidCard(int index){
    return Container(
      height: 135,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(
                          videoinfo[index]["thumbnail"]
                      ),
                      fit: BoxFit.cover,
                    )
                ),
              ),
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(videoinfo[index]["title"],
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(padding: EdgeInsets.only(top: 3),
                    child: Text(
                      videoinfo[index]["time"],
                      style: TextStyle(
                          color: Colors.grey[500]
                      ),

                    ),)
                ],
              )
            ],
          ),
          SizedBox(height: 18,),
          Row(
            children: [
              Container(
                height: 20,
                width: 80,
                decoration: BoxDecoration(
                  color: Color(0xffeaeefc),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '15s rest', style: TextStyle(
                      color: Color(0xff839fed)
                  ),
                  ),
                ),
              ),
              Row(
                children: [
                  for(int i=0;i<70;i++)
                    i.isEven?Container(
                      width: 3,
                      height: 1,
                      decoration: BoxDecoration(
                          color: Color(0xff839fed),
                          borderRadius: BorderRadius.circular(2)
                      ),
                    ):Container(
                      width: 3,
                      height: 1,
                      color: Colors.white,
                    )
                ],
              )
            ],
          )

        ],
      ),
    );
  }
}

