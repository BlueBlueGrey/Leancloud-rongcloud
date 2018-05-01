//
//  CommunityViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/3/14.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit
import AVOSCloud
import Alamofire
class CommunityViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UITextViewDelegate,SWTableViewCellDelegate{
   var token=""
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
        // 单前 用户登录
       // AVUser.logOut()
        if AVUser.current() == nil {
            print("nil    ----------------")
            print("nil    ===============----------------")
            print("nil    ===============----------------")
            print("nil    ===============----------------")
            print("nil    ===============----------------")
            // story
            let story = UIStoryboard(name: "LoginStoryboard", bundle: nil)
            let loginVC = story.instantiateViewController(withIdentifier: "NavigationLogin")
            self.present(loginVC, animated: true, completion: { () -> Void in
                
            })}
        
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

    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationView.isHidden = false
        
        
        
        if AVUser.current() == nil {
            print("nil    ----------------")
            print("nil    ===============----------------")
            print("nil    ===============----------------")
            print("nil    ===============----------------")
            print("nil    ===============----------------")
            // story
            let story = UIStoryboard(name: "LoginStoryboard", bundle: nil)
            let loginVC = story.instantiateViewController(withIdentifier: "NavigationLogin")
            self.present(loginVC, animated: true, completion: { () -> Void in
                
            })}
        else{
            requestToken1(userID: (AVUser.current()?.username)!)
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationView.isHidden = true
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
        
        CGRect(x: 0, y: 200, width: self.view.bounds.width, height:26)
        
        
        
        imagePicView.frame =  CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 225)
        imagePic.frame =  CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200)
        imagePic.image = UIImage(named: "mp")
        imagePicView.addSubview(imagePic)
        imagePic.clipsToBounds = true
        self.nameLable.frame =  CGRect(x: 0, y: 170, width: 60, height: 18)
        self.nameLable.frame.origin.x = self.view.bounds.width - 140
        self.nameLable.text = "我的背景"
        self.nameLable.font = UIFont.systemFont(ofSize: 16)
        self.nameLable.textColor = UIColor.white
        self.avatorImage.frame = CGRect(x: 0, y: 150, width: 70, height:70)
        self.avatorImage.frame.origin.x = self.view.bounds.width - 80
        self.avatorImage.image = UIImage(named: "gou")
        self.avatorImage.layer.borderWidth = 2
        self.avatorImage.layer.borderColor = UIColor.white.cgColor
        let view:UIView = UIView(frame: CGRect(x: 0, y: 200, width: self.view.bounds.width, height:26))
        view.backgroundColor = UIColor.white
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
        
        
        let format = DateFormatter()
        format.dateFormat = "yy-MM-dd hh:mm"
        
        
        let date = obj["createdAt"] as? NSDate
        cell?.timeLabel.numberOfLines=0
        cell?.timeLabel.text = format.string(from: date! as Date)
        
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
        
        print("showOpV   showOpV  showOpV")
       
        if(idString==AVUser.current()?.username){
        self.tabBarController?.selectedIndex=2
        }
        else{
          let v=UIStoryboard(name: "StoryboardOp", bundle: nil).instantiateViewController(withIdentifier: "OpStoryboard") as! OpTableViewController
            v.PostObject=obj
            v.idString=idString
            
            
            self.navigationController?.pushViewController(v, animated: true)
        }
       
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
        
       
        navigationView = UIView(frame:  CGRect(x: 0, y: -20, width: SCREEN_WIDTH, height: 65))
        navigationView.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.addSubview(navigationView)
        
        CGRect(x: 20, y: 20, width: SCREEN_WIDTH, height: 45)
        let addBookBtn = UIButton(frame: CGRect(x: 20, y: 20, width: SCREEN_WIDTH, height: 45))
        addBookBtn.setImage(UIImage(named:"plus circle"), for: .normal)
     
        addBookBtn.setTitleColor(UIColor.black, for: .normal)
        addBookBtn.setTitle("  新建帖子", for: .normal)
        addBookBtn.titleLabel?.font = UIFont(name: MY_FONT, size: 15)
        addBookBtn.contentHorizontalAlignment = .left        //按钮文字现实居左
        
        addBookBtn.addTarget(self, action:#selector(pushNewPost), for: .touchUpInside)
        
        
        navigationView.addSubview(addBookBtn)
        
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
        query.limit = 20
        query.skip = self.dataArray.count
      //  query.whereKey("user", equalTo: AVUser.current())
        query.findObjectsInBackground { (results, error) -> Void in
            self.tableView?.mj_footer.endRefreshing()
            
            self.dataArray.addObjects(from: results!)
            self.tableView?.reloadData()
            
        }
        
    }

    
    func requestToken1(userID:String) -> Void {
        let dicUser = ["userId":userID,
                       "name":userID,
                       "portraitUrl":"http://img3.duitang.com/uploads/item/201508/30/20150830083023_N3rTL.png"
        ] //请求token的用户信息
        let urlStr = "https://api.cn.ronghub.com/user/getToken.json" //网址接口
        let appKey = "3argexb630cme"
        let appSecret = "11pfdtC8NnB"
        let nonce = "\(arc4random())"   //生成随机数
        let timestamp = "\(NSDate().timeIntervalSince1970)"//时间戳
        var sha1Value = appSecret + nonce + timestamp
        sha1Value = sha1Value.sha1()//数据签名,sha1是一个加密的方法
        let headers = [ //照着文档要求写的Http 请求的 4个head
            "App-key":appKey
            ,"Nonce":nonce
            ,"Timestamp":timestamp
            ,"Signature":sha1Value
        ]
        Alamofire.request(urlStr, method: .post, parameters: dicUser , encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            print(response)
            if let dic = response.result.value  as? NSDictionary{
                let code = dic.value(forKey: "code") as! NSNumber
                if code.stringValue == "200" {
                    print(dic.value(forKey: "token"))
                    self.token=dic.value(forKey: "token") as! String
                    
                    print("sadfasf  "+self.token)
                    self.ConnectOne()
                }
            }
        }
    }
    
    func ConnectOne()->Void{
        RCIM.shared().initWithAppKey("3argexb630cme")
        
        
        RCIM.shared().connect(withToken: token,success: { (userId) -> Void in
            print("登陆成功。当前登录的用户ID：\(userId)")
        }, error: { (status) -> Void in
            print("登陆的错误码为:\(status.rawValue)")
        }, tokenIncorrect: {
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            print("token错误")
        })
        
    }

}
