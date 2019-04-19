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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self //This class manages photo selection
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
            if let imageData = selectedImage.jpegData(compressionQuality: 0.8) {
                images.child("imagem.jpg").putData(imageData, metadata: nil) { (metadata, error) in
                    if error == nil {
                        print("Sucesso ao fazer upload do arquivo")
                        
                        self.nextButton.isEnabled = true //Turn on button
                        self.nextButton.setTitle("Próximo", for: .normal)
                    } else {
                        print("Erro ao fazer o upload do arquivo")
                    }
                }
            }
        }
    }
    
    //Recover selected photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let recoveredImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        image.image = recoveredImage
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
