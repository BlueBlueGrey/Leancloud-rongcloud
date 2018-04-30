//
//  CommentViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/4/27.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit
import AVOSCloud

class CommentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,SWTableViewCellDelegate{
    
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
        var cell = self.tableView?.dequeueReusableCell(withIdentifier: "discussCell") as! discussCell
        
        cell.initFrame()
        
        cell.rightUtilityButtons = self.returnRightBtn()
        
        cell.delegate = self
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
        
        
        
        
        let textSize = (object!["text"] as? String)?.boundingRect(with: CGSize(width: SCREEN_WIDTH-56-8, height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15)], context: nil).size
        
        
        // cell.detailLabel=UILabel(frame: CGRect(x: 56, y: 30, width: SCREEN_WIDTH-56-8, height: (textSize?.height)!+10))
        
        cell.detailLabel?.text = object!["text"] as? String
        
        
        //  cell.dateLabel=UILabel(frame: CGRect(x: 56, y: (textSize?.height)!+30, width: SCREEN_WIDTH-56-8, height: 10))
        
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
        self.tableView?.register(discussCell.self, forCellReuseIdentifier: "discussCell")
        
        self.tableView?.delegate=self
        self.tableView?.dataSource=self
    }
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let object = self.dataArray[indexPath.row] as? AVObject
        let text = object!["text"] as? NSString
        
        let textSize = text?.boundingRect(with: CGSize(width: SCREEN_WIDTH-56-8, height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15)], context: nil).size
        
        
        
        return (textSize?.height)! + 30 + 25
    }
    
    
    @objc func headerRefresh(){
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
    }
    @objc func footerRefresh(){
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
        }
    }
    
    
    func returnRightBtn()->[AnyObject]{
      //  CGRect(x: 0, y: 0, width: 88, height: 88)
        let btn1 = UIButton(frame:CGRect(x: 0, y: 0, width: 88, height: 88))
        btn1.backgroundColor = UIColor.orange
        btn1.setTitle("编辑", for: .normal)
        
        let btn2 = UIButton(frame:CGRect(x: 0, y: 0, width: 88, height: 88))
        btn2.backgroundColor = UIColor.red
        btn2.setTitle("删除", for: .normal)
        
        return [btn1,btn2]
    }

    
    func swipeableTableViewCell(cell: SWTableViewCell!, scrollingToState state: SWCellState) {
        let indexPath = self.tableView?.indexPath(for: cell)
        if state == .cellStateRight{
            if self.swipIndexPath != nil && self.swipIndexPath?.row != indexPath?.row {
                let swipedCell = self.tableView?.cellForRow(at: self.swipIndexPath! as IndexPath) as? discussCell
                swipedCell?.hideUtilityButtons(animated: true)
            }
            self.swipIndexPath = indexPath as! NSIndexPath
        }else if state == .cellStateCenter{
            self.swipIndexPath = nil
        }
    }
    
    func swipeableTableViewCell(cell: SWTableViewCell!, didTriggerRightUtilityButtonWithIndex index: Int) {
        cell.hideUtilityButtons(animated: true)
        
        let indexPath = self.tableView?.indexPath(for: cell)
        
        let object = self.dataArray[indexPath!.row] as? AVObject
        
        if index == 0 {  //编辑
        
            /*
            let vc = pushNewBookController()
           
            
            
            vc.fixType = "fix"
            vc.BookObject = object
            vc.fixBook()
            self.presentViewController(vc, animated: true, completion: { () -> Void in
 
            })
            
            
            */
        }else{     //删除
            ProgressHUD.show("")
            
            let discussQuery = AVQuery(className: "discuss")
            discussQuery.whereKey("PostObject", equalTo: object)
            discussQuery.findObjectsInBackground({ (results, error) -> Void in
                for Book in results! {
                    let PostObject = Book as? AVObject
                    PostObject?.deleteInBackground()
                }
            })
            
            let loveQuery = AVQuery(className: "Love")
            loveQuery.whereKey("BookObject", equalTo: object)
            loveQuery.findObjectsInBackground({ (results, error) -> Void in
                for Book in results! {
                    let BookObject = Book as? AVObject
                    BookObject?.deleteInBackground()
                }
            })
            
            object?.deleteInBackground({ (success, error) -> Void in
                if success {
                    ProgressHUD.showSuccess("删除成功")
                    self.dataArray.removeObject(at: (indexPath?.row)!)
                    self.tableView?.reloadData()
                    
                    
                }else{
                    
                }
            })
            
            
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
