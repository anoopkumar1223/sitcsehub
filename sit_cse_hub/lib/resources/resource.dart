import 'package:sit_cse_hub/resources/color.dart';
import 'package:sit_cse_hub/resources/constant.dart';
import 'package:sit_cse_hub/resources/image.dart';
import 'package:sit_cse_hub/resources/navigation.dart';
import 'package:sit_cse_hub/resources/string.dart';

abstract class Resource {
  static MyColor color = MyColor();
  static MyString string = MyString();
  static MyImage image = MyImage();
  static MyConstant constant = MyConstant();
  static MyNavigation navigation = MyNavigation();
}
