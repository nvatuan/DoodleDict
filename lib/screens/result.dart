import 'package:flutter/material.dart';
import 'package:myapp/model/items.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myapp/model/server_result.dart';
import 'package:myapp/controller/base64_conver.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:developer' as developer;

class Result extends StatefulWidget {
  const Result({Key? key, required this.item}) : super(key: key);
  final HistoryItem item;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  String _displayText = 'Loading...';
  SpeedDial buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(size: 28.0),
      backgroundColor: Colors.blue,
      visible: true,
      curve: Curves.bounceInOut,
      children: [
        // SpeedDialChild(
        //   child: Image.asset('assets/china.png'),
        //   backgroundColor: Colors.white,
        //   onTap: () => {
        //     setState(() {
        //       _displayText = widget.item.lsWord['zh-cn'];
        //     })
        //   },
        //   label: 'Chinese',
        //   labelStyle:
        //       const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        //   labelBackgroundColor: Colors.blue,
        // ),
        SpeedDialChild(
          child: Image.asset('assets/russia.png'),
          backgroundColor: Colors.white,
          onTap: () => {
            setState(() {
              _displayText = widget.item.lsWord['ru'];
            })
          },
          label: 'Rusian',
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          labelBackgroundColor: Colors.blue,
        ),
        SpeedDialChild(
          child: Image.asset('assets/france.png'),
          backgroundColor: Colors.white,
          onTap: () => {
            setState(() {
              _displayText = widget.item.lsWord['fr'];
            })
          },
          label: 'French',
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          labelBackgroundColor: Colors.blue,
        ),
        SpeedDialChild(
          child: Image.asset('assets/japan.png'),
          backgroundColor: Colors.white,
          onTap: () => {
            setState(() {
              _displayText = widget.item.lsWord['ja'];
            })
          },
          label: 'Japanese',
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          labelBackgroundColor: Colors.blue,
        ),
        SpeedDialChild(
          child: Image.asset('assets/vietnam.png'),
          backgroundColor: Colors.white,
          onTap: () => {
            setState(() {
              _displayText = widget.item.lsWord['vi'];
            })
          },
          label: 'Vietnamese',
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          labelBackgroundColor: Colors.blue,
        ),
        SpeedDialChild(
          child: Image.asset('assets/united-kingdom.png'),
          backgroundColor: Colors.white,
          onTap: () => {
            setState(() {
              _displayText = widget.item.lsWord['en'];
            })
          },
          label: 'Enlish',
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          labelBackgroundColor: Colors.blue,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildSpeedDial(),
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              alignment: Alignment.center,
              height: 320,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.memory(
                  dataFromBase64String(widget.item.image),
                  width: 320,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                  text: _displayText == 'Loading...'
                      ? widget.item.name
                      // ? "pусский язык"
                      : _displayText,
                  style: const TextStyle(
                    fontSize: 50.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ]),
            ),
          ),
          CarouselSlider(
            items: widget.item.lsImage
                .map(
                  (img) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Stack(children: <Widget>[
                      const Center(child: CircularProgressIndicator()),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage.assetNetwork(
                              placeholder: 'assets/loading.png',
                              image: img,
                              width: 480,
                              height: 270,
                              fit: BoxFit.fill),
                          // child: Image.network(img, width: 480, height: 270)),
                        ),
                      )
                    ]),
                  ),
                )
                .toList(),

            //Slider Container properties
            options: CarouselOptions(
              height: 270,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 700),
              viewportFraction: 0.9,
            ),
          ),
        ],
      ),
    );
  }
}
