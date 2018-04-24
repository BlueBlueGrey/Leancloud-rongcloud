//
//  MineViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/3/14.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit

class MineViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell=tableView.dequeueReusableCell(withIdentifier: "default")
        
        cell?.textLabel?.text="sdaf"
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

   
    var imageine:UIImageView?
    var buttonG:UIButton?
    var buttonD:UIButton?
    var tableview:UITableView?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor=UIColor.white
        // Do any additional setup after loading the view.
        
        
        imageine=UIImageView(frame: CGRect(x: self.view.frame.width/2-50, y: 75, width: 100, height: 100))
        self.view.addSubview(imageine!)
        
        imageine?.image=UIImage(named:"alien")
        
        buttonG=UIButton(frame: CGRect(x: 0, y: 200, width: self.view.frame.width/2, height: 40))
        buttonG?.setTitle("关注", for: .normal)
          buttonG?.backgroundColor=UIColor.black
        self.view.addSubview(buttonG!)
      
        buttonG?.addTarget(self, action: #selector(btnClick), for:
            .touchUpInside)
        
        buttonD=UIButton(frame:CGRect(x:  self.view.frame.width/2, y:200, width: self.view.frame.width/2, height: 40) )
        buttonD?.backgroundColor=UIColor.black
        buttonD?.setTitle("动态", for:.normal)
        self.view.addSubview(buttonD!)
        
        buttonD?.addTarget(self, action: #selector(btn2Click), for:
            .touchUpInside)
        
        tableview?.delegate=self
        tableview?.dataSource=self
        tableview?.backgroundColor=UIColor.gray
        tableview=UITableView(frame: CGRect(x:0, y: 250, width: self.view.frame.width, height: 400))
        self.view.addSubview(tableview!)
    }

    
    @objc func btnClick(sender:UIButton?) {
        
        let v=GoodFriViewController()
        self.navigationController?.pushViewController(v, animated: true)
        
            print("GGGGG")
        }
    
    @objc func btn2Click(sender:UIButton?) {
        
        let v=DyViewController()
        self.navigationController?.pushViewController(v, animated: true)
        print("DDDD")
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
