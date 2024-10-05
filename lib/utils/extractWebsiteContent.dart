
import 'package:bookmarker/models/website_model';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;


Future<WebsiteData?> extractWebsiteData(String url) async {
  try {
    
    if (!url.startsWith("http://") && !url.startsWith("https://")) {
      url = "http://$url";
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var document = html_parser.parse(response.body);

      
      var title = document.querySelector('title')?.text ?? url;

      
      var imageElement = document.querySelector('meta[property="og:image"]');
      var uri = Uri.parse(url);

      
      var imageUrl = imageElement?.attributes['content']?.isNotEmpty == true
          ? imageElement!.attributes['content']
          : 'https://icon.horse/icon/${uri.host}'; 

     
      if (imageUrl != null && imageUrl.startsWith('/')) {
        imageUrl = '${uri.scheme}://${uri.host}$imageUrl';
      }
      var hostURL = uri.host;

      
      var dateElement = document.querySelector('meta[property="article:published_time"]');
      var publishedDate = dateElement != null
          ? dateElement.attributes['content'] ?? 'No Published Date Found'
          : 'No Published Date Found';

      
      return WebsiteData(
        title: title,
        imageUrl: imageUrl ?? 'No Image Found', 
        publishedDate: publishedDate,
        hostURL: hostURL
      );
    } else {
      print('Failed to load webpage');
      return null;
    }
  } catch (e) {
    print('Error fetching website data: $e');
    return null;
  }
}
