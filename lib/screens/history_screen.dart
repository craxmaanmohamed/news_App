

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/HistoryController.dart';
import 'article_detail.dart'; // Import the ArticleDetailScreen

class HistoryScreen extends StatelessWidget {
  final HistoryController historyController = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("History", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Readed History",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    final shouldClear = await Get.defaultDialog<bool>(
                      title: "Clear History",
                      middleText: "Are you sure you want to clear your reading history?",
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(result: false),
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Get.back(result: true),
                          child: Text("Clear All"),
                        ),
                      ],
                    );

                    if (shouldClear == true) {
                      historyController.clearHistory();
                    }
                  },
                  icon: Icon(Icons.delete, color: Colors.white),
                  label: Text("Clear All", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (historyController.history.isEmpty) {
                return Center(child: Text("No articles read yet."));
              }
              return ListView.builder(
                itemCount: historyController.history.length,
                itemBuilder: (context, index) {
                  final article = historyController.history[index];
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      leading: article['urlToImage'] != null
                          ? Image.network(
                              article['urlToImage'],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.image_not_supported,
                              size: 60,
                              color: Colors.grey,
                            ),
                      title: Text(article['title'] ?? "No Title"),
                      subtitle: Text("By ${article['author'] ?? 'Unknown'}"),
                      onTap: () {
                        // Navigate directly to ArticleDetailScreen
                        Get.to(() => ArticleDetailScreen(article: article));
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
