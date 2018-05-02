//
//  OpTableViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/4/24.
//  Copyright © 2018年 blueGrey. All rights reserved.
//
import UIKit
import AVOSCloud
class OpTableViewController: UITableViewController {

    var PostObject:AVObject?
    var dataArray = NSMutableArray()
    
   
    var keyBoardHeight:CGFloat = 0.0
    var flag=false
    
    
    var idString=""
    @IBOutlet weak var imaginView: UIImageView!
    
    @IBOutlet weak var id: UILabel!
    
    
    @IBOutlet weak var guanzhu: UIButton!
    
    @IBOutlet weak var introduce: UILabel!
    
    @IBOutlet weak var xl: UILabel!
    
    
    @IBAction func dianping(_ sender: UIButton) {
        
        
        
        
        let alertController = UIAlertController(title: "对该用户进行评价",
                                                message: "", preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "_______"
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            //也可以用下标的形式获取textField let login = alertController.textFields![0]
            let login = alertController.textFields!.first!
         
           
            
          
            let obj=AVObject(className: "discuss")
            obj.setObject(self.PostObject, forKey: "PostObject")
            obj.setObject(AVUser.current()?.username, forKey: "id")
            obj.setObject(self.idString, forKey: "opid")
            obj.setObject(login.text, forKey: "text")
            obj.saveInBackground({ (success, error) in
                if(success){
                    self.tableView?.mj_header.beginRefreshing()
                    self.tableView.reloadData()
                }
            })
            
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    
    
    @IBAction func addbuddy(_ sender: UIButton) {
        
        
        if(!flag)
        {
       flag = !flag
            xl.text="已关注"
            let obj=AVObject(className: "AtoB")
            obj.setObject(AVUser.current()?.username, forKey: "A")
            obj.setObject(self.idString, forKey: "B")
            obj.saveInBackground({ (success, error) in
                if(success){
                   ProgressHUD.showSuccess("关注成功", interaction: true)
                }
            })
        
        
        }
   
    }
    
    override func viewDidDisappear(_ animated: Bool) {
    self.tabBarController?.tabBar.isHidden=true
   
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden=false
    }
    
    @IBAction func talk(_ sender: UIButton) {
        
        let chat = RCConversationViewController(conversationType: RCConversationType.ConversationType_PRIVATE, targetId:  (id.text))
        
        chat?.title =  id.text
        self.navigationController?.pushViewController(chat!, animated: true)
        self.tabBarController?.tabBar.isHidden=true
        
        
    }
    /*  signature  special sex   birth  school  business work interest */
    override func viewDidLoad() {
        super.viewDidLoad()
        imaginView.image=#imageLiteral(resourceName: "alien")
        if(idString != ""){
            id.text=idString
            print("idString =========")
            let  query=AVQuery(className: "Custom_User")
            query.whereKey("id", equalTo: idString)
            let temp=query.findObjects() as! [AVObject]
            if(temp.count>0)
            {
                let U=temp[0]["portrait"] as! AVFile
                self.imaginView.image=UIImage(data: U.getData()!)
                if let sign=temp[0]["signature"]
                {
                      self.introduce.text=sign  as! String
                }
             
            }
            
            
            let  query2=AVQuery(className: "AtoB")
            query2.whereKey("A", equalTo: AVUser.current()?.username)
            if let temp2=query2.findObjects()
            {
                let temp3=temp2 as! [AVObject]
            if(temp3.count>0)
            {
                for i in 0 ..< temp3.count {
                    if(temp3[i]["id"]as!String==idString){
                        flag=true
                    }
                }
          
                
            }
            }
            if(flag){
                xl.text="已关注"
            }else{
                xl.text="+关注"
            }
            
        }
        
       
        tableView?.register(discussCell.self, forCellReuseIdentifier: "discussCell")
        self.tableView?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
        self.tableView?.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefresh))
        headerRefresh()
        

       
       
        self.tableView.tableFooterView=UIView()
      self.tableView?.mj_header.beginRefreshing()
        
        self.tableView.register(discussCell.self, forCellReuseIdentifier: "discussCell")
  
    
    
    }
   
    
    
    
    /**
     *  上拉加载、下啦刷新
     */
    @objc func headerRefresh(){
        let query = AVQuery(className: "discuss")
        query.order(byDescending: "createdAt")
        query.limit = 20
        query.skip = 0
        query.whereKey("PostObject", equalTo:self.PostObject)
      
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
    @objc func footerRefresh(){
        let query = AVQuery(className: "discuss")
        query.order(byDescending: "createdAt")
        query.limit = 20
        query.skip = self.dataArray.count
       
        query.whereKey("PostObject", equalTo: self.PostObject)
        query.includeKey("PostObject")
        query.findObjectsInBackground { (results, error) -> Void in
            self.tableView?.mj_footer.endRefreshing()
            if(results != nil){
                self.dataArray.addObjects(from: results!)
                self.tableView?.reloadData()
            }
        }
    }
    
  
 
 

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        var cell = self.tableView?.dequeueReusableCell(withIdentifier: "discussCell") as! discussCell
        
       
    
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
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
