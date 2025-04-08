import 'package:flutter/material.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget{
  const TMAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        spacing: 10,
        children: [
          CircleAvatar(child: Icon(Icons.account_circle, size: 40)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ekramul Haque',
                  style: TextTheme.of(
                    context,
                  ).bodyLarge?.copyWith(color: Colors.white),
                ),
                Text(
                  'ehr.ekramul@gmail.com',
                  style: TextTheme.of(
                    context,
                  ).bodySmall?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.logout))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
