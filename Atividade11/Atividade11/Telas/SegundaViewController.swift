
import UIKit

class SegundaViewController: UIViewController {
    
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtEndereco: UITextField!
    @IBOutlet weak var txtNumero: UITextField!
    @IBOutlet weak var txtTelefone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    var contato : Contato?
    var delegate: ContatoProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.contato != nil ? self.contato?.nome : "Novo Contato"
        
        if let contato = self.contato{
            self.txtNome.text = contato.nome
            self.txtEndereco.text = contato.endereco
            self.txtNumero.text = contato.numero
            self.txtTelefone.text = contato.celular
            self.txtEmail.text = contato.email
        }
    }
    
    @IBAction func gravar(_ sender: Any){
        
        if let nome = self.txtNome.text,
           let endereco = self.txtEndereco.text,
           let numero = self.txtNumero.text,
           let celular = self.txtTelefone.text,
           let email = self.txtEmail.text,
           !nome.isEmpty && !endereco.isEmpty && !numero.isEmpty && !celular.isEmpty && !email.isEmpty{
            
            if var contatoAntigo = self.contato {
                contatoAntigo.nome = nome
                contatoAntigo.endereco = endereco
                contatoAntigo.numero = numero
                contatoAntigo.celular = celular
                contatoAntigo.email = email
                
                self.delegate?.alterar(contato: contatoAntigo)
            }
            else{
                let novoContato = Contato(id: UUID().uuidString,
                                          nome: nome,
                                          email: email,
                                          celular: celular,
                                          endereco: endereco,
                                          numero: numero)
                self.delegate?.criar(contato: novoContato)
            }
            
            self.navigationController?.popViewController(animated: true)
        
        }
    
    }
}
