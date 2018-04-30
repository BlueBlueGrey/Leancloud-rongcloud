//
//  OpTableViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/4/24.
//  Copyright © 2018年 blueGrey. All rights reserved.
//
import UIKit
import AVOSCloud
class OpTableViewController: UITableViewController,InputViewDelegate {

    var PostObject:AVObject?
    var dataArray = NSMutableArray()
    var input:InputView?
    
    var layView:UIView?
    
    var keyBoardHeight:CGFloat = 0.0
    
    var tg:CGFloat=60.0
    
    var idString=""
    @IBOutlet weak var imaginView: UIImageView!
    
    @IBOutlet weak var id: UILabel!
    
    
    @IBOutlet weak var introduce: UILabel!
    
    
    @IBAction func addbuddy(_ sender: UIButton) {
        
        
        let obj=AVObject(className: "AtoB")
        obj.setObject(AVUser.current(), forKey: "A")
        obj.setObject(idString, forKey: "B")
        
        obj.saveInBackground { (success, error) in
            if(success){
                 ProgressHUD.showSuccess("关注成功", interaction: true)
            }else{
                ProgressHUD.showError("关注失败", interaction: true)
            }
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
            }
        }
        
       
        
        self.tableView?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
        self.tableView?.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefresh))
        headerRefresh()
        self.input = Bundle.main.loadNibNamed("InputView", owner: self, options: nil)?.last as? InputView
       
       
        self.input?.frame =  CGRect(x: 0, y: SCREEN_HEIGHT-100, width: SCREEN_WIDTH, height: 44)
        self.input?.bottom = SCREEN_HEIGHT-tg
        self.input?.delegate = self
        self.view.addSubview(self.input!)
        self.tableView.tableFooterView=input
        /*
        self.layView = UIView(frame: self.view.frame)
        self.layView?.backgroundColor = UIColor.gray
        self.layView?.alpha = 0
        let tap = UITapGestureRecognizer(target: self, action: Selector("tapLayView"))
        self.layView?.addGestureRecognizer(tap)
       
*/
       // self.view.insertSubview(self.layView!, belowSubview: self.input!)
       
        
        self.tableView.register(discussCell.self, forCellReuseIdentifier: "discussCell")
    }
    func tapInputView(){
        self.input?.inputTextView?.resignFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let object = self.dataArray[indexPath.row] as? AVObject
        let text = object!["text"] as? NSString
        
        let textSize = text?.boundingRect(with: CGSize(width: SCREEN_WIDTH-56-8, height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15)], context: nil).size
        
        
        
        return (textSize?.height)! + 30 + 25
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
    
    /**
     *  InputViewDelegate
     */
    func textViewHeightDidChange(height: CGFloat) {
        self.input?.height = height+10
        self.input?.bottom = SCREEN_HEIGHT - self.keyBoardHeight
    }
  
    
  func publishButtonDidClick() {
        ProgressHUD.show("")
    
        let object = AVObject(className: "discuss")
        object.setObject(self.input?.inputTextView?.text, forKey: "text")
        object.setObject(AVUser.current()?.username, forKey: "id")
        object.setObject(self.PostObject, forKey: "PostObject")
        object.saveInBackground { (success, error) -> Void in
            if success {
                self.input?.inputTextView?.resignFirstResponder()
                ProgressHUD.showSuccess("评论成功")
                
        
            }else{
                
            }
        }
    }
 
    func keyboardWillHide(_ inputView: InputView!, keyboardHeight: CGFloat, animationDuration duration: TimeInterval, animationCurve: UIViewAnimationCurve) {
        UIView.animate(withDuration: duration, delay: 0, options: .beginFromCurrentState, animations: { () -> Void in
            self.layView?.alpha = 0
            self.input?.bottom = SCREEN_HEIGHT
        }) { (finish) -> Void in
            self.layView?.isHidden = true
            self.input?.resetInputView()
            self.input?.inputTextView?.text = ""
            self.input?.bottom = SCREEN_HEIGHT
        }
        
    }
    func keyboardWillShow(_ inputView: InputView!, keyboardHeight: CGFloat, animationDuration duration: TimeInterval, animationCurve: UIViewAnimationCurve) {
        self.keyBoardHeight = keyboardHeight
        self.layView?.isHidden = false
        UIView.animate(withDuration: duration, delay: 0, options: .beginFromCurrentState, animations: { () -> Void in
            self.layView?.alpha = 0
            self.input?.bottom = SCREEN_HEIGHT-keyboardHeight
            
         
        
        }) { (finish) -> Void in
            
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
        
        cell.initFrame()
    
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
