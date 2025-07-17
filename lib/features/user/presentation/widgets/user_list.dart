import 'package:flutter/material.dart';

class UserListItem extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String avatarUrl;
  final VoidCallback? onTap;

  const UserListItem({super.key, 
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatarUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipOval(
              child: Container(
                width: 49,
                height: 49,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
                child: avatarUrl.isNotEmpty
                    ? Image.network(
                        avatarUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person,
                            color: Colors.grey[600],
                            size: 24,
                          );
                        },
                      )
                    : Icon(
                        Icons.person,
                        color: Colors.grey[600],
                        size: 24,
                      ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$firstName $lastName'.trim(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF04021D),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      color: Color(0xFF686777),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

     