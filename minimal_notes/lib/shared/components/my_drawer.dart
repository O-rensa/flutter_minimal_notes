import "package:flutter/material.dart";
import "package:minimal_notes/settings/pages/settings_page.dart";
import "package:minimal_notes/shared/components/drawer_tile.dart";

class MyDrawer extends StatelessWidget {
  
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // drawer header
          const DrawerHeader(
            child: Icon(Icons.note),
          ),

          // notes tile
          DrawerTile(
            title: "Notes", 
            leading: const Icon(Icons.home), 
            onTap: () => Navigator.pop(context),
          ),

          // settings tile
          DrawerTile(
            title: "Settings", 
            leading: const Icon(Icons.settings), 
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                )
              );
            },
          ),
        ],
      ),
    );
  }
}