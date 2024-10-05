import 'package:bookmarker/controllers/bookmark_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:share_plus/share_plus.dart';

import '../controllers/googledrive_controller.dart';

void showMoreOptionBottomSheet(BuildContext context,dynamic entity) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      final TextEditingController urlTextEditingController = TextEditingController();
      final BookmarkController bookmarkController = Get.find<BookmarkController>();
      final GoogledriveController _googledriveController = Get.find<GoogledriveController>();

      bool isLoading = false; 
      bool isNotValidLink = false; 
      bool isButtonEnabled = false; 

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {                
          urlTextEditingController.addListener(() {
            setState(() {
              isButtonEnabled = urlTextEditingController.text.isNotEmpty;
            });
          });

          
          Future<void> deleteBookmark() async {
           bookmarkController.deleteBookmark(entity.uuid);            
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Bookmark deleted successfully"),behavior: SnackBarBehavior.floating,));
            _googledriveController.startSync();                    
            
          }  
                    
                    
                  

          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            entity.title,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              width: 100,  
                               height: 71,  
                              child: Image.network(
                                entity.imageURL,
                                fit: BoxFit.cover,                                
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: (){
                        deleteBookmark();
                      },
                        style: TextButton.styleFrom(
                          minimumSize: const Size(double.infinity,40),
                          foregroundColor: Theme.of(context).colorScheme.error
                    
                        ), 
                      child: const Row(
                        children: [
                          Icon(Icons.delete),
                          SizedBox(width: 8),
                          Text("Delete")
                        ]
                        ,),
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () async{
                        await Share.share(entity.link);
                      },
                        style: TextButton.styleFrom(
                          minimumSize: const Size(double.infinity,40),
                          
                    
                        ), 
                      child: const Row(
                        children: [
                          Icon(Icons.share),
                          SizedBox(width: 8),
                          Text("Share")
                        ]
                        ,),
                        ),
                  )
                  
                  

                ],
              ),
            ),
          );
        },
      );
    },
  );
}




