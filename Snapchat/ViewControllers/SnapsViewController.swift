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

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var snaps: [Snap] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let auth = Auth.auth()
        if let userLoggedId = auth.currentUser?.uid {
            let users = Database.database().reference().child("usuarios")
            let snaps = users.child(userLoggedId).child("snaps")
            
            //Listener for snaps added
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
                self.tableView.reloadData() //Reloads the table data
            }
            
            //Listener for snaps removed
            snaps.observe(DataEventType.childRemoved) { (snapshot) in
                //Remove snap
                var indice = 0
                for snap in self.snaps{
                    if snap.identificador == snapshot.key {
                        self.snaps.remove(at: indice)
                    }
                    indice = indice + 1
                }
                self.tableView.reloadData() //Reloads the table data
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
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if snaps.count == 0 {
            return 1
        }
        
        return snaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = tableView.dequeueReusableCell(withIdentifier: "celSnaps", for: indexPath)
        
        if snaps.count == 0 {
            cel.textLabel?.text = "Nenhum snap para você :)"
        } else {
            cel.textLabel?.text = self.snaps[indexPath.row].nome
        }
        
        return cel
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if snaps.count > 0 {
            self.performSegue(withIdentifier: "detailSnapSegue", sender: self.snaps[indexPath.row])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSnapSegue" {
            let detailSnapViewController = segue.destination as! DetailSnapsViewController
            detailSnapViewController.snap = sender as! Snap
        }
    }
}
