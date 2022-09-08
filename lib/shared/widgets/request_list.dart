import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RequestList extends StatefulWidget {
  const RequestList({super.key, required this.equipmentId, required this.requestList});

  final equipmentId;
  final requestList;

  @override
  State<RequestList> createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {

  var data;
  late Stream<DocumentSnapshot> equipment;

  @override
  void initState() {
    super.initState();
    equipment = FirebaseFirestore.instance.collection('equipment')
      .doc(widget.equipmentId)
      .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        const Text('Request List', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        StreamBuilder<DocumentSnapshot>(
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
              data = snapshot.data?['requestList'];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${(index+1).toString()}. Name: ${data[index]['name']}'),
                          Text('Schedule: ${data[index]['schedule']}'),
                          Text('Purpose: ${data[index]['purpose']}'),
                        ],
                      ),
                    ),
                  );
                }),
            );
          }
        ),
      ],
    );
  }
}