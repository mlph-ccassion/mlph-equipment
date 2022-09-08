import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equipment/shared/widgets/input_field.dart';
import 'package:flutter/material.dart';

class ReservationForm extends StatefulWidget {
  const ReservationForm({super.key, required this.equipment});

  final equipment;

  @override
  State<ReservationForm> createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {

  late String _name;
  late String _schedule;
  late String _purpose;

  void setName(value) {
    setState(() => _name = value!.trim());
  }

  void setSchedule(value) {
    setState(() => _schedule = value!.trim());
  }

  void setPurpose(value) {
    setState(() => _purpose = value!.trim());
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  final CollectionReference reservations =
      FirebaseFirestore.instance.collection('reservations');

   final CollectionReference equipment =
      FirebaseFirestore.instance.collection('equipment');

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserve Equipment'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            InputField(title: 'Name', clickFunction: setName),
            const SizedBox(height: 16),
            InputField(title: 'Schedule', clickFunction: setSchedule),
            const SizedBox(height: 32),
            InputField(title: 'Purpose', clickFunction: setPurpose),
            const SizedBox(height: 32),
            buildSubmit(),
          ],
        ),
      ),
    );
  }

  Widget buildSubmit() => Builder(
    builder: (context) => ElevatedButton(
      child: const Text('Submit'),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState?.save();

          var newRequest = {
            'name': _name,
            'purpose': _purpose,
            'schedule': _schedule,
          };
          
          if (widget.equipment['requested']) {
            var newList = widget.equipment['requestList'];
            newList.add(newRequest);

            equipment
              .doc(widget.equipment.reference.id)
              .update({
                'requestList': newList,
                'requested' : true,
              })
              .then(
                (value) => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Request Sent!')),
                ))
              .catchError(
                (error) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to request equipment: $error')),
                ));
          } else {
            equipment
              .doc(widget.equipment.reference.id)
              .set({'requestList': [newRequest], 'requested': true },SetOptions(merge: true))
              .then(
                (value) => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Request Sent!')),
                ))
              .catchError(
                (error) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to request equipment: $error')),
                ));
          }
          
            Navigator.pop(context);

          }
        }
    ),
  );

}