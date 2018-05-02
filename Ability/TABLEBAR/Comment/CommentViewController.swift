//
//  CommentViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/4/27.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit
import AVOSCloud

class CommentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var kind:Int?
    var dataArray = NSMutableArray()
    var tableView:UITableView?
    var swipIndexPath:NSIndexPath?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(dataArray.count)
        print("\n\n\n\n\n\n")
        return dataArray.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
     
        
        
      
          let cell = tableView.dequeueReusableCell(withIdentifier: "discussCell", for: indexPath) as! discussCell
      
        let object = self.dataArray[indexPath.row] as? AVObject
        
        let id = object!["id"] as? String
        cell.nameLabel?.text = id
        cell.avatarImage?.image = #imageLiteral(resourceName: "alien")
        let  query=AVQuery(className: "Custom_User")
        query.whereKey("id", equalTo: id )
        let temp=query.findObjects() as! [AVObject]
        if(temp.count>0)
        {
            let U=temp[0]["portrait"] as! AVFile
            cell.avatarImage?.image=UIImage(data: U.getData()!)
        }
        
        
        
        
        
        
        cell.detailLabel?.text = object!["text"] as? String
        
    
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd hh:mm"
        
        
        let date = object!["createdAt"] as? NSDate
        cell.dateLabel?.text = format.string(from: date! as Date)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.tableView=UITableView(frame: self.view.frame)
        self.tableView?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
        self.tableView?.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefresh))
        headerRefresh()
        
        self.tableView?.tableFooterView=UIView()
        self.view.addSubview(tableView!)
       /* self.tableView?.register(discussCell.self, forCellReuseIdentifier: "discussCell")*/
        tableView?.register(discussCell.self, forCellReuseIdentifier: "discussCell")
        self.tableView?.delegate=self
        self.tableView?.dataSource=self
        tableView?.estimatedRowHeight = 80.0
        tableView?.rowHeight = UITableViewAutomaticDimension
    }
    
  
    
    
    @objc func headerRefresh(){
        if(kind==0){
        let query = AVQuery(className: "discuss")
        query.order(byDescending: "createdAt")
        query.limit = 20
        query.skip = 0
        query.whereKey("id", equalTo: AVUser.current()?.username)
        
        
        
        
        
        query.includeKey("PostObject")
        query.findObjectsInBackground { (results, error) -> Void in
            self.tableView?.mj_header.endRefreshing()
            
            self.dataArray.removeAllObjects()
            if(results != nil){
                self.dataArray.addObjects(from: results!)
                self.tableView?.reloadData()
            }
            
        }
        }else{
            
            
            let query = AVQuery(className: "discuss")
            query.order(byDescending: "createdAt")
            query.limit = 20
            query.skip = 0
            query.whereKey("opid", equalTo: AVUser.current()?.username)
            
            
            
            
            
            query.includeKey("PostObject")
            query.findObjectsInBackground { (results, error) -> Void in
                self.tableView?.mj_header.endRefreshing()
                
                self.dataArray.removeAllObjects()
                if(results != nil){
                    self.dataArray.addObjects(from: results!)
                    self.tableView?.reloadData()
                }
                
            }
            
        }
    }
    @objc func footerRefresh(){
        if(kind==0){
        let query = AVQuery(className: "discuss")
        query.order(byDescending: "createdAt")
        query.limit = 20
        query.skip = self.dataArray.count
        
        query.whereKey("id", equalTo: AVUser.current()?.username)
        query.includeKey("PostObject")
        query.findObjectsInBackground { (results, error) -> Void in
            self.tableView?.mj_footer.endRefreshing()
            if(results != nil){
                self.dataArray.addObjects(from: results!)
                self.tableView?.reloadData()
            }
            }}
        else{
            
            let query = AVQuery(className: "discuss")
            query.order(byDescending: "createdAt")
            query.limit = 20
            query.skip = self.dataArray.count
            
            query.whereKey("opid", equalTo: AVUser.current()?.username)
            query.includeKey("PostObject")
            query.findObjectsInBackground { (results, error) -> Void in
                self.tableView?.mj_footer.endRefreshing()
                if(results != nil){
                    self.dataArray.addObjects(from: results!)
                    self.tableView?.reloadData()
                }
            }
            
        }
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
