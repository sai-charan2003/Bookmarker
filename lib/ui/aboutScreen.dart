import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Aboutscreen extends StatefulWidget {
  const Aboutscreen({super.key});

  @override
  State<Aboutscreen> createState() => _AboutscreenState();
}

class _AboutscreenState extends State<Aboutscreen> {
  PackageInfo? packageInfo;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() async {
    
    final info = await PackageInfo.fromPlatform();
    
    setState(() {
      packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text("About"),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.code),
                  title: const Text("Version"),
                  subtitle: Text(
                    packageInfo != null
                        ? packageInfo!.version
                        : 'Loading...',  // Show loading message while fetching
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.book),
                  title: const Text("License"),
                  onTap: () {
                    showLicensePage(
                      context: context,
                      applicationName: packageInfo?.appName ?? "Bookmarker",
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
