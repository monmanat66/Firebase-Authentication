
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/db.dart';
import '../models/registration.dart';
import 'registration_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Registration> _items = [];
  bool _loading = true;

  Future<void> _load() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final data = await AppDb.instance.getAll(uid);
    setState(() {
      _items = data;
      _loading = false;
    });
  }

  Future<void> _delete(int id) async {
    await AppDb.instance.delete(id);
    await _load();
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ลงทะเบียนกิจกรรม (local db)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _items.isEmpty
              ? const Center(child: Text('ยังไม่มีข้อมูลการลงทะเบียน'))
              : ListView.separated(
                  itemCount: _items.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final r = _items[i];
                    return ListTile(
                      title: Text('${r.studentId} • ${r.activityName}'),
                      subtitle: Text('${r.firstName} ${r.lastName} • ${r.program} • ${r.createdAt}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _delete(r.id!),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await Navigator.push<bool>(
            context,
            MaterialPageRoute(builder: (_) => const RegistrationForm()),
          );
          if (created == true) {
            _load();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
