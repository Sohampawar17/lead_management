import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewmodel>.reactive(
      viewModelBuilder: () => HomeViewmodel(),
      onViewModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
      appBar: AppBar(
title:const Text('Home Screen'),
centerTitle: true,
      ),
      body: Container(

      ),
    ));
  }
}