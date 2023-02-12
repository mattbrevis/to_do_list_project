

import 'package:flutter/material.dart';

class ListTaskPage extends StatelessWidget {
  const ListTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: ((context, index) {
        return const ListTile(
            title: Text('Task '),
        );
      })),
    );
  }
}