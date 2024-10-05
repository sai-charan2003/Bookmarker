import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils {
   AppUtils._();
  static final AppUtils _instance = AppUtils._();
  factory AppUtils() => _instance;

bool isLinkValid(String url) {
  try {
    
    if (!url.startsWith("http://") && !url.startsWith("https://")) {
      url = "http://$url";

    }

    
    Uri uri = Uri.parse(url);

    
    return (uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https')) && uri.host.isNotEmpty;
  } catch (e) {
    
    return false;
  }
}
void launchURL(Uri url) async {
  if (!await launchUrl(url,mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
    
  } 
}
void launchInAppBrowser(Uri url) async {
    if (!await launchUrl(url,mode: LaunchMode.inAppBrowserView)) {
    throw 'Could not launch $url';
    
  } 

}

String timeMillisToDateConverter(String? timeMillis) {
  if(timeMillis !=null){
      int ts = int.parse(timeMillis!); 
      var dt = DateTime.fromMillisecondsSinceEpoch(ts); 
      var formattedDate = DateFormat('dd/MM/yyyy - hh:mm a').format(dt); 
      return formattedDate; 
  } else{
    return '';
  }

}




}