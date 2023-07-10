import 'package:get/get.dart';

class Loading extends GetxController {
  RxBool isLoading = false.obs;
  changeLoadingTrue() {
    isLoading.value = true;
  }
  changeLoadingFalse() {
    isLoading.value = false;
  }
}
