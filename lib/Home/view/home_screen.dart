import 'package:flutter/material.dart';
import 'package:flutter_application_1/Home/view_model/home_view_model.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key) {
    // Inicializar el ViewModel fuera del método build
    Get.put(HomeViewModel());
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.find<HomeViewModel>();

    final List<Map<String, dynamic>> carouselItems = [
      {
        'title': 'Consulta de Inventario',
        'icon': Icons.inventory,
        'color': Colors.blue,
        'onPressed': viewModel.consultaInventario,
      },
      {
        'title': 'Ingreso de Mercancía',
        'icon': Icons.add_box,
        'color': Colors.green,
        'onPressed': viewModel.entradaInventario,
      },
      {
        'title': 'Salida de Mercancía',
        'icon': Icons.remove_circle,
        'color': Colors.red,
        'onPressed': viewModel.salidaInventario,
      },
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => viewModel.showLogoutConfirmation(),
          ),
          title: Text('Home'),
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            CarouselSlider(
              options: CarouselOptions(
                height: 400.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16/9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: carouselItems.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: item['color'],
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 10),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: item['onPressed'],
                          borderRadius: BorderRadius.circular(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(item['icon'], size: 80.0, color: Colors.white),
                              SizedBox(height: 20),
                              Text(
                                item['title'],
                                style: TextStyle(fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: viewModel.consultaInventario,
                      child: Text('Consulta de Inventario', style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: viewModel.entradaInventario,
                      child: Text('Ingreso de Mercancía',style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: viewModel.salidaInventario,
                      child: Text('Salida de Mercancía',style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}