import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsController extends GetxController {
  var articles = <Map<String, dynamic>>[].obs; // List of articles
  var selectedCategory = "general".obs; // Default category
  var isLoading = false.obs; // Loading state
  late TextEditingController searchController;

  // **🔴 Category Cache** (Prevent data loss when switching)
  var categoryCache = <String, List<Map<String, dynamic>>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    fetchArticles(); // **Load the default category**
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> fetchArticles([String query = ""]) async {
    final apiKey = "93f04e471a6642d99c6253f1b890ad33";
    final baseUrl = "https://newsapi.org/v2/top-headlines";
    final url =
        "$baseUrl?country=us&category=${selectedCategory.value}&pageSize=25&apiKey=$apiKey";

    // **🚀 Prevent Clearing Articles if Category Already Cached**
    if (categoryCache.containsKey(selectedCategory.value)) {
      articles.value = categoryCache[selectedCategory.value]!;
      return; // ✅ STOP API call, show cached data instead
    }

    try {
      isLoading.value = true;

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'ok' && data['articles'] != null) {
          // **🛠 Filter only articles with valid images**
          final List<Map<String, dynamic>> fetchedArticles = List<Map<String, dynamic>>.from(
            data['articles'].where((article) =>
                article['urlToImage'] != null &&
                article['urlToImage'].isNotEmpty &&
                article['title'] != null),
          );

          // **✅ Save data to cache & Update UI**
          if (fetchedArticles.isNotEmpty) {
            categoryCache[selectedCategory.value] = fetchedArticles; // 🔴 Store articles in cache
            articles.value = fetchedArticles;
          } else {
            // **Fallback: Fetch general articles if category is empty**
            await fetchFallbackArticles();
          }
        } else {
          await fetchFallbackArticles();
        }
      } else {
        print("API Error: ${response.statusCode} - ${response.body}");
        await fetchFallbackArticles();
      }
    } catch (e) {
      print("Error fetching news: $e");
      await fetchFallbackArticles();
    } finally {
      isLoading.value = false;
    }
  }

  // **🔄 Fetch Fallback News if No Valid Articles**
  Future<void> fetchFallbackArticles() async {
    final fallbackUrl = "https://newsapi.org/v2/top-headlines?country=us&pageSize=25&apiKey=93f04e471a6642d99c6253f1b890ad33";

    try {
      final fallbackResponse = await http.get(Uri.parse(fallbackUrl));

      if (fallbackResponse.statusCode == 200) {
        final data = json.decode(fallbackResponse.body);

        if (data['status'] == 'ok' && data['articles'] != null) {
          final List<Map<String, dynamic>> fallbackArticles = List<Map<String, dynamic>>.from(
            data['articles'].where((article) =>
                article['urlToImage'] != null &&
                article['urlToImage'].isNotEmpty &&
                article['title'] != null),
          );

          articles.value = fallbackArticles;
        } else {
          print("No fallback articles available.");
        }
      } else {
        print("Fallback API Error: ${fallbackResponse.statusCode} - ${fallbackResponse.body}");
      }
    } catch (e) {
      print("Error fetching fallback articles: $e");
    }
  }

  // **🚀 Switch Category Without Losing Previous Data**
  void switchCategory(String category) {
    if (selectedCategory.value != category) {
      selectedCategory.value = category;

      // **🚀 Show Cached Data Immediately**
      if (categoryCache.containsKey(category)) {
        articles.value = categoryCache[category]!;
      } else {
        fetchArticles(); // Fetch only if not cached
      }
    }
  }
}
