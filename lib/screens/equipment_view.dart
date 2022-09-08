import 'package:equipment/screens/reservation_form.dart';
import 'package:equipment/shared/widgets/equipment_details.dart';
import 'package:equipment/shared/widgets/request_list.dart';
import 'package:flutter/material.dart';

class EquipmentView extends StatefulWidget {
  const EquipmentView({super.key, required this.equipment});

  final equipment;

  @override
  State<EquipmentView> createState() => _EquipmentViewState();
}

class _EquipmentViewState extends State<EquipmentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.equipment['name'])
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              EquipmentDetails(equipment: widget.equipment),
              if (widget.equipment['requested'])
                RequestList(equipmentId: widget.equipment.reference.id, requestList: widget.equipment['requestList'],),            
              if (!widget.equipment['reserved'])
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReservationForm(
                          equipment: widget.equipment
                        )),
                    );
                  },
                  child: const Text('REQUEST'),
                ),
                const SizedBox(height: 20,)
            ],),
        ),
      )
    );
  }
}