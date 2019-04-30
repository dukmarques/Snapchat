//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Eduardo on 19/04/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SnapsViewController: UIViewController {
    var snaps: [Snap] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let auth = Auth.auth()
        if let userLoggedId = auth.currentUser?.uid {
            let users = Database.database().reference().child("usuarios")
            let snaps = users.child(userLoggedId).child("snaps")
            
            //Listener for snaps
            snaps.observe(DataEventType.childAdded) { (snapshot) in
                let datas = snapshot.value as? NSDictionary
                
                let snap = Snap(
                    identificador: snapshot.key,
                    nome: datas?["nome"] as! String,
                    de: datas?["de"] as! String,
                    desc: datas?["descricao"] as! String,
                    urlImage: datas?["urlImagem"] as! String,
                    idImagem: datas?["idImagem"] as! String
                )
                
                self.snaps.append(snap)
                print(self.snaps)
            }
        }
    }
    
    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch  {
            let alert = Alert(title: "Erro ao deslogar", message: "Ocorreu um erro, por favor, tente novamente.")
            present(alert.getAlert(), animated: true, completion: nil)
        }
    }
}
