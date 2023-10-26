import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Floating App Bar';
    return MaterialApp(
      home: Scaffold(
          body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text(title),
            floating: true,
            flexibleSpace: Placeholder(),
            expandedHeight: 200.0,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                      title: Text('Item #$index'),
                    ),
                childCount: 1000),
          ),
        ],
      )),
    );
  }
}
