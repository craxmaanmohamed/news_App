
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/HistoryController.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Map article;

  ArticleDetailScreen({Key? key, required this.article}) : super(key: key);

  final HistoryController historyController = Get.find();

  @override
  Widget build(BuildContext context) {
    // Save article to history when viewed
    historyController.addToHistory(article);

    return Scaffold(
      appBar: AppBar(
        title: Text("Happy Reading", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article['urlToImage'] != null)
              Image.network(
                article['urlToImage'],
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 16),
            Text(
              article['title'] ?? "No Title",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            if (article['author'] != null)
              Text(
                "By ${article['author']}",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            SizedBox(height: 16),
            Text(
              article['content']?.split('[')[0] ?? "No Content Available.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final url = article['url'];
                  if (url != null && await canLaunch(url)) {
                    await launch(url);
                  } else {
                    Get.snackbar(
                      "Error",
                      "Could not open the article.",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                child: Text(
                  "Read Full Article",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

