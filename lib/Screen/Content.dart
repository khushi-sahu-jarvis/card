import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Content extends StatefulWidget {
  final String name;
  final String id;
  final String status;
  final String startDate;
  final String image;

  const Content({Key? key,
    required this.name,
    required this.id,
    required this.startDate,
    required this.image, required this.status})
      : super(key: key);

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
        SizedBox(
        height: 30,
      ),
    Text(widget.name, style: TextStyle(fontSize: 10),),
    Text(widget.id),
    Text(widget.status),
    Text(widget.startDate, style: TextStyle(fontSize: 10),),
    Container(
    height: 80,
    width: 100,
    padding: EdgeInsets.only(right: 10),
    child: Image.network(widget.image,
    errorBuilder: (context, error, stackTrace) =>
    SvgPicture.network(
    widget.image, // for .svg extension
    ),
    )
    )
    ],
    );
  }
}
