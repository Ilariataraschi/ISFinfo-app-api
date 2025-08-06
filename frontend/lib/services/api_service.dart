import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/models/note.dart';

class ApiService {
  static const String baseUrl = 'https://isfinfo-app-api.onrender.com/api/notes';

  static Future<void> addNote(Note note) async {
    print("🔵 Invio richiesta POST con nota: ${note.toJson()}");

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(note.toJson()),
    );

    print("🔵 Status code POST: ${response.statusCode}");
    print("🔵 Response body: ${response.body}");

    if (response.statusCode != 201) {
      throw Exception('Errore nella creazione della nota');
    }
  }

  static Future<void> updateNote(Note note) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${note.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(note.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Errore nell\'aggiornamento della nota');
    }
  }

  static Future<void> deleteNote(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Errore nella cancellazione della nota');
    }
  }

  static Future<List<Note>> getAllNotes() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Note.fromJson(json)).toList();
    } else {
      throw Exception('Errore nel caricamento delle note');
    }
  }
}
