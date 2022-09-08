import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tab_container/tab_container.dart';

class EquipmentDetails extends StatefulWidget {
  const EquipmentDetails({super.key, required this.equipment});

  final equipment;

  @override
  State<EquipmentDetails> createState() => _EquipmentDetailsState();
}

class _EquipmentDetailsState extends State<EquipmentDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          height: 350.0,
          child: Ink.image(
            image: NetworkImage(widget.equipment['image']),
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 20,),
        Text(widget.equipment['name'], style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        const SizedBox(height: 20,),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          child: AspectRatio(
            aspectRatio: 10 / 10,
            child: TabContainer(
              radius: 20,
              tabEdge: TabEdge.top,
              tabCurve: Curves.easeIn,
              transitionBuilder: (child, animation) {
                animation = CurvedAnimation(
                    curve: Curves.easeIn, parent: animation);
                return SlideTransition(
                  position: Tween(
                    begin: const Offset(0.2, 0.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(animation),
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              colors: <Color>[
                const Color(0xffbce1db),
                const Color(0xffe1e6e6),
                if(widget.equipment['reserved'] == true)
                const Color(0xffe1e6e6),
              ],
              tabs: [
                const Icon(
                  IconData(0xf363, fontFamily: 'MaterialIcons'),
                  color: Color(0xff20a18d),
                  size: 20.0,
                ),
                const Icon(
                  IconData(0xee98, fontFamily: 'MaterialIcons'),
                  color: Color(0xff20a18d),
                  size: 20.0,
                ),
                if(widget.equipment['reserved'] == true)
                const Icon(
                  IconData(0xf522, fontFamily: 'MaterialIcons'),
                  color: Color(0xff20a18d),
                  size: 20.0,
                ),
              ],
              isStringTabs: false,
              children:  [
                SingleChildScrollView(
                  child: ListTile(
                    title: const Text('SPECS'),
                    subtitle: Text(widget.equipment['specs']),
                  ),
                ),
                SingleChildScrollView(
                  child: ListTile(
                    title: const Text('DESCRIPTION'),
                    subtitle: Text(widget.equipment['description']),
                  ),
                ),
                if(widget.equipment['reserved'] == true)
                SingleChildScrollView(
                  child: ListTile(
                    title: const Text('RESERVED TO:'),
                    subtitle: Text(
                      'Name: ${widget.equipment['employee']['name']}\nSchedule: ${widget.equipment['employee']['schedule']}\nPurpose: ${widget.equipment['employee']['purpose']}'
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
}