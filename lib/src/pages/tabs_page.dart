
import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tab1_page.dart';
import 'package:newsapp/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ( _ ) => _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (i) => navegacionModel.paginaActual = i,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined), label: 'Para ti'),
        BottomNavigationBarItem(icon: Icon(Icons.public),label: 'Encabezados'),
      ],
    );
  }
}

class _Paginas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      physics: const NeverScrollableScrollPhysics(),//bloqueamos la fisica del scroll
      children: [
        Tab1Page(),
    
        Tab2Page(),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier{

  int _paginaActual = 0;
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual(int valor){
    this._paginaActual = valor;
    _pageController.animateToPage(
      valor,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut
    );
    notifyListeners();
  }

  PageController get pageController => this._pageController;

}