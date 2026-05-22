import 'package:flutter/material.dart';

class ListDataDay16 extends StatefulWidget {
  const ListDataDay16({super.key});

  @override
  State<ListDataDay16> createState() => _ListDataDay16State();
}

class _ListDataDay16State extends State<ListDataDay16> {
  final List<String> namaBuah = ["Apel", "Nanas", "Anggur", "Durian", "Kiwi"];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: namaBuah.length,
          itemBuilder: (BuildContext context, int index) {
            print(index);
            return Text(namaBuah[index]);
          },
        ),
      ],
    );
  }
}
