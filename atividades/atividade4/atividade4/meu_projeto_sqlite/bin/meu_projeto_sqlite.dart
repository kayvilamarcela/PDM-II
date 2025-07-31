import 'dart:io';
import 'package:sqlite3/sqlite3.dart';

void main() {
  // Open / create the database
  final db = sqlite3.open('aluno.db');

  // Create table TB_ALUNO if it doesn't exist
  db.execute('''
    CREATE TABLE IF NOT EXISTS TB_ALUNO (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome VARCHAR(50) NOT NULL
    );
  ''');

  print('Bem-vindo ao Gerenciador de Alunos!');
  while (true) {
    print('\nEscolha uma opção:');
    print('1 - Inserir novo aluno');
    print('2 - Listar alunos');
    print('0 - Sair');
    stdout.write('Opção: ');
    String? option = stdin.readLineSync();

    if (option == '1') {
      inserirAluno(db);
    } else if (option == '2') {
      listarAlunos(db);
    } else if (option == '0') {
      print('Saindo...');
      db.dispose();
      break;
    } else {
      print('Opção inválida. Tente novamente.');
    }
  }
}

void inserirAluno(Database db) {
  stdout.write('Digite o nome do aluno (máx. 50 caracteres): ');
  String? nome = stdin.readLineSync();

  if (nome == null || nome.trim().isEmpty) {
    print('Nome não pode ser vazio.');
    return;
  }

  if (nome.length > 50) {
    print('Nome muito longo. Limite: 50 caracteres.');
    return;
  }

  // Insert aluno into the table safely
  final stmt = db.prepare('INSERT INTO TB_ALUNO (nome) VALUES (?)');
  try {
    stmt.execute([nome.trim()]);
    print('Aluno "$nome" inserido com sucesso.');
  } catch (e) {
    print('Erro ao inserir aluno: $e');
  } finally {
    stmt.dispose();
  }
}

void listarAlunos(Database db) {
  final ResultSet resultSet = db.select('SELECT id, nome FROM TB_ALUNO');

  if (resultSet.isEmpty) {
    print('Nenhum aluno encontrado.');
    return;
  }

  print('\nLista de Alunos:');
  for (final row in resultSet) {
    print('ID: ${row['id']} - Nome: ${row['nome']}');
  }
}