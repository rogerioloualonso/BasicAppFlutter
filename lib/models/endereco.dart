class Endereco {
  final String id;
  final String descricao;
  final String cep;
  final String rua;
  final String numero;
  final String complemento;
  final String bairro;
  final String municipio;
  final String estado;

  const Endereco(
      {this.id = '',
      required this.descricao,
      required this.cep,
      required this.rua,
      required this.numero,
      required this.complemento,
      required this.bairro,
      required this.municipio,
      required this.estado});
}
