//
//  DetailSnapsViewController.swift
//  Snapchat
//
//  Created by Eduardo on 30/04/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class DetailSnapsViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var count: UILabel!
    
    var snap = Snap(identificador: "", nome: "", de: "", desc: "", urlImage: "", idImagem: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        details.text = snap.descricao
        let url = URL(string: snap.urlImagem)
        image.sd_setImage(with: url) { (image, error, cache, url) in
            if error == nil {
                
            }
        }
    }
    
    //Method called whenever the view is closed
    override func viewWillDisappear(_ animated: Bool) {
        let auth = Auth.auth()
        if let userLoggedId = auth.currentUser?.uid {
            //Remove node in database
            let users = Database.database().reference().child("usuarios")
            let snaps = users.child(userLoggedId).child("snaps")
            
            snaps.child(snap.identificador).removeValue() //Remove snap from database
            
            //remove snap image
            let images = Storage.storage().reference().child("imagens")
            
            images.child("\(snap.idImagem).jpg").delete { (error) in
                if error == nil {
                    print("Sucesso ao excluir a imagem")
                } else {
                    print("Erro ao excluir a imagem")
                }
            }
        }
    }
}
