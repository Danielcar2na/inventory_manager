import 'package:flutter/material.dart';
import 'package:flutter_application_1/Home/view_model/home_view_model.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key) {
    Get.put(HomeViewModel());
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.find<HomeViewModel>();
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.logout),
            onPressed: viewModel.showLogoutConfirmation,
          ),
          title: const Text('Home'),
        ),
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildCarousel(viewModel, screenSize),
              const SizedBox(height: 20),
              _buildButtons(viewModel),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel(HomeViewModel viewModel, Size screenSize) {
    final List<Map<String, dynamic>> carouselItems = [
      {
        'title': 'Inventory Query',
        'icon': Icons.inventory,
        'color': Colors.blue,
        'onPressed': viewModel.queryInventory,
      },
      {
        'title': 'Stock Input',
        'icon': Icons.add_box,
        'color': Colors.green,
        'onPressed': viewModel.inputStock,
      },
      {
        'title': 'Stock Output',
        'icon': Icons.remove_circle,
        'color': Colors.red,
        'onPressed': viewModel.outputStock,
      },
    ];

    return CarouselSlider.builder(
      itemCount: carouselItems.length,
      itemBuilder: (context, index, realIndex) {
        final item = carouselItems[index];
        return _buildCarouselItem(item, screenSize);
      },
      options: CarouselOptions(
        height: screenSize.height * 0.5,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16/9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
    );
  }

  Widget _buildCarouselItem(Map<String, dynamic> item, Size screenSize) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: screenSize.width * 0.8,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: item['color'],
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
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
              Icon(item['icon'], size: screenSize.width * 0.15, color: Colors.white),
              const SizedBox(height: 20),
              Text(
                item['title'],
                style: const TextStyle(fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(HomeViewModel viewModel) {
    final buttonStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    );

    return Column(
      children: [
        ElevatedButton(
          onPressed: viewModel.queryInventory,
          style: buttonStyle.copyWith(),
          child: const Text('Inventory Query'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: viewModel.inputStock,
          style: buttonStyle.copyWith(),
          child: const Text('Stock Input'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: viewModel.outputStock,
          style: buttonStyle.copyWith(),
          child: const Text('Stock Output'),
        ),
      ],
    );
  }
}