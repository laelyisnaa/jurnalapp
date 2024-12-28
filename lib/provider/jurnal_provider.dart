import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// Model Jurnal
class Jurnal {
  final int id;
  final String title;
  final String description;
  final DateTime date;

  Jurnal({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  // Mengubah JSON ke objek Jurnal
  factory Jurnal.fromJson(Map<String, dynamic> json) {
    return Jurnal(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }

  // Mengubah objek Jurnal ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
    };
  }
}

// JurnalProvider
class JurnalProvider extends ChangeNotifier {
  List<Jurnal> _jurnals = [];
  bool _isLoading = false;

  List<Jurnal> get jurnals => _jurnals;
  bool get isLoading => _isLoading;

  // URL API untuk CRUD
  final String apiUrl = "https://api.example.com/jurnals"; // Gantilah dengan URL API Anda

  // Fungsi untuk mengambil daftar jurnal dari API
  Future<void> fetchJurnals() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _jurnals = data.map((json) => Jurnal.fromJson(json)).toList();
      } else {
        throw Exception("Gagal memuat jurnal");
      }
    } catch (e) {
      throw Exception('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fungsi untuk menambah jurnal baru
  Future<void> addJurnal(Jurnal jurnal) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(jurnal.toJson()),
      );

      if (response.statusCode == 201) {
        _jurnals.add(Jurnal.fromJson(json.decode(response.body)));
        notifyListeners();
      } else {
        throw Exception('Gagal menambah jurnal');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fungsi untuk memperbarui jurnal
  Future<void> updateJurnal(int id, Jurnal jurnal) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(jurnal.toJson()),
      );

      if (response.statusCode == 200) {
        final index = _jurnals.indexWhere((j) => j.id == id);
        if (index != -1) {
          _jurnals[index] = jurnal;
          notifyListeners();
        }
      } else {
        throw Exception('Gagal memperbarui jurnal');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fungsi untuk menghapus jurnal
  Future<void> deleteJurnal(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$apiUrl/$id'),
      );

      if (response.statusCode == 200) {
        _jurnals.removeWhere((jurnal) => jurnal.id == id);
        notifyListeners();
      } else {
        throw Exception('Gagal menghapus jurnal');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => JurnalProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jurnal App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JurnalListPage(),
    );
  }
}

class JurnalListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Jurnal')),
      body: Consumer<JurnalProvider>(
        builder: (context, jurnalProvider, child) {
          if (jurnalProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: jurnalProvider.jurnals.length,
            itemBuilder: (context, index) {
              final jurnal = jurnalProvider.jurnals[index];
              return ListTile(
                title: Text(jurnal.title),
                subtitle: Text(jurnal.description),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await jurnalProvider.deleteJurnal(jurnal.id);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newJurnal = Jurnal(
            id: 0, // ID akan ditentukan oleh API
            title: 'Jurnal Baru',
            description: 'Deskripsi jurnal baru',
            date: DateTime.now(),
          );

          await context.read<JurnalProvider>().addJurnal(newJurnal);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
