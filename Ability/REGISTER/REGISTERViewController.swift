//
//  REGISTERViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/3/11.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit

class REGISTERViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var id: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        id.delegate=self
        id.returnKeyType=UIReturnKeyType.done
        password.delegate=self
        password.returnKeyType=UIReturnKeyType.done
        
        photo.image=UIImage(named:"mp")?.roundCornersToCircle()
        
        // Do any additional setup after loading the view.
    
    
        photo.isUserInteractionEnabled=true
        
        let tagGR=UITapGestureRecognizer(target: self, action: #selector(REGISTERViewController.selectphoto(_:)))
        photo.addGestureRecognizer(tagGR)
    
    }

    @IBAction func selectphoto(_ sender:UITapGestureRecognizer){
        print("select picture")
        
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

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
        
        photo.image = selectedImage.roundCornersToCircle()
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "registerAtoB" {
            //let secView = segue.destination as! secViewController
            //secView.stuNo = self.txtStuNo.text!
            //secView.stuName = self.txtStuName.text!
        
            let secView = segue.destination as! RtwoViewController
            secView.photo=photo.image
            secView.id=id.text
            secView.password=password.text
        }
    
    //registerAtoB
    }
    

}
