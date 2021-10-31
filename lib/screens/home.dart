import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:myapp/controller/history_storage.dart';
import 'package:painter/painter.dart';
import 'package:myapp/screens/sidebar.dart';
import 'package:myapp/model/server_result.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/screens/result.dart';
import 'package:myapp/model/items.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as developer;
import 'package:myapp/controller/base64_conver.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _finished = false;
  PainterController _controller = _newController();
  Future<ServerResult> createServerResult(String data) async {
    final response = await http.post(
      Uri.parse('http://1509.ddns.net:5100/doodle/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'pic': data,
      }),
    );

    if (response.statusCode == 200) {
      return ServerResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create ServerResult.');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  static PainterController _newController() {
    PainterController controller = PainterController();
    controller.thickness = 8.0;
    controller.backgroundColor = const Color(0xFFF0F0F0);
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions;
    if (_finished) {
      actions = <Widget>[
        IconButton(
          icon: const Icon(Icons.content_copy),
          tooltip: 'New Painting',
          onPressed: () => setState(() {
            _finished = false;
            _controller = _newController();
          }),
        ),
      ];
    } else {
      actions = <Widget>[
        IconButton(
            icon: const Icon(
              Icons.undo,
            ),
            tooltip: 'Undo',
            onPressed: () {
              if (_controller.isEmpty) {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) =>
                        const Text('Nothing to undo'));
              } else {
                _controller.undo();
              }
            }),
        IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Clear',
            onPressed: _controller.clear),
        IconButton(
          icon: const Icon(Icons.add_to_photos),
          tooltip: 'New Painting',
          onPressed: () => setState(() {
            _finished = false;
            _controller = _newController();
          }),
        ),
      ];
    }
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const Sidebar(),
      appBar: AppBar(
          title: const Text('Painter'),
          actions: actions,
          bottom: PreferredSize(
            child: DrawBar(_controller),
            preferredSize: Size(MediaQuery.of(context).size.width, 30.0),
          )),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: AspectRatio(aspectRatio: 1.0, child: Painter(_controller)),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          String base64Image = base64String(await _controller.finish().toPNG());

          ServerResult serverResult = await createServerResult(base64Image);

          final df = DateFormat('dd-MM-yyyy hh:mm:ss a');
          String mean = serverResult.word['en'];
          HistoryItem item = HistoryItem(
              name: mean,
              image: base64Image,
              created: df.format(DateTime.now()).toString());
          writeHistory(item);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Result(item: item, serverResult: serverResult)),
          );
        },
        label: const Text('Search'),
        icon: const Icon(Icons.search),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class DrawBar extends StatelessWidget {
  final PainterController _controller;

  const DrawBar(this._controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Slider(
              value: _controller.thickness,
              onChanged: (double value) => setState(() {
                _controller.thickness = value;
              }),
              min: 1.0,
              max: 20.0,
              activeColor: Colors.white,
            );
          }),
        ),
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return RotatedBox(
              quarterTurns: _controller.eraseMode ? 2 : 0,
              child: IconButton(
                  icon: const Icon(Icons.create),
                  tooltip: (_controller.eraseMode ? 'Disable' : 'Enable') +
                      ' eraser',
                  onPressed: () {
                    setState(() {
                      _controller.eraseMode = !_controller.eraseMode;
                    });
                  }));
        }),
        ColorPickerButton(_controller, false),
        ColorPickerButton(_controller, true),
      ],
    );
  }
}

class ColorPickerButton extends StatefulWidget {
  final PainterController _controller;
  final bool _background;

  const ColorPickerButton(this._controller, this._background, {Key? key})
      : super(key: key);

  @override
  _ColorPickerButtonState createState() => _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(_iconData, color: _color),
        tooltip: widget._background
            ? 'Change background color'
            : 'Change draw color',
        onPressed: _pickColor);
  }

  void _pickColor() {
    Color pickerColor = _color;
    Navigator.of(context)
        .push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return Scaffold(
                  appBar: AppBar(
                    title: const Text('Pick color'),
                  ),
                  body: Container(
                      alignment: Alignment.center,
                      child: ColorPicker(
                        pickerColor: pickerColor,
                        onColorChanged: (Color c) => pickerColor = c,
                      )));
            }))
        .then((_) {
      setState(() {
        _color = pickerColor;
      });
    });
  }

  Color get _color => widget._background
      ? widget._controller.backgroundColor
      : widget._controller.drawColor;
  IconData get _iconData =>
      widget._background ? Icons.format_color_fill : Icons.brush;

  set _color(Color color) {
    if (widget._background) {
      widget._controller.backgroundColor = color;
    } else {
      widget._controller.drawColor = color;
    }
  }
}
