import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/styles.dart';
import 'package:note_app/utils.dart';

Widget noteCard(Function()? onTap,QueryDocumentSnapshot doc){
  final int colorId = int.parse(doc["color_id"]);
  final DateTime creationDate = DateTime.parse(doc["creation_date"]);
  return InkWell(
onTap: onTap,
child: Card(
  elevation: 8,
  child:   Container(
  
    padding: const EdgeInsets.all(8),
  
    margin: const EdgeInsets.all(8),
  
    decoration: BoxDecoration(
  
      color: AppStyle.cardColor[colorId],
  
      borderRadius: BorderRadius.circular(8)
  
    ),
  
    child: Column(
  
      crossAxisAlignment: CrossAxisAlignment.start,
  
      children: [
  
        Text(doc["note_title"],
  
        style: AppStyle.mainTitle,),
  
         Text(Utils.formatDate(creationDate),
  
        style: AppStyle.dateTitle,),
  
         Text(doc["note_content"],
         maxLines: 3,
  
        style: AppStyle.mainContent,
  
        overflow: TextOverflow.ellipsis,),
  
        
  
      ],
  
    ),
  
  ),
),
  );
}