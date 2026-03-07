import 'dart:io';

import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/user_model.dart';
import 'add_user_screen.dart';
import 'update_user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UserModel> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final data = await DatabaseHelper.instance.getUsers();
    if (!mounted) return;
    setState(() {
      users = data;
      isLoading = false;
    });
  }

  Future<void> _goToAddUser() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddUserScreen()),
    );
    await _loadUsers();
  }

  Future<void> _goToUpdateUser(UserModel user) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => UpdateUserScreen(user: user)),
    );
    await _loadUsers();
  }

  Future<void> _deleteUser(int id) async {
    await DatabaseHelper.instance.deleteUser(id);
    await _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : users.isEmpty
              ? const Center(child: Text('No users found'))
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 90),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: ListTile(
                        leading: user.image != null && user.image!.isNotEmpty
                            ? CircleAvatar(
                                backgroundImage: FileImage(File(user.image!)),
                              )
                            : const CircleAvatar(child: Icon(Icons.person)),
                        title: Text(user.name),
                        subtitle: Text(
                          'Email: ${user.email}\nGender: ${user.gender}',
                        ),
                        isThreeLine: true,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => _goToUpdateUser(user),
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () => _deleteUser(user.id!),
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToAddUser,
        label: const Text('Add User'),
      ),
    );
  }
}
