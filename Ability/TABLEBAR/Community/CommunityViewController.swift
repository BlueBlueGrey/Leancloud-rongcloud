//
//  CommunityViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/3/14.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit
import AVOSCloud
class CommunityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // 单前 用户登录
         AVUser.logOut()
        
      
        
        
        if AVUser.current() == nil {
            print("nil    ----------------")
            print("nil    ===============----------------")
            print("nil    ===============----------------")
            print("nil    ===============----------------")
            print("nil    ===============----------------")
            // story
            let story = UIStoryboard(name: "LoginStoryboard", bundle: nil)
            let loginVC = story.instantiateViewController(withIdentifier: "LoginStory")
            self.present(loginVC, animated: true, completion: { () -> Void in
                
            })
            
        }
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

}
