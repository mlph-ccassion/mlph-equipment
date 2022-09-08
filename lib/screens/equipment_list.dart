
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equipment/screens/equipment_view.dart';
import 'package:equipment/shared/widgets/equipment_card.dart';
import 'package:flutter/material.dart';

class EquipmentList extends StatefulWidget {
  const EquipmentList(
      {Key? key, required this.title, required this.reserved})
      : super(key: key);

  final String title;
  final bool reserved;

  @override
  State<EquipmentList> createState() => _EquipmentListState();
}

class _EquipmentListState extends State<EquipmentList> {
  late Stream<QuerySnapshot> equipment;

  @override
  void initState() {
    super.initState();
    equipment = FirebaseFirestore.instance.collection('equipment').where('reserved', isEqualTo: widget.reserved).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: equipment,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong.');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = snapshot.requireData;
          
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 13.0),
            itemCount: data.size,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EquipmentView(
                        equipment: data.docs[index],
                      )),
                  );
                },
                child: EquipmentCard(
                  equipment: data.docs[index],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) { 
              return const SizedBox(height: 8,);
            },);
        },
      ),
    );
  }
}


 