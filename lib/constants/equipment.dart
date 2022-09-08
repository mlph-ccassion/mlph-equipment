import 'package:nanoid/nanoid.dart';

class Equipment {
  String code = nanoid();
  String name;
  String specs;
  String description;
  String image;

  Equipment(this.name, this.specs, this.description, this.image);
}
