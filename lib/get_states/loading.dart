import 'package:get/get.dart';

class Loading extends GetMaterialController {
  final RxBool isLoading = false.obs;
  changeLoadingTrue() {
    isLoading.value = true;
  }
  changeLoadingFalse() {
    isLoading.value = false;
  }
}
