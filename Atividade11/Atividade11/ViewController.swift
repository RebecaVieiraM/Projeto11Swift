
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tabela: UITableView! //conectar na tabela, nao da celula
    private let contactsKey = "contatos"
    private var userDefaults = UserDefaults.standard
    
    //private var factory = Contatofactory()
    private var contatos: [Contato] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        self.contatos = self.obterTodos()
        
        self.tabela.dataSource = self
        self.tabela.delegate = self
        /*
        self.contatos
        self.tabela.dataSource = self //erro solucionado ao criar a extention uitableviewdatasource
        self.tabela.delegate = self //erro solucionado ao criar a extention uitableviewdelegate
    
        for _ in 1...50{
            contatos.append(factory.obterNovoContato())
        }*/
    }
    
    @IBAction func goToNewItemByUI(_ sender: Any){
        self.navigate()
    }
    private func navigate(){
        let vc = SegundaViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController : UITableViewDataSource{ //clicar na bolinha e fix para gerar as 2 funcs automaticamente
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contatos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ContatoTableViewCell else {
            return UITableViewCell()
    }// colocar o as? ContatoTableViewCell antes do else
        let contato = self.contatos[indexPath.row]
        cell.configurar(item: contato)
        return cell
    }
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // escrever didselectrow ate aparecer a funcao desejada
        
        let contato = self.contatos[indexPath.row]
        
        let vc = SegundaViewController()
        vc.contato = contato
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        /*
        let contato = self.contatos[indexPath.row]
        
        performSegue(withIdentifier: "segueTela1ParaTela2", sender: contato)
        
        let msg = "Contato selecionado: \(contato)"
        let alert = UIAlertController(title: "Atenção!", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        
        present(alert, animated: true)
         */
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140 //digitar height ai vai aparecer, dar tab
        //indicar a altura da celula
    }
    
    
    //comecar a digitar trail enter para gerar o metodo abaixo
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .normal, title: "Excluir", handler: {[weak self] _,_,_ in
            guard let tela = self else { return }//copiar o q tiver dentro do [] no return e colar depois do let action =
            let id = tela.contatos[indexPath.row].id
            tela.excluir(id: id)
            
        })
        
        action.image = .init(systemName: "trash")
        action.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [action])//digitar o return UISwipeActionsConfiguration
        //substituir [...] por action
    }
}

extension ViewController: ContatoProtocol{
    
    private func gravarListaNoDisco(){
        do {
            let data = try JSONEncoder().encode(self.contatos)
            userDefaults.setValue(data, forKey: contactsKey)
        } catch{
            print("===> Erro ao gravar -> ViewController.criar\(error.localizedDescription)")
            // Enviar uma msg p usuario dizendo qur falhou
            // atualizar a lista da memoria como o conteudo do disco
            // chamar o reload data da tabela
        }
    }
    
    func criar(contato: Contato){
        if self.contatos.first(where: { $0.email == contato.email }) != nil {
            self.notificarUsuarioErro()
        } else {
            self.contatos.append(contato)
            self.gravarListaNoDisco()
            self.tabela.reloadData()
        }
    }
    
    func notificarUsuarioErro() {
        let vc = UIAlertController(title: "Atenção!", message: "Não é possível gravar informações duplicadas", preferredStyle: .alert)
        let action = UIAlertAction(title: "Fechar", style: .default)
        vc.addAction(action)
        self.present(vc, animated: true)
    }
    
    func obterTodos() -> [Contato] {
        
        guard let data = userDefaults.value(forKey: contactsKey) as? Data else{
            return []
        }
        var items = [Contato]()
        do {
            items = try JSONDecoder().decode([Contato].self, from: data)
        }catch{
            print("===> Erro ao carregar items -> ViewController.obterTodos")
        }
        return items
        
    }
    
    func alterar(contato: Contato){
        
        if let index = self.contatos.firstIndex(where: { $0.id == contato.id }){
            if self.contatos.first(where: { $0.id != contato.id && $0.email == contato.email }) != nil {
                self.notificarUsuarioErro()
            } else{
                self.contatos[index].nome = contato.nome
                self.contatos[index].celular = contato.celular
                self.contatos[index].numero = contato.numero
                self.contatos[index].endereco = contato.endereco
                self.contatos[index].email = contato.email
                
                //self.contatos[index] = contato -> muda tudo igual acima
                
                self.gravarListaNoDisco()
                
                self.tabela.reloadData()
            }
        }
    }
    
    func excluir(id: String) {
        if let index = self.contatos.firstIndex(where: { $0.id == id }){
            self.contatos.remove(at: index)
            self.gravarListaNoDisco()
            self.tabela.reloadData()
        }
    }
}
