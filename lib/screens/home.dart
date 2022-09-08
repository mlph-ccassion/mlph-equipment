import 'package:equipment/screens/equipment_list.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  IconData(0xf01d0, fontFamily: 'MaterialIcons'),
                  color: Color(0xff20a18d),
                  size: 150.0,
                ),
                const SizedBox(height: 50,),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EquipmentList(
                          title: 'Available Equipment',
                          reserved: false,                         
                        )),
                    );
                  },
                  child: Text("Available Equipment".toUpperCase()),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EquipmentList(
                          title: 'Reserved Equipment',
                          reserved: true,
                        )),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff9b9d9d), 
                  ),
                  child: Text("Reserved Equipment".toUpperCase()),
                ),
              ],
            ),
          ),
        ),
    ));
  }
}