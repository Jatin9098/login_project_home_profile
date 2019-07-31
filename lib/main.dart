// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class ExpansionTileSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ExpansionTile'),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              EntryItem(data[index]),
          itemCount: data.length,
        ),
      ),
    );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  
  final String title;
  final List<Entry> children;

  Entry(this.title, [this.children = const <Entry>[]]);

}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    'Chapter A',
    <Entry>[
      Entry('Section A0'),
      Entry('Section A1'),
      Entry('Section A2'),
    ],
  ),
  Entry(
    'Chapter B',
    <Entry>[
      Entry('Section B0'),
      Entry('Section B1'),
    ],
  ),
  Entry(
    'Chapter C',
    <Entry>[
      Entry('Section C0'),
      Entry('Section C1'),
      Entry('Section C2',),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) 
      return ListTile(title: Text(root.title));
    
    return GestureDetector(
      onTap: (){
      

        var title = root.children[0].title;
       
        if(title.contains("Section A0")){
          print("MAtchecd");
        }
        else{
          print("Not matched");
        }

        print("$title");

      },
          child: Container(
        
        child: ExpansionTile(
          
          key: PageStorageKey<Entry>(root),
          title: Text(root.title,),
          children: root.children.map(_buildTiles).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return _buildTiles(entry);
  }
}

void main() {
  runApp(ExpansionTileSample());
}