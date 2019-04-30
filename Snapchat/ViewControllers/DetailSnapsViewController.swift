//
//  DetailSnapsViewController.swift
//  Snapchat
//
//  Created by Eduardo on 30/04/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit

class DetailSnapsViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var count: UILabel!
    
    var snap = Snap(identificador: "", nome: "", de: "", desc: "", urlImage: "", idImagem: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(snap.descricao)
    }
}
