//
//  GoodFriViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/4/24.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit

class GoodFriViewController: UIViewController {

    
    var tableView:UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view.backgroundColor=UIColor.blue
        
        
        tableView=UITableView(frame: self.view.frame)
        self.view.addSubview(tableView!)
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
