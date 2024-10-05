import 'package:bookmarker/ui/aboutScreen.dart';
import 'package:bookmarker/ui/backupScreen.dart';
import 'package:bookmarker/utils/SharedPrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settingsscreen extends StatefulWidget {
  const Settingsscreen({super.key});

  @override
  State<Settingsscreen> createState() => _SettingsscreenState();
}

class _SettingsscreenState extends State<Settingsscreen> {
  var isInAppBrowser = false.obs;
  var isMiniCard = false.obs;
  @override
  void initState() {
    
    super.initState();
    isInAppBrowser.value = Sharedprefhelper.getIsInAppBrowser() ?? false;
    isMiniCard.value = Sharedprefhelper.getIsInMiniCard() ?? false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text("Settings"),
          ),      
          SliverToBoxAdapter(
            child: Column(
              children: [
                ListTile(                  
                  leading: const Icon(Icons.backup),
                  title: const Text("Backup"),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const Backupscreen()));
                  },
                ),
                const Padding(
                      padding: const EdgeInsets.only(right: 8,left: 8),
                      child: const Divider(),
                      ),
                Obx(
                   () {
                    return ListTile(
                      onTap: (){
                        isInAppBrowser.value = !isInAppBrowser.value;
                        Sharedprefhelper.setIsInAppBrowser(isInAppBrowser.value);

                      },
                      leading: const Icon(Icons.language),
                      title: const Text("In-app browser"),
                      trailing: Switch(
                        thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                            (Set<WidgetState> states) {
                          if (isInAppBrowser.value) {
                            return const Icon(Icons.done);
                          } else {
                            return const Icon(Icons.close);
                          }
                        }),
                        value: isInAppBrowser.value,
                        onChanged: (bool value) async {
                          isInAppBrowser.value = value;
                          Sharedprefhelper.setIsInAppBrowser(value);
                        } 
                      ),
                    );
                  }
                ),
                const Padding(
                      padding: const EdgeInsets.only(right: 8,left: 8),
                      child: const Divider(),
                      ),
                Obx(
                   () {
                    return ListTile(
                      onTap: (){
                        isMiniCard.value = !isMiniCard.value;
                        Sharedprefhelper.setIsMiniCard(isMiniCard.value);

                      },
                      leading: const Icon(Icons.view_list),
                      title: const Text("Mini Card"),
                      trailing: Switch(
                        thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                            (Set<WidgetState> states) {
                          if (isMiniCard.value) {
                            return const Icon(Icons.done);
                          } else {
                            return const Icon(Icons.close);
                          }
                        }),
                        value: isMiniCard.value,
                        onChanged: (bool value) async {
                          isMiniCard.value = value;
                          Sharedprefhelper.setIsMiniCard(value);
                        } 
                      ),
                    );
                  }
                ),
                const Padding(
                  padding: const EdgeInsets.only(right: 8,left: 8),
                  child: Divider(),
                ),
                 ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text("About"),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const Aboutscreen()));
                  },
                ),
                


              ],
      
            ),
          )
          
        ],
      ),
    );
  }
}