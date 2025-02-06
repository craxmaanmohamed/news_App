import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import 'article_detail.dart';


class HomePage extends StatelessWidget {
  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: newsController.searchController,
              decoration: InputDecoration(
                hintText: "Search news...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) => newsController.fetchArticles(value),
            ),
          ),

          // Categories
          Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                categoryButton("All"),
                categoryButton("business"),
                categoryButton("health"),
                categoryButton("science"),
                categoryButton("sports"),
                categoryButton("technology"),
              ],
            ),
          ),

          // Articles with loading animation
          Expanded(
            child: Obx(() {
              if (newsController.isLoading.value) {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) => skeletonLoader(), // Show skeleton loader
                );
              }

              if (newsController.articles.isEmpty) {
                return Center(child: Text("No articles available for this category."));
              }

              return ListView.builder(
                itemCount: newsController.articles.length,
                itemBuilder: (context, index) {
                  final article = newsController.articles[index];
                  return newsCard(article);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget categoryButton(String category) {
    return GestureDetector(
      onTap: () {
        newsController.switchCategory(category); // Switch category and fetch articles
      },
      child: Obx(() {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            color: newsController.selectedCategory.value == category
                ? Colors.blue
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              category[0].toUpperCase() + category.substring(1),
              style: TextStyle(
                color: newsController.selectedCategory.value == category
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget newsCard(Map article) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ArticleDetailScreen(article: article));
      },
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            article['urlToImage'] != null
                ? Image.network(
                    article['urlToImage'],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return fallbackImage(); // Fallback for invalid images
                    },
                  )
                : fallbackImage(), // Fallback if no image URL is provided
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                article['title'] ?? "No Title",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            if (article['author'] != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "By ${article['author']}",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // Skeleton loader for loading animation
  Widget skeletonLoader() {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[300],
            ),
            SizedBox(height: 10),
            Container(
              height: 20,
              width: double.infinity,
              color: Colors.grey[300],
            ),
            SizedBox(height: 5),
            Container(
              height: 20,
              width: 150,
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }

  // Fallback image for articles without a proper image
  Widget fallbackImage() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey[300],
      child: Icon(
        Icons.image_not_supported,
        size: 50,
        color: Colors.grey[700],
      ),
    );
  }
}
