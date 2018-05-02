//
//  GoodFriViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/4/24.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit
import AVOSCloud
class GoodFriViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var dataArray = NSMutableArray()
    var tableView:UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view.backgroundColor=UIColor.blue
        
        
        tableView=UITableView(frame: self.view.frame)
        self.view.addSubview(tableView!)
        
        tableView?.delegate=self
        tableView?.dataSource=self
        
      
        self.tableView?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
        self.tableView?.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefresh))
        
        headerRefresh()
        
        
        tableView?.tableFooterView=UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellId: String
        var cell: UITableViewCell? = nil
        var style: UITableViewCellStyle
        let image = UIImage (named: "cellImage")
        var text: String
        let detailText = "detail_text"
        
            cellId = "subtitle"
            style = UITableViewCellStyle.subtitle
            text = "subtitle_text"
        cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell (style: style, reuseIdentifier: cellId)
        }
         let obj=dataArray[indexPath.row]as! AVObject
        let  query=AVQuery(className: "Custom_User")
        let idstring=obj["B"] as! String
        query.whereKey("id", matchesRegex: idstring)
        let temp=query.findObjects() as! [AVObject]
        if(temp.count>0)
        {
            let U=temp[0]["portrait"] as! AVFile
           cell?.imageView?.image=UIImage(data: U.getData()!)
            //  let U=temp!["image"] as! AVFile
            //  photoImageView.image=UIImage(data: U.getData()!)
            // text.text=temp?["string"] as! String
        }
        
        cell?.textLabel?.text = idstring
        cell?.detailTextLabel?.text = detailText
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell!
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
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden=false
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let chat = RCConversationViewController(conversationType: RCConversationType.ConversationType_PRIVATE, targetId:  (dataArray[indexPath.row]as! AVObject)["B"] as! String)
     
            chat?.title =  (dataArray[indexPath.row]as! AVObject)["B"] as! String
        self.navigationController?.pushViewController(chat!, animated: true)
        self.tabBarController?.tabBar.isHidden=true
        
        
    }
    
    @objc func headerRefresh(){
        
        
        print("headerRefresh\n\n\n\n\n\n\n\n\n\n\n")
        let  query=AVQuery(className: "AtoB")
        query.whereKey("A", equalTo: AVUser.current()?.username)
        
        query.limit = 20
        query.skip = 0
        //  query.whereKey("user", equalTo: AVUser.current())
        query.findObjectsInBackground { (results, error) -> Void in
            self.tableView?.mj_header.endRefreshing()
            
            if let Result=results{
                self.dataArray.removeAllObjects()
                self.dataArray.addObjects(from: (Result))
                self.tableView?.reloadData()
            }
            
            
        }
        
    }
    @objc func footerRefresh(){
        print("footerRefresh\n\n\n\n\n\n\n\n\n\n")
        let  query=AVQuery(className: "AtoB")
        query.whereKey("A", equalTo: AVUser.current()?.username)
        query.limit = 20
        query.skip = self.dataArray.count
        //  query.whereKey("user", equalTo: AVUser.current())
        query.findObjectsInBackground { (results, error) -> Void in
            self.tableView?.mj_footer.endRefreshing()
            
            self.dataArray.addObjects(from: results!)
            self.tableView?.reloadData()
            
        }
        
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
   
    
    
    
    //在这里修改删除按钮的文字
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        
        return "点击删除"
        
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            let obj=dataArray[indexPath.row] as! AVObject
            let  query=AVQuery(className: "AtoB")
            query.whereKey("A", equalTo: AVUser.current()?.username)
            
            query.findObjectsInBackground { (results, error) -> Void in
                
                if let Result=results{
                    
                    let arr=Result as! [AVObject]
                    for i in 0 ..< arr.count{
                        
                        
                        if( arr[i]["B"]as! String  == obj["B"]as! String)
                        {
                            arr[i].delete()
                            break;
                        }
                    }
                }
                
                
            }
            
            
            self.dataArray.removeObject(at: indexPath.row)
            
            self.tableView!.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
            
            ProgressHUD.showSuccess("取消关注", interaction: true)
        }
        
    }

    
    //点击删除按钮的响应方法，在这里处理删除的逻辑
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            let obj=dataArray[indexPath.row] as! AVObject
            let  query=AVQuery(className: "AtoB")
            query.whereKey("A", equalTo: AVUser.current())
            
            query.findObjectsInBackground { (results, error) -> Void in
             
                if let Result=results{
                   
                    let arr=Result as! [AVObject]
                    for i in 0 ..< arr.count{
                        
                        
                        if( arr[i]["B"]as! String  == obj["B"]as! String)
                        {
                            arr[i].delete()
                            break;
                        }
                    }
                }
                
                
            }
            
            
            self.dataArray.removeObject(at: indexPath.row)
            
            self.tableView!.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
            
            ProgressHUD.show("取消关注")
        }
        
    }
    
}
