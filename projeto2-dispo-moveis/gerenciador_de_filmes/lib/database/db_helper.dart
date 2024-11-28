import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/filme.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'filmes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE filmes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            urlImagem TEXT NOT NULL,
            titulo TEXT NOT NULL,
            genero TEXT NOT NULL,
            faixaEtaria TEXT NOT NULL,
            duracao INTEGER NOT NULL,
            pontuacao REAL NOT NULL,
            descricao TEXT,
            ano INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  // CRUD
  Future<int> inserirFilme(Filme filme) async {
    final db = await database;
    return await db.insert('filmes', filme.toMap());
  }

  Future<List<Filme>> listarFilmes() async {
    final db = await database;
    final maps = await db.query('filmes');
    return maps.map((map) => Filme.fromMap(map)).toList();
  }

  Future<int> atualizarFilme(Filme filme) async {
    final db = await database;
    return await db.update(
      'filmes',
      filme.toMap(),
      where: 'id = ?',
      whereArgs: [filme.id],
    );
  }

  Future<int> deletarFilme(int id) async {
    final db = await database;
    return await db.delete('filmes', where: 'id = ?', whereArgs: [id]);
  }
}
