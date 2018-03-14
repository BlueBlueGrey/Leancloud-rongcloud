//
//  LOGINViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/3/11.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit
import LeanCloud
import AVOSCloud
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
        if(id.text != ""){
            
            print("id.text")
            let  query=AVQuery(className: "Custom_User")
            query.whereKey("id", matchesRegex: id.text!)
            let temp=query.findObjects() as! [AVObject]
            print(temp.count)
            let U=temp[0]["portrait"] as! AVFile
            self.photo.image=UIImage(data: U.getData()!)
          //  let U=temp!["image"] as! AVFile
          //  photoImageView.image=UIImage(data: U.getData()!)
           // text.text=temp?["string"] as! String
        }
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
