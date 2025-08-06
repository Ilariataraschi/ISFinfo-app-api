import 'package:flutter/material.dart';
import 'package:frontend/models/note.dart'; // Assicurati che il percorso sia corretto
import 'package:frontend/services/api_service.dart'; // importa l'API service

class NotesProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  Future<void> addNote(Note newNote) async {
    _notes.add(newNote);
    notifyListeners(); // aggiorna subito la UI

    try {
      await ApiService.addNote(newNote); // salva anche su MongoDB
    } catch (e) {
      print("Errore durante il salvataggio della nota su API: $e");
    }
  }

  Future<void> updateNote(Note updatedNote) async {
    final index = _notes.indexWhere((note) => note.id == updatedNote.id);
    if (index != -1) {
      _notes[index] = updatedNote;
      notifyListeners(); // aggiorna la UI

      try {
        await ApiService.updateNote(updatedNote); // aggiorna su MongoDB
      } catch (e) {
        print("Errore durante l'aggiornamento della nota su API: $e");
      }
    }
  }

  Future<void> deleteNote(Note noteToDelete) async {
    _notes.removeWhere((note) => note.id == noteToDelete.id);
    notifyListeners(); // aggiorna subito la UI

    try {
      // Correzione: usa ! per indicare che id non è nullo
      await ApiService.deleteNote(noteToDelete.id!); // elimina da MongoDB
    } catch (e) {
      print("Errore durante l'eliminazione della nota su API: $e");
    }
  }

  // (Opzionale) Caricare le note da MongoDB
  Future<void> fetchNotes() async {
    try {
      final fetchedNotes = await ApiService.getAllNotes();
      _notes = fetchedNotes;
      notifyListeners();
    } catch (e) {
      print("Errore durante il recupero delle note da API: $e");
    }
  }
}
