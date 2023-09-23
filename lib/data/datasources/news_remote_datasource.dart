import 'package:flutter_hk_news_app/data/models/news_response_model.dart';
import 'package:http/http.dart' as http;

class NewsRemoteDatasource {
  Future<NewsResponseModel> getArticles() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla&from=2023-08-23&sortBy=publishedAt&apiKey=412c98bdbbbe4762a921933c5097bd84'));

    return NewsResponseModel.fromJson(response.body);
  }
}
