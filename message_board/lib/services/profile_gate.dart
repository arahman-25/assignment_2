import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileGate extends StatefulWidget {
  final User user;

  const ProfileGate({super.key, required this.user});

  @override
  State<ProfileGate> createState() => _ProfileGateState();
}

class _ProfileGateState extends State<ProfileGate> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}