import 'package:get/get.dart';
import '../view_model/edit_product_view_model.dart';

class EditProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProductViewModel>(() => EditProductViewModel());
  }
}
