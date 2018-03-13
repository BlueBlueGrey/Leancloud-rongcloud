//
//  LOGINViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/3/11.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit

class LOGINViewController: UIViewController,UITextFieldDelegate{

    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        id.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        print("停止编辑")
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
