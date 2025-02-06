import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String id;
  final String location;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  const ProfileAppBar({
    Key? key,
    required this.name,
    required this.id,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.blue[700],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          // Name and Details
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight:  FontWeight.w700,
                      height: 16.8/14
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'ID: $id',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight:  FontWeight.w500,
                        height: 14.4/12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight:  FontWeight.w500,
                        height: 14.4/12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action Icons
          // Action Icons
          Padding(
            padding: const EdgeInsets.only(top: 8), // Added top padding to move icons down
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                  onPressed: () {},
                  padding: EdgeInsets.zero, // Reduce padding around icon
                  constraints: const BoxConstraints(minHeight: 36, minWidth: 36),
                ),
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: () async {
                    await _secureStorage.write(key: "isLogoutClicked", value: "true");
                    Navigator.pushNamed(context, '/');
                  },
                  padding: EdgeInsets.zero, // Reduce padding around icon
                  constraints: const BoxConstraints(minHeight: 36, minWidth: 36),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}