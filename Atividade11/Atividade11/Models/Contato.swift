// para criar esse arquivo
// com o botao direito na atividade1, criar um new group com nome models
// criar no models um new file swift file Contato
protocol ContatoProtocol {
    func criar(contato: Contato)
    func alterar(contato: Contato)
    func excluir(id: String)
    func obterTodos() -> [Contato]
}

//Codable é um typealias(apelido) de encodable + decodable
struct Contato: Encodable, Decodable{
    var id: String
    var nome: String
    var email: String
    var celular: String
    var endereco: String
    var numero: String
}
