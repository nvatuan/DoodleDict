// import 'package:flutter/material.dart';
// import 'randome_image.dart';

// class Demo extends StatefulWidget {
//   const Demo({Key? key, required this.title}) : super(key: key);
//   final String title;
//   @override
//   _DemoState createState() => _DemoState();
// }

// class _DemoState extends State<Demo> {
//   String _displayText = 'Nothing';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Container(
//               child: Text(
//                 _displayText,
//                 style: Theme.of(context).textTheme.headline4,
//               ),
//             ),
//             Container(
//               child: TextField(
//                 autofocus: true,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Input',
//                 ),
//                 onChanged: (String text) {
//                   _displayText = text;
//                 },
//               ),
//             ),
//             Container(
//               child: TextButton(
//                 onPressed: () {
//                   setState(
//                     () {
//                       _displayText;
//                     },
//                   );
//                 },
//                 child: const Text('Submit'),
//               ),
//             ),
//             IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const randomeImage()),
//                   );
//                 },
//                 icon: const Icon(Icons.forward)),
//           ],
//         ),
//       ),
//     );
//   }
// }
