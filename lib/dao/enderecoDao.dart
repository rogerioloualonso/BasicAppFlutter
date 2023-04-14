import 'package:exemplo/models/endereco.dart';
import 'package:exemplo/mysql/mysql.dart';
import 'package:mysql1/mysql1.dart';

class EnderecoDao {
  Mysql mysql = new Mysql();

  //Retorna todos os endereços da tabela
  Future<Map<String, Endereco>> getAllEnderecos() async {
    final conn = await MySqlConnection.connect(mysql.getSettings());
    await conn;
    final results = await conn.query('SELECT * FROM appdatabase.endereco;');
    final enderecos = <String, Endereco>{};
    for (var row in results) {
      final endereco = Endereco(
        id: row['id'],
        descricao: row['descricao'],
        cep: row['cep'],
        rua: row['rua'],
        numero: row['numero'],
        complemento: row['complemento'],
        bairro: row['bairro'],
        municipio: row['municipio'],
        estado: row['estado'],
      );
      enderecos[endereco.id] = endereco;
    }
    await conn.close();
    return enderecos;
  }

  Future<void> deleteEndereco(String id) async {
    final conn = await MySqlConnection.connect(mysql.getSettings());
    await conn;

    await conn.query('DELETE FROM appdatabase.endereco WHERE id = ?', [id]);

    await conn.close();
  }

  Future<void> insertEndereco(Endereco endereco) async {
    final conn = await MySqlConnection.connect(mysql.getSettings());
    await conn;
    await conn.query('''
      INSERT INTO endereco
        (id, descricao, cep, rua, numero, complemento, bairro, municipio, estado)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', [
      endereco.id,
      endereco.descricao,
      endereco.cep,
      endereco.rua,
      endereco.numero,
      endereco.complemento,
      endereco.bairro,
      endereco.municipio,
      endereco.estado,
    ]);

    await conn.close();
  }

  Future<void> updateEndereco(Endereco endereco) async {
    final conn = await MySqlConnection.connect(mysql.getSettings());

    await conn.query('''
      UPDATE endereco
      SET descricao = ?, cep = ?, rua = ?, numero = ?, complemento = ?, bairro = ?, municipio = ?, estado = ?
      WHERE id = ?
    ''', [
      endereco.descricao,
      endereco.cep,
      endereco.rua,
      endereco.numero,
      endereco.complemento,
      endereco.bairro,
      endereco.municipio,
      endereco.estado,
      endereco.id,
    ]);

    await conn.close();
  }
}
