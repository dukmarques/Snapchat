//
//  UsersTableViewController.swift
//  Snapchat
//
//  Created by Eduardo on 20/04/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class UsersTableViewController: UITableViewController {
    var users: [User] = []
    var imageUrl = ""
    var desc = ""
    var imageId = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        let database = Database.database().reference()
        let usersRef = database.child("usuarios")
        
        //Add new user added event
        usersRef.observe(DataEventType.childAdded) { (snapshot) in
            let data = snapshot.value as? NSDictionary
            
            //Recover data logged user
            let auth = Auth.auth()
            let userLoggedId = auth.currentUser?.uid
            
            //Recover data
            let userEmail = data?["email"] as! String
            let userName = data?["name"] as! String
            let userId = snapshot.key
            
            //Add array, verifies that the user id is different from the logged-in user id
            if userLoggedId != userId {
                let user = User(email: userEmail, name: userName, uid: userId)
                self.users.append(user)
            }
            
            self.tableView.reloadData() //Reload list
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //Config cell
        cell.textLabel?.text = self.users[indexPath.row].name //Title
        cell.detailTextLabel?.text = self.users[indexPath.row].email //Subtitle
        
        return cell
    }
    
    //Retrieves the index of the row that was selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = self.users[indexPath.row]
        
        //References Database Firebase
        let database = Database.database().reference()
        let usersRef = database.child("usuarios")
        let snaps = usersRef.child(selectedUser.uid).child("snaps")
        
        //Recover data from the logged in user
        let auth = Auth.auth()
        if let userIdLogged = auth.currentUser?.uid {
            let userLogged = usersRef.child(userIdLogged)
            userLogged.observeSingleEvent(of: DataEventType.value) { (snapshot) in
                let data = snapshot.value as? NSDictionary
                
                let snap = [
                    "de": data?["email"] as? String,
                    "nome": data?["name"] as? String,
                    "descricao": self.desc,
                    "urlImagem": self.imageUrl,
                    "idImagem": self.imageId
                ]
                snaps.childByAutoId().setValue(snap) //.childByAutoId: Create a node with incremental and unique id
                
                self.navigationController?.popToRootViewController(animated: true) //Return to root view
            }
        }
    }
}
