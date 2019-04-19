//
//  PhotoViewController.swift
//  Snapchat
//
//  Created by Eduardo on 19/04/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import FirebaseStorage

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate { //Inheritances required
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    //Object used to allow user to take photo or select from gallery
    var imagePicker = UIImagePickerController()
    var imageId = NSUUID().uuidString //Generates a unique identifier for each image
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self //This class manages photo selection
        
        //Disable next button
        nextButton.isEnabled = false
        nextButton.backgroundColor = UIColor.gray
    }
    
    @IBAction func selectPhoto(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum  //Select type of image selection
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func nextStep(_ sender: Any) {
        self.nextButton.isEnabled = false //Turn off button
        self.nextButton.setTitle("Carregando...", for: .normal)
        
        let storage = Storage.storage().reference()
        let images = storage.child("imagens")
        
        //Recover image
        if let selectedImage = image.image {
            if let imageData = selectedImage.jpegData(compressionQuality: 0.9) {
                images.child("\(self.imageId).jpg").putData(imageData, metadata: nil) { (metaData, error) in
                    if error == nil {
                        print("Sucesso ao fazer upload do arquivo")
                        
                        //Download URL
                        images.downloadURL(completion: { (url, error) in
                            print(url?.absoluteString)
                        })
                        
                        self.nextButton.isEnabled = true //Turn on button
                        self.nextButton.setTitle("Próximo", for: .normal)
                    } else {
                        print("Erro ao fazer o upload do arquivo")
                        let alert = Alert(title: "Falha de Upload", message: "Erro ao salvar o arquivo, tente novamente.")
                        self.present(alert.getAlert(), animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    //Recover selected photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let recoveredImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        image.image = recoveredImage
        
        //Enable next button
        self.nextButton.isEnabled = true
        self.nextButton.backgroundColor = UIColor(red: 0.553, green: 0.369, blue: 0.749, alpha: 1)
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
