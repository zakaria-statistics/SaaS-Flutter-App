import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlidingMenu extends StatefulWidget {
  final String imageUrl;
  final String username;
  final VoidCallback onSignOut;
  final VoidCallback onTapProfile;

  const SlidingMenu({
    super.key,
    required this.imageUrl,
    required this.username,
    required this.onSignOut,
    required this.onTapProfile,
  });

  @override
  _SlidingMenuState createState() => _SlidingMenuState();
}

class _SlidingMenuState extends State<SlidingMenu> {
  bool _showMenu = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end, // Align items to the right
          children: [
            Visibility(
              visible: !_showMenu,
              child: IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  setState(() {

                    _showMenu = !_showMenu;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _showMenu ? 600 : 0,
              height: _showMenu ? 1000 : 0,
              alignment: Alignment.centerRight,
              // Align the menu to the right side
              color: Colors.blue,
              child: _showMenu
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(widget.username),
                          onTap: widget.onTapProfile,
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout),
                          title: Text('Logout'),
                          onTap: widget.onSignOut,
                        ),
                      ],
                    )
                  : const SizedBox
                      .shrink(), // Hide the menu when it's not shown
            ),
          ],
        ),
      ],
    );
  }
}
