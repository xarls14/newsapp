
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

const _URL_NEWS = 'https://newsapi.org/v2';
const _APIKEY = 'aa3ddc29a12344e69b8c36a36c333d54';

class NewsService with ChangeNotifier{

  List<Article> headlines = [];
  String _selectedCategory = 'business';

  bool _isLoading = true;

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business') ,
    Category(FontAwesomeIcons.tv, 'entertainment') ,
    Category(FontAwesomeIcons.addressCard, 'health') ,
    Category(FontAwesomeIcons.headSideVirus, 'science') ,
    Category(FontAwesomeIcons.vials, 'sports') ,
    Category(FontAwesomeIcons.volleyball, 'technology') ,
    Category(FontAwesomeIcons.memory, 'business') ,
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService(){
    getToHeadlines();

    categories.forEach((item) { 
      categoryArticles[item.name] = List.empty(growable: true);
    });

    getArticlesByCategory( _selectedCategory );
  }

  String get selectedCategory => _selectedCategory;
  set selectedCategory( String valor ) {
    _selectedCategory = valor;

    //this._isLoading = true;
    getArticlesByCategory( valor );
    notifyListeners();
  }

  List<Article>? get getArticulosCategoriaSeleccionada => categoryArticles[ selectedCategory ];

  getToHeadlines() async {

    // final url = '$_URL_NEWS/-headlines?apiKey=$_APIKEY&country=us';
    // var url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=aa3ddc29a12344e69b8c36a36c333d54';
    // final resp = await http.get(url as Uri);
    //https://newsapi.org/v2/top-headlines?country=us&apiKey=aa3ddc29a12344e69b8c36a36c333d54

    var url = Uri.https('newsapi.org', '/v2/top-headlines', {'apiKey': _APIKEY, 'country': 'us'});
    var response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');


    final newsResponse = NewsResponse.fromJson(response.body);
    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async{

    if (categoryArticles[category]!.isNotEmpty ) {
      return categoryArticles[category];
    }

    var url = Uri.https('newsapi.org', '/v2/top-headlines', {'apiKey': _APIKEY, 'country': 'us', 'category': category});
    var response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');


    final newsResponse = NewsResponse.fromJson(response.body);
    categoryArticles[category]?.addAll(newsResponse.articles);
    notifyListeners();
  }

}