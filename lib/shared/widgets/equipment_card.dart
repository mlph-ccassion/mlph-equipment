import 'package:flutter/material.dart';


class EquipmentCard extends StatefulWidget {
  final equipment;

  const EquipmentCard({Key? key, required this.equipment}) : super(key: key);

  @override
  State<EquipmentCard> createState() => _EquipmentCardState();
}

class _EquipmentCardState extends State<EquipmentCard> {
  @override
  Widget build(BuildContext context) {
    return (Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(
                widget.equipment['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: Text(widget.equipment['specs']),
            ),
            SizedBox(
              height: 200.0,
              child: Ink.image(
                image: NetworkImage(widget.equipment['image']),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                widget.equipment['description'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ),
          ],
        )));
  }
}
