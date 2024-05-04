// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const baseUrl = "http://192.168.255.242:3000/";
ValueNotifier notes = ValueNotifier([]);

addNote(Map<String, dynamic> data) async {
  try {
    await http.post(
      Uri.parse("${baseUrl}addNode"),
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );
    await getAllNotes();
    notes.notifyListeners();
  } catch (e) {
    debugPrint(e.toString());
  }
}

getAllNotes() async {
  try {
    final req = await http.get(
      Uri.parse("${baseUrl}getAllNotes"),
    );
    notes.value = await jsonDecode(req.body);
  } catch (e) {
    debugPrint(e.toString());
  }
}

Future<List> getNotes() async {
  try {
    final req = await http.get(
      Uri.parse("${baseUrl}getAllNotes"),
    );
    notes.value = await jsonDecode(req.body);
    List no = notes.value;
    return no;
  } catch (e) {
    debugPrint(e.toString());
  }
  return [];
}

updateNote(Map<String, dynamic> data) async {
  try {
    await http.post(
      Uri.parse("${baseUrl}updateNote/${data["id"]}"),
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );
    await getAllNotes();
    notes.notifyListeners();
  } catch (e) {
    debugPrint(e.toString());
  }
}

deleteNote(Map<String, dynamic> data) async {
  try {
    await http.post(
      Uri.parse("${baseUrl}deleteNote/${data["id"]}"),
      headers: {"Content-Type": "application/json"},
    );
    await getAllNotes();
    notes.notifyListeners();
  } catch (e) {
    debugPrint(e.toString());
  }
}
