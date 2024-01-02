import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Weather {
  rainy,
  windy,
  sunny,
}

@immutable
class HomePageViewModel {
  const HomePageViewModel();
  Future<Weather> load() async {
    await Future.delayed(const Duration(seconds: 10));
    return Weather.sunny;
  }
}

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  final HomePageViewModel viewModel = const HomePageViewModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CupertinoPageScaffold(
        child: FutureBuilder<Weather>(
          future: viewModel.load(), 
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Text(
                  snapshot.data.toString()
                ),
              );
            } else {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
        })),
      );
  }
}
