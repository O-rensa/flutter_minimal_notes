import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:minimal_notes/themes/theme_provider.dart";
import "package:provider/provider.dart";

class SettingsPage extends StatelessWidget {
  
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        margin:  const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),


        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
          children: [
            // dark mode
            const Text("Dark Mode"),
        
            // switch toggle
            CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode, 
              onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
            ),
          ],
        ),
      )
    );
  }
}