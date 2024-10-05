// To parse this JSON data, do
//
//     final bookmarkData = bookmarkDataFromJson(jsonString);

import 'dart:convert';

List<BookmarkData> bookmarkDataFromJson(String str) => List<BookmarkData>.from(json.decode(str).map((x) => BookmarkData.fromJson(x)));

String bookmarkDataToJson(List<BookmarkData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookmarkData {    
    String? link;
    String? title;
    String? addedDate;
    String? imageUrl;
    String? hostUrl;
    String? uuid;

    BookmarkData({        
        this.link,
        this.title,
        this.addedDate,
        this.imageUrl,
        this.hostUrl,
        this.uuid
    });

    factory BookmarkData.fromJson(Map<String, dynamic> json) => BookmarkData(        
        link: json["link"],
        title: json["title"],
        addedDate: json["addedDate"],
        imageUrl: json["imageURL"],
        hostUrl: json["hostURL"],
        uuid: json["uuid"]
    );

    Map<String, dynamic> toJson() => {        
        "link": link,
        "title": title,
        "addedDate": addedDate,
        "imageURL": imageUrl,
        "hostURL": hostUrl,
        "uuid" : uuid
    };
}
