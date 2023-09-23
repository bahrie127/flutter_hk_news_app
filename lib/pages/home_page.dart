import 'package:flutter/material.dart';
import 'package:flutter_hk_news_app/data/datasources/news_remote_datasource.dart';
import 'package:flutter_hk_news_app/data/models/news_response_model.dart';
import 'package:flutter_hk_news_app/pages/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  List<Article> articles = [];

  Future getArticles() async {
    setState(() {
      isLoading = true;
    });

    final response = await NewsRemoteDatasource().getArticles();
    articles = response.articles ?? [];

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Menit.com',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                final news = articles[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailPage(article: news);
                    }));
                  },
                  child: Card(
                    color: Colors.grey[50],
                    child: ListTile(
                      leading: SizedBox(
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                              news.urlToImage ?? 'https://i.pravatar.cc/300'),
                        ),
                      ),
                      title: Text(news.title ?? '-'),
                      subtitle: Text(news.description ?? '-'),
                    ),
                  ),
                );
              },
              itemCount: 20,
            ),
    );
  }
}
