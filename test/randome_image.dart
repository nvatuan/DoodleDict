// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';

// class randomeImage extends StatefulWidget {
//   const randomeImage({Key? key}) : super(key: key);

//   @override
//   _randomeImageState createState() => _randomeImageState();
// }

// class _randomeImageState extends State<randomeImage> {
//   String url = 'https://picsum.photos/id/0/500/';
//   String id = "0";
//   void _getdata() {
//     Random random = new Random();
//     int randomNumber = random.nextInt(100);
//     id = randomNumber.toString();
//     setState(() {
//       fetchImage(id).then((data) {
//         url = data.downloadUrl;
//       });
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Randome Image',
//             style: TextStyle(
//               color: Colors.pink,
//             )),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             FutureBuilder(
//               future: fetchImage(id),
//               builder: (BuildContext context, AsyncSnapshot snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 }
//                 if (snapshot.hasData) {
//                   return Image.network(snapshot.data.downloadUrl);
//                 }
//                 return Container();
//               },
//             ),
//             TextButton(
//               onPressed: () {
//                 _getdata();
//               },
//               child: const Text('Randome'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// Future<ImageApi> fetchImage(String id) async {
//   final response =
//       await http.get(Uri.parse('https://picsum.photos/id/$id/info'));
//   if (response.statusCode == 200) {
//     return ImageApi.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load Image');
//   }
// }

// class ImageApi {
//   String id;
//   String author;
//   int width;
//   int height;
//   String url;
//   String downloadUrl;

//   ImageApi(
//       {required this.id,
//       required this.author,
//       required this.width,
//       required this.height,
//       required this.url,
//       required this.downloadUrl});

//   factory ImageApi.fromJson(Map<String, dynamic> json) {
//     return ImageApi(
//         id: json['id'],
//         author: json['author'],
//         width: json['width'],
//         height: json['height'],
//         url: json['url'],
//         downloadUrl: json['download_url']);
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['author'] = this.author;
//     data['width'] = this.width;
//     data['height'] = this.height;
//     data['url'] = this.url;
//     data['download_url'] = this.downloadUrl;
//     return data;
//   }
// }
