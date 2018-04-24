//
//  RtwoViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/3/11.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit
import LeanCloud
import AVOSCloud
class RtwoViewController: UIViewController {
    
    @IBOutlet weak var b1: UIButton!
    
    @IBOutlet weak var b2: UIButton!
    
    @IBOutlet weak var b3: UIButton!
    
    @IBOutlet weak var b4: UIButton!
    
    
    var photo:UIImage?
    var id:String?
    var password:String?
    
    var f1=false
    var f2=false
    var f3=false
    var f4=false
    @IBAction func ab1(_ sender: Any) {
       // b1.setImage("gou", for: )
        if(f1==false){
            
        f1=true
// 44 145 252
         b1.backgroundColor=UIColor(red: 88/255, green: 216/255, blue: 252/255, alpha: 0.5)
         b1.layer.borderColor=UIColor(red: 88/255, green: 216/255, blue: 252/255, alpha: 0.5).cgColor
        }
        else{
            
            b1.backgroundColor=UIColor.clear
            b1.layer.borderColor=UIColor.gray.cgColor
            f1=false
        }
    }
    
    @IBAction func ab2(_ sender: Any) {
        if(f2==false){
            
            f2=true
            
            b2.backgroundColor=UIColor(red: 88/255, green: 216/255, blue: 252/255, alpha: 0.5)
            b2.layer.borderColor=UIColor(red: 88/255, green: 216/255, blue: 252/255, alpha: 0.5).cgColor
        }
        else{
            
            b2.backgroundColor=UIColor.clear
            b2.layer.borderColor=UIColor.gray.cgColor
            f2=false
        }
    }
    
    @IBAction func ab3(_ sender: UIButton) {
        if(f3==false){
            
            f3=true
            
            b3.backgroundColor=UIColor(red: 88/255, green: 216/255, blue: 252/255, alpha: 0.5)
            b3.layer.borderColor=UIColor.clear.cgColor
        }
        else{
            
            b3.backgroundColor=UIColor.clear
            b3.layer.borderColor=UIColor.gray.cgColor
            f3=false
        }
    }
    
    
    @IBAction func ab4(_ sender: UIButton) {
        if(f4==false){
            
            f4=true
            
            b4.backgroundColor=UIColor(red: 88/255, green: 216/255, blue: 252/255, alpha: 0.5)
            b4.layer.borderColor=UIColor(red: 88/255, green: 216/255, blue: 252/255, alpha: 0.5).cgColor
        }
        else{
            
            b4.backgroundColor=UIColor.clear
            b4.layer.borderColor=UIColor.gray.cgColor
            f4=false
        }
        
    }
    
    
   
    
    @IBAction func registerTwo(_ sender: UIButton) {
        
        
        let data=UIImagePNGRepresentation(photo!)
        let file=AVFile(data: data!)
        
        let user=LCUser()
        user.username=LCString(id!)
        user.password=LCString(password!)
        
        user.signUp { (result) in
            if(result.isSuccess){
                print("success!sdafsadfasdfasdf\n\n\n\n\n\n\n")
             
              
                  let obj=AVObject(className: "Custom_User")
                   obj.setObject(self.id, forKey: "id")
                   obj.setObject(file, forKey: "portrait")
                   obj.setObject(self.f1, forKey: "study")
                   obj.setObject(self.f2, forKey: "manual")
                   obj.setObject(self.f3, forKey: "dance")
                   obj.setObject(self.f4, forKey: "music")
                
                obj.saveInBackground({ (resultbool, error) in
                   error.debugDescription
                })
 
                
                
                
               
            }
            print(result.error?.code)
        }
        
       
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        b1.layer.borderColor=UIColor.gray.cgColor
        b1.layer.borderWidth=1
        b1.layer.cornerRadius=b1.frame.width/2
        b1.layer.masksToBounds=true
        
        
        b2.layer.borderColor=UIColor.gray.cgColor
        b2.layer.borderWidth=1
        b2.layer.cornerRadius=b1.frame.width/2
        b2.layer.masksToBounds=true
        
        
        b3.layer.borderColor=UIColor.gray.cgColor
        b3.layer.borderWidth=1
        b3.layer.cornerRadius=b1.frame.width/2
        b3.layer.masksToBounds=true
        
        b4.layer.borderColor=UIColor.gray.cgColor
        b4.layer.borderWidth=1
        b4.layer.cornerRadius=b1.frame.width/2
        b4.layer.masksToBounds=true
        // Do any additional setup after loading the view.
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
    
    
    @IBAction func regist(_ sender: UIButton) {
        
        
        
    }
    
    
}
