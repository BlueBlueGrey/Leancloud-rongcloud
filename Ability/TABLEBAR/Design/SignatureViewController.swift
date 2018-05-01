//
//  SignatureViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/4/30.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit
import AVOSCloud
class SignatureViewController: CSViewController,UITextViewDelegate{
    
    var closure:(( _ str:String ) -> ())?
    var textView:CLTextView!
    var phontView:CLPhotosVIew!
    var placehoderStr:String?
 

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
        
        // Do any additional setup after loading the view.
        
        
        
        
        let width = self.view.frame.size.width
        let height=self.view.frame.size.height
       
        
        textView = CLTextView(frame: CGRect(x: 0, y: 64, width: width, height: height-350))
        textView.backgroundColor = UIColor.white
        textView.delegate = self
        textView.placehoder = placehoderStr
        
        self.view.addSubview(textView)
        
        
        
       
    }
    
  
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func sure(){
        
        print("sure")
        closure!(textView.text)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func close(){
        print("close")
        self.dismiss(animated: true, completion: nil)
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
