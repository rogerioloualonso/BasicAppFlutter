import 'package:mysql1/mysql1.dart';

class Mysql {
  //Dados para a conexão
  final String host = '10.0.2.2';
  final int port = 3306;
  final String user = 'root';
  final String db = 'appdatabase';
  final String password = 'admin';

  //Conexão com o banco

  getSettings() {
    final connectionSettings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      db: db,
      password: password,
    );
    return connectionSettings;
  }

  getConnection() async {
    final conn = await MySqlConnection.connect(
      ConnectionSettings(
        host: host,
        port: port,
        user: user,
        db: db,
        password: password,
      ),
    );
    await conn;
    return conn;
  }
}
