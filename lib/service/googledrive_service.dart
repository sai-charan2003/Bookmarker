import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;

class GoogleDriveService {
  final _googleSignIn = GoogleSignIn.standard(scopes: [drive.DriveApi.driveAppdataScope]);
  
  Future<GoogleSignInAccount?> getCurrentUserDetails() async{
    return _googleSignIn.signInSilently();
  }

  Future<drive.DriveApi?> getDriveAPIClient(GoogleSignInAccount? currentUser) async{
    drive.DriveApi? driveApi;    
    if(currentUser != null){
      final client = GoogleHttpClient(await currentUser.authHeaders);
      driveApi = drive.DriveApi(client);
    }
    return driveApi;
  }

  Future<GoogleSignInAccount?> google_sign_in() async{
    return _googleSignIn.signIn();

  }

  Future<bool> google_sign_out() async {
    try{
      _googleSignIn.signOut();
      return true;
    } catch(e){
      return false;
    }
  }


}

class GoogleHttpClient extends http.BaseClient {
  final Map<String, String> headers;

  final http.Client _inner = http.Client();

  GoogleHttpClient(this.headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _inner.send(request..headers.addAll(headers));
  }

  @override
  void close() {
    _inner.close();
  }
}