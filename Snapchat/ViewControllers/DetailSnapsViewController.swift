//
//  DetailSnapsViewController.swift
//  Snapchat
//
//  Created by Eduardo on 30/04/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import SDWebImage

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
                print("imagem exibida")
            }
        }
    }
}
