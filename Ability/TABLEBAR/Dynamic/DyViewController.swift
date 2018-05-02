//
//  DyViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/4/24.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit
import AVOSCloud
class DyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UITextViewDelegate,SWTableViewCellDelegate{
    
    var dataArray = NSMutableArray()
    
    
    
    var IndexClick:IndexPath?
    
    var tableView:UITableView?
    var navigationView:UIView!
    
    var swipIndexPath:NSIndexPath?
    
    let imagePicView = UIView()
    let imagePic=UIImageView()
    let nameLable = UILabel()
    let avatorImage = UIImageView()
    var biaozhi = true
    var selectItems: [Bool] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        for _ in 0...10{
            selectItems.append(false)
            //  likeItems.append(false)
        }
        
        
        self.setNavigationBar()
        
        self.tableView=UITableView(frame: self.view.frame)
        self.tableView?.delegate=self
        self.tableView?.dataSource=self
        self.tableView?.tableHeaderView=headerView()
        self.tableView?.tableFooterView=UIView()
        self.tableView?.contentInset = UIEdgeInsets(top: 50,left: 0,bottom: 0,right: 0)
        self.view.addSubview(self.tableView!)
        
        
        
        self.tableView?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
        self.tableView?.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefresh))
        
        self.tableView?.mj_header.beginRefreshing()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func viewDidLayoutSubviews() {
        self.tableView?.separatorInset = UIEdgeInsets.zero
        self.tableView?.layoutMargins = UIEdgeInsets.zero
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        IndexClick=indexPath
    }
    func headerView() ->UIView{
        
        imagePicView.frame =  CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 225)
        imagePic.frame =  CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200)
        imagePic.image = UIImage(named: "t\(arc4random()%6)")
        imagePicView.addSubview(imagePic)
        imagePic.clipsToBounds = true
        self.nameLable.frame =  CGRect(x: 0, y: 165, width: 100, height: 18)
        self.nameLable.frame.origin.x = self.view.bounds.width - 130
        
        
        
        self.nameLable.text = AVUser.current()?.username
        self.nameLable.font = UIFont(name: MY_FONT, size: 20)
        self.nameLable.textColor = UIColor.gray
        self.avatorImage.frame = CGRect(x: 0, y: 150, width: 80, height:80)
        self.avatorImage.frame.origin.x = self.view.bounds.width - 85
        self.avatorImage.image = UIImage(named: "gou")
        
        self.view.layer.cornerRadius=40
        self.view.layer.masksToBounds=true
        
        let view:UIView = UIView(frame: CGRect(x: 0, y: 200, width: self.view.bounds.width, height:26))
        view.backgroundColor = UIColor.white
        
        
        let  query=AVQuery(className: "Custom_User")
        query.whereKey("id", equalTo: AVUser.current()?.username)
        let temp=query.findObjects() as! [AVObject]
        if(temp.count>0)
        {
            let U=temp[0]["portrait"] as! AVFile
            self.avatorImage.image=UIImage(data: U.getData()!)
            
            
        }
        
        imagePicView.addSubview(nameLable)
        imagePicView.addSubview(view)
        imagePicView.addSubview(avatorImage)
        return imagePicView
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identify:String = "SwiftCell\(indexPath.row)"
        //禁止重用机制
        var cell:defalutTableViewCell? = tableView.cellForRow(at: indexPath) as? defalutTableViewCell
        if cell == nil{
            cell = defalutTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identify)
        }
        
        
        // cell?.clickdelegate=self
        var obj=dataArray[indexPath.row] as! AVObject
        let idString=obj["id"] as! String
        cell!.setData(idString, imagePic: idString,content: obj["text"]! as! String,imgData: obj["pictureArr"]! as! [String],indexRow:indexPath,selectItem: selectItems[indexPath.row])
        cell!.displayView.tapedImageV = {[unowned self] index in
            cell!.pbVC.show(inVC: self,index: index)
        }
        cell?.avatorImage.tag=indexPath.row
        cell!.selectionStyle = .none
        
        cell!.heightZhi = { cellflag in
            self.selectItems[indexPath.row] = cellflag
            self.tableView?.reloadData()
        }
        
        
        cell?.avatorImage.isUserInteractionEnabled=true
        
        var tap=UITapGestureRecognizer(target: self, action: #selector(showOpV))
        cell?.avatorImage.addGestureRecognizer(tap)
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func showOpV(recognizer:UITapGestureRecognizer){
        
        var obj=dataArray[(recognizer.view?.tag)!] as! AVObject
        let idString=obj["id"] as! String
        
        print("showOpV   showOpV  showOpV\n\n\n\n\n\n\n\n n\n  \n")
        var v=UIStoryboard(name: "StoryboardOp", bundle: nil).instantiateViewController(withIdentifier: "OpStoryboard") as! OpTableViewController
        
        v.idString=idString
        self.navigationController?.pushViewController(v, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        let obj=dataArray[indexPath.row] as! AVObject
        var h_content = cellHeightByData(obj["text"]! as! String)
        let h_image = cellHeightByData1((obj["pictureArr"] as AnyObject).count)
        
        
        if h_content>13*5{
            if !self.selectItems[indexPath.row]{
                h_content = 13*5
            }
        }
        
        return h_content + h_image + 50 + 20
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        let offset:CGPoint = scrollView.contentOffset
        
        if (offset.y < 0) {
            var rect:CGRect = imagePic.frame
            rect.origin.y = offset.y
            rect.size.height = 200 - offset.y
            imagePic.frame = rect
        }
    }
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            //    self.commentView.commentTextField.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }
    
    func setNavigationBar(){
        
        
       
        
        //CGRect(x: 150, y: 20, width: SCREEN_WIDTH-150, height: 45)
        let addBookBtn = UIButton(frame: CGRect(x: SCREEN_WIDTH-100, y: 20, width: 100, height: 45))
        addBookBtn.setImage(UIImage(named:"plus circle"), for: .normal)
        addBookBtn.backgroundColor=UIColor.black
        addBookBtn.setTitleColor(UIColor.black, for: .normal)
        addBookBtn.setTitle("  新建帖子", for: .normal)
        addBookBtn.titleLabel?.font = UIFont(name: MY_FONT, size: 15)
        addBookBtn.contentHorizontalAlignment = .left        //按钮文字现实居左
        
        addBookBtn.addTarget(self, action:#selector(pushNewPost), for: .touchUpInside)
        
        
        self.view.addSubview(addBookBtn)
        
    }
    
    @objc func pushNewPost(){
        print("pushNewPost")
        
        let vc=pushNewPostViewController()
        GeneralFactory.addTitleWithTile(target: vc)
        self.present(vc, animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    /**
     *  上拉加载 、 下拉刷新
     */
    @objc func headerRefresh(){
        
        
        print("headerRefresh\n\n\n\n\n\n\n\n\n\n\n")
        let query = AVQuery(className: "newPost")
        query.order(byDescending: "createdAt")
        query.whereKey("id", equalTo: AVUser.current()?.username)
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
        let query = AVQuery(className: "newPost")
        query.order(byDescending: "createdAt")
        query.whereKey("id", equalTo: AVUser.current()?.username)
        query.limit = 20
        query.skip = self.dataArray.count
        //  query.whereKey("user", equalTo: AVUser.current())
        query.findObjectsInBackground { (results, error) -> Void in
            self.tableView?.mj_footer.endRefreshing()
            
            self.dataArray.addObjects(from: results!)
            self.tableView?.reloadData()
            
        }
        
    }
    
    
}

