
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/db.dart';
import '../models/registration.dart';
import 'package:intl/intl.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _studentId = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _program = TextEditingController();
  final _activity = TextEditingController();

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final now = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    final data = Registration(
      id: null,
      studentId: _studentId.text.trim(),
      firstName: _firstName.text.trim(),
      lastName: _lastName.text.trim(),
      program: _program.text.trim(),
      activityName: _activity.text.trim(),
      createdAt: now,
      userUid: uid,
    );
    await AppDb.instance.insert(data);
    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เพิ่มการลงทะเบียน')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _studentId,
                decoration: const InputDecoration(labelText: 'รหัสนักศึกษา'),
                validator: (v) => (v==null || v.trim().isEmpty) ? 'กรอกรหัสนักศึกษา' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _firstName,
                decoration: const InputDecoration(labelText: 'ชื่อ'),
                validator: (v) => (v==null || v.trim().isEmpty) ? 'กรอกชื่อ' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _lastName,
                decoration: const InputDecoration(labelText: 'นามสกุล'),
                validator: (v) => (v==null || v.trim().isEmpty) ? 'กรอกนามสกุล' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _program,
                decoration: const InputDecoration(labelText: 'หลักสูตร'),
                validator: (v) => (v==null || v.trim().isEmpty) ? 'กรอกหลักสูตร' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _activity,
                decoration: const InputDecoration(labelText: 'ชื่อกิจกรรม'),
                validator: (v) => (v==null || v.trim().isEmpty) ? 'กรอกชื่อกิจกรรม' : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _save,
                  child: const Text('บันทึก'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
