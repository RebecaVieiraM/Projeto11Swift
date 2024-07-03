
//apagar os comentarios e o import e as funcoes da class
// para criar esse arquivo
// com o botao direito na atividade1, criar um new group com nome Components
// criar no models um new cocoa touch class Contato...
//
//la no main.storyboard clicar na cell e na class colocar ContatoTableViewCell
import UIKit

class ContatoTableViewCell: UITableViewCell {

    //linkar os iboutlets nas labels do main.storyboard

    @IBOutlet weak var lblNome: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblCelular: UILabel!
    @IBOutlet weak var lblEndereco: UILabel!
    @IBOutlet weak var lblNumero: UILabel!

    func configurar(item: Contato) {
        self.lblNome.text = item.nome
        self.lblEmail.text = item.email
        self.lblCelular.text = item.celular
        self.lblEndereco.text = item.endereco
        self.lblNumero.text = item.numero

    }
}
