import 'package:flutter/material.dart';
import 'package:myapp/model/items.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myapp/model/server_result.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:myapp/controller/base64_conver.dart';

class Result extends StatelessWidget {
  const Result({Key? key, required this.item, required this.serverResult})
      : super(key: key);
  final HistoryItem item;
  final ServerResult serverResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: MemoryImage(dataFromBase64String(item.image)),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                const TextSpan(
                  text: 'This is a(n) ',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: item.name,
                  style: const TextStyle(
                    fontSize: 50.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(
                  text: '.',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black,
                  ),
                ),
              ]),
            ),
          ),
          CarouselSlider(
            items: serverResult.img
                .map((img) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Stack(children: <Widget>[
                      const Center(child: CircularProgressIndicator()),
                      Center(
                        child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: img,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover),
                      )
                      // child: Image.memory(dataFromBase64String(img))),
                    ])))
                .toList(),

            //Slider Container properties
            options: CarouselOptions(
              height: 300,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
