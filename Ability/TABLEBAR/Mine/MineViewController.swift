//
//  MineViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/3/14.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit
import AVOSCloud
class MineViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellId: String
        var cell: UITableViewCell? = nil
        var style: UITableViewCellStyle
        let image = UIImage (named: "cellImage")
        var text: String
        let detailText = "detail_text"
        cellId = "default"
        style = UITableViewCellStyle.default
        text = "default_text"
        switch indexPath.row {
        case 0:
           
            text = "评论"
        case 1:
         
            text = "设置"
        case 2:
           
            text = "3"
        default:
          
            text = "2"
        }
        cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell (style: style, reuseIdentifier: cellId)
        }
        cell?.imageView?.image = image
        cell?.textLabel?.text = text
        cell?.detailTextLabel?.text = detailText
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row==0){
            let vc=CommentPageViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if(indexPath.row==1){
            
            let vc=DesignViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    var imageine:UIImageView?
    var buttonG:UIButton?
    var buttonD:UIButton?
    var buttonB:UIButton?
    var tableview:UITableView?
    var labelId:UILabel?
    var labelIn:UILabel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor=UIColor.white
        // Do any additional setup after loading the view.
        
        
        
        
        
        imageine=UIImageView(frame: CGRect(x: self.view.frame.width/2-50, y: 75, width: 100, height: 100))
        self.view.addSubview(imageine!)
       
     
        
        
        labelId=UILabel(frame: CGRect(x: self.view.frame.width/2-50, y: 175, width: 100, height: 40))
       // labelId?.backgroundColor=UIColor.black
        labelId?.text=AVUser.current()?.username
        labelId?.textAlignment=NSTextAlignment.center
        self.view.addSubview(labelId!)
        
        labelIn=UILabel(frame: CGRect(x: self.view.frame.width/2-100, y: 200, width: 200, height: 40))
        // labelId?.backgroundColor=UIColor.black
    
        labelIn?.textAlignment=NSTextAlignment.center
        self.view.addSubview(labelIn!)
        
        buttonG=UIButton(frame: CGRect(x: 0, y: 250, width: self.view.frame.width/2, height: 40))
        buttonG?.setTitle("关注", for: .normal)
          buttonG?.backgroundColor=MAIN_RED
        self.view.addSubview(buttonG!)
      
        buttonG?.addTarget(self, action: #selector(btnClick), for:
            .touchUpInside)
        
        buttonD=UIButton(frame:CGRect(x:  self.view.frame.width/2, y:250, width: self.view.frame.width/2, height: 40) )
        buttonD?.backgroundColor=MAIN_RED
        buttonD?.setTitle("动态", for:.normal)
        self.view.addSubview(buttonD!)
        
        buttonD?.addTarget(self, action: #selector(btn2Click), for:
            .touchUpInside)
        
        
        
        buttonB=UIButton(frame:CGRect(x:  self.view.frame.width/2-50, y:500, width: 100, height: 40) )
        buttonB?.backgroundColor=MAIN_RED
        buttonB?.setTitle("退出", for:.normal)
        self.view.addSubview(buttonB!)
        
        buttonB?.addTarget(self, action: #selector(btn3Click), for:
            .touchUpInside)
        
        
        tableview?.backgroundColor=UIColor.gray
        tableview=UITableView(frame: CGRect(x:0, y: 300, width: self.view.frame.width, height: 200))
        tableview?.delegate=self
        tableview?.dataSource=self
        self.tableview?.tableFooterView=UIView()
        
        
        let  query=AVQuery(className: "Custom_User")
        query.whereKey("id", equalTo: AVUser.current()?.username)
        let temp=query.findObjects() as! [AVObject]
        if(temp.count>0)
        {
            let U=temp[0]["portrait"] as! AVFile
            imageine?.image=UIImage(data: U.getData()!)
            
            if let da = temp[0]["signature"]{
                self.labelIn?.text=da as! String
            }else{
                self.labelIn?.text="Ta说这条个性签名还的再想想"
            }
            
        }
        
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
    
    
    @objc func btn3Click(sender:UIButton?) {
        
        AVUser.logOut()
        print("BBBBB========\n\n\n")
        self.tabBarController?.selectedIndex=0
        
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


