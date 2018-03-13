//
//  TieViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/1/29.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit
import LeanCloud
import AVOSCloud
class TieViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var text: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        let data=UIImagePNGRepresentation(#imageLiteral(resourceName: "pa"))
//        let file=AVFile(data: data!)
//        let obj=AVObject(className: "factory")
//        obj.setObject(file, forKey: "image")
//        obj.saveInBackground { (aX,AY) in
//
//        }
        
        
//        let  query=AVQuery(className: "factory")
//        let  temp=query.getFirstObject()
//        let U=temp!["image"] as! AVFile
//        putimage.image=UIImage(data: U.getData()!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: Actions
    @IBAction func selectrrrr(_ sender: UITapGestureRecognizer) {
        
        print("sdfadsf")
        // Hide the keyboard.
        
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func save(_ sender: UIButton) {
        
        
         let obj=AVObject(className: "factory")
        if let temp=photoImageView.image
        {
            let data=UIImagePNGRepresentation((photoImageView.image)!)
            let file=AVFile(data: data!)
            obj.setObject(file, forKey: "image")
        }
                obj.setObject(text.text, forKey: "string")
        
                obj.saveInBackground()
        
        
    }
    
    
    @IBAction func show(_ sender: Any) {
        
        
        
                let  query=AVQuery(className: "factory")
                let  temp=query.getFirstObject()
                let U=temp!["image"] as! AVFile
                photoImageView.image=UIImage(data: U.getData()!)
              text.text=temp?["string"] as! String
        
        
    }
    
    

}
