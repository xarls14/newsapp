import 'package:flutter/material.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget{
  
  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

//with AutomaticKeepAliveClientMixin con esto podemos hacer que el witget no se destruya y podemos volver a donde quedo la lista scrolleada
class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {

    final headlines = Provider.of<NewsService>(context).headlines;
    // ListaNoticias(headlines)
    return Scaffold(
      body: ( headlines.isEmpty)
          ? const Center(
            child: CircularProgressIndicator(),
          )

          : ListaNoticias(headlines)
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}