// para criar esse arquivo
// com o botao direito na atividade1, criar um new group com nome factory
// criar no factory um new file swift file ContatoFactory

import Foundation

struct Contatofactory{
    
    let nomes = ["Ana", "Bruno", "Bianca"]
    let sobrenomes = ["Silva", "Rocha", "Pereira"]
    let celulares = ["11 4636456", "21 4355456", "31 3242454"]
    let ruas = ["Rua 1", "Rua 2", "Rua 3"]
    
    
    func obterNovoContato() -> Contato {
        let nome = nomes.shuffled()[0]
        let sobrenome = sobrenomes.shuffled()[0]
        let celular = celulares.shuffled()[0]
        let email = "\(nome).\(sobrenome)@gmail.com".lowercased()
        let rua = ruas.shuffled()[0]
        
        let contato = Contato(id: UUID().uuidString,
                              nome: "\(nome) \(sobrenome)",
                              email: email,
                              celular: celular,
                              endereco: rua,
                              numero: "\(Int.random(in: 0...1000))")
        return contato
    }
}
