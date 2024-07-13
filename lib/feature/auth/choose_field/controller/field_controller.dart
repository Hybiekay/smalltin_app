import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smalltin/apis/field_controller.dart';
import 'package:smalltin/feature/auth/choose_field/model/field_model.dart';

class FieldsController extends GetxController {
  final FieldApi _fieldApi = FieldApi();
  List<Field> fields = [];

  final box = GetStorage();

  @override
  void onInit() {
    fields.clear();
    var ff = box.read("fields");
    if (ff != null) {
      var fieldRessponse = FieldResponse.fromJson(ff);
      fields.addAll(fieldRessponse.fields);
    } else {
      getAppFields();
    }

    super.onInit();
  }

  refreshfields() async {
    fields.clear();
    var ff = box.read("fields");
    if (ff != null) {
      var fieldRessponse = FieldResponse.fromJson(ff);
      fields.addAll(fieldRessponse.fields);
      update();
    } else {
      await getAppFields();
    }
  }

  getAppFields() async {
    var res = await _fieldApi.getAllFields();
    if (res != null && res.statusCode == 200) {
      var data = json.decode(res.body);
      var fieldRessponse = FieldResponse.fromJson(data);
      fields.addAll(fieldRessponse.fields);
      update();
      await box.write("fields", fields);

      log(fieldRessponse.message);
    }
  }
}
