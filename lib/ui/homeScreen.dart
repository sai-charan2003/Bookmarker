
import 'package:bookmarker/controllers/bookmark_controller.dart';
import 'package:bookmarker/controllers/googledrive_controller.dart';
import 'package:bookmarker/ui/AddBookmark.dart';
import 'package:bookmarker/ui/moreoptionsbottomsheet.dart';
import 'package:bookmarker/ui/settingsScreen.dart';
import 'package:bookmarker/utils/AppUtils.dart';
import 'package:bookmarker/utils/SharedPrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final ValueNotifier<bool> _isFABVisible = ValueNotifier<bool>(true);
  
  static const platform = MethodChannel('app.channel.shared.data');
  final _bookmarkController = Get.find<BookmarkController>();
  final _googledriveController = Get.find<GoogledriveController>();
  final _isMiniCard = false.obs;

  @override
  void initState() {
    super.initState();

    getSharedText();  
    fetchData(); 
    _loadCardPreference();
    
  }

  @override
  void dispose() {
    _isFABVisible.dispose();
    super.dispose();
  }

    @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
    SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Theme.of(context).colorScheme.surface  ,
      systemNavigationBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark
    ),
    
    
  );
   
    
   
  }

  void _loadCardPreference() async {
    bool isMiniCard = Sharedprefhelper.getIsInMiniCard() ?? false;     
    _isMiniCard.value = isMiniCard; 
  }


  void fetchData() async{    
    var currentUser = await _googledriveController.getCurrentUserDetails();
    var googleDriveAPI = await _googledriveController.getDriveAPIClient(currentUser);
    if(googleDriveAPI!=null){
      var data = await _googledriveController.startSync();  

      if(data !=null){
        _bookmarkController.insertBookmarkDataList(data);
      }
      
    } 
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _isFABVisible, 
        builder: (context, isVisible, child) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.elasticIn,
            switchOutCurve: Curves.elasticOut,
            child: isVisible
                ? FloatingActionButton.extended(
                    key: const ValueKey("fab"),
                    onPressed: () {
                      showAddBookmarkBottomSheet(context,null);
                    },
                    label: const Text("Add Bookmark"),
                    icon: const Icon(Icons.add),
                  )
                : const SizedBox.shrink(),
          );
        },
      ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            _isFABVisible.value = true;
          } else if (notification.direction == ScrollDirection.reverse) {
            _isFABVisible.value = false;
          }
          return true;
        }, 
        child: CustomScrollView(
          slivers: [
              SliverAppBar.large(
                title: const Text("Bookmarks"),
                actions: <Widget>[
                  MenuAnchor(
                    builder: (BuildContext context, MenuController controller, Widget? child){
                      return IconButton(
                        onPressed: (){
                          if(controller.isOpen){
                            controller.close();
                          } else{
                            controller.open();
                          }
                        }, 
                        icon: const Icon(Icons.more_vert));

                    },
                    menuChildren:[
                      MenuItemButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const Settingsscreen()));
                        },
                        child: Text("Settings"),
                      )
                    ] )

                ],
              ),

            StreamBuilder(
              stream: _bookmarkController.getAllBookmarksStream(),
              builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return SliverFillRemaining(
                    child: Center(child: Text('Error: ${snapshot.error}')),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: Text('No bookmarks added')),
                  );
                } else {
                  return SliverList(                
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {                        
                            return Column(
                                children: [
                                  Sharedprefhelper.getIsInMiniCard()==true ? miniCard(item: snapshot.data![index],
                                   onClick: (String value) { 
                                       if(Sharedprefhelper.getIsInAppBrowser()==true){
                                        AppUtils().launchInAppBrowser(Uri.parse(value));
                                      } else{
                                        AppUtils().launchURL(Uri.parse(snapshot.data![index].link));                              
                                      }
                            
                                   },):
                                   LargeCard(item: snapshot.data![index], onClick: (String value){
                                        if(Sharedprefhelper.getIsInAppBrowser()==true){
                                        AppUtils().launchInAppBrowser(Uri.parse(value));
                                      } else{
                                        AppUtils().launchURL(Uri.parse(snapshot.data![index].link));                              
                                      }
                            
                                   })
                                   ,
                                  
                                  const Padding(
                                    padding: EdgeInsets.only(right: 8,left: 8),
                                    child: Divider(),
                                  )
                                ],
                              );


                      },
                      childCount: snapshot.data!.length,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getSharedText() async {
    var sharedData = await platform.invokeMethod('getSharedText');
    if (sharedData != null) {
      showAddBookmarkBottomSheet(context,sharedData);
    }
  }
}

class miniCard extends StatelessWidget {
  miniCard({
    super.key,
    required this.item,
    required this.onClick
  });
  dynamic item;
  final ValueChanged<String> onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
    borderRadius: BorderRadius.circular(10),
    onTap: (){
      onClick(item.link);

      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom:8),
            child: Row(
              children: [                                      
                Expanded(
                  flex: 2,  
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item.title,style: Theme.of(context).textTheme.titleMedium,),
                  ),
                ),                                    
                Expanded(
                  flex: 1,  
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 100,  
                        height: 71,  
                        child: Image.network(
                          item.imageURL!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item.hostURL,
                    
                    ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showMoreOptionBottomSheet(context, item);
                }, 
                icon: const Icon(Icons.more_vert),
              )
            ],
          ),
        ],
      ),
    );
  }
}
class LargeCard extends StatelessWidget {
  LargeCard({
    super.key,
    required this.item,
    required this.onClick,
  });
  
  final dynamic item;
  final ValueChanged<String> onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        onClick(item.link);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:10,right:10,bottom: 10,top:10),
            child: SizedBox(
              width: double.infinity,
              height: 220,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: item.imageURL != null
                    ? Image.network(
                        item.imageURL!,
                        fit: BoxFit.cover,
                      )
                    : const Placeholder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item.title ?? 'No title',  // Handle null title
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item.hostURL ?? 'Unknown host'),
                ),
              ),
              IconButton(
                onPressed: () {
                  showMoreOptionBottomSheet(context, item);
                }, 
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
