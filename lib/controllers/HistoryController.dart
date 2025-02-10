import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
// 
class HistoryController extends GetxController {
  var history = <Map>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  Future<void> loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedHistory = prefs.getString('history');

    if (savedHistory != null) {
      history.value = List<Map>.from(jsonDecode(savedHistory));
    }
  }

  Future<void> addToHistory(Map article) async {
    if (!history.any((item) => item['title'] == article['title'])) {
      history.add(article);
      await saveHistory();
    }
  }

  Future<void> clearHistory() async {
    history.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('history');
  }

  Future<void> saveHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('history', jsonEncode(history));
  }
}
