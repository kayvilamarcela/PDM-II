import 'dart:convert';

class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }

  Map<String, dynamic> toJson() {
    return {'nome': _nome};
  }
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
      'dependentes': _dependentes.map((d) => d.toJson()).toList()
    };
  }
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }

  Map<String, dynamic> toJson() {
    return {
      'projeto': _nomeProjeto,
      'funcionarios': _funcionarios.map((f) => f.toJson()).toList()
    };
  }
}

void main() {
  // Dependentes
  var depBas = Dependente("Nagyla");
  var depFech = Dependente("Milena");
  var depLara = Dependente("Marcela");

  // Funcion�rios
  var func1 = Funcionario("Katia", [depBas, depFech]);
  var func2 = Funcionario("Julya", [depLara]);
  var func3 = Funcionario("Madah", []);

  // Equipe de Projeto
  var equipe = EquipeProjeto("App Mobile X", [func1, func2, func3]);

  // Impress�o em JSON
  String jsonEquipe = jsonEncode(equipe.toJson());
    print(jsonEquipe);
}
