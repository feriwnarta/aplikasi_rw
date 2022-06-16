import '../server-app.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CardNews {
  final String urlImageNews, caption, content, writerAndTime;

  CardNews({this.urlImageNews, this.caption, this.content, this.writerAndTime});
}

class NewsServices {
  static Stream<List<CardNews>> getNews(String idUser) async* {
    String url = '${ServerApp.url}src/news/news.php';
    var data = {'id_user': idUser};

    http.Response response = await http.post(url, body: jsonEncode(data));
    var obj = jsonDecode(response.body) as List;
    yield obj
        .map((item) => CardNews(
            caption: item['caption'],
            content: item['content'],
            urlImageNews: item['url_news_image'],
            writerAndTime: item['writer'] + ',  ' + item['time']))
        .toList();
  }
}
