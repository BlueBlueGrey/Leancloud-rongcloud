//
//  onerecommendViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/5/2.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit
import Alamofire
import AVOSCloud
class onerecommendViewController:UIViewController, UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UITextViewDelegate,SWTableViewCellDelegate,CLLocationManagerDelegate{
    var StrAnswer=""
    let locationManager:CLLocationManager = CLLocationManager()
    var lat:CLLocationDegrees?
    var longi:CLLocationDegrees?
    
    var token=""
    var dataArray = NSMutableArray()
    
    var kind:Int?
    
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
        
        locationManager.delegate = self
        //设置定位进度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //更新距离
        locationManager.distanceFilter = 100
        ////发送授权申请
        locationManager.requestAlwaysAuthorization()
        if (CLLocationManager.locationServicesEnabled())
        {
            //允许使用定位服务的话，开启定位服务更新
            locationManager.startUpdatingLocation()
            print("定位开始")
        }
        
        for _ in 0...30{
            selectItems.append(false)
            //  likeItems.append(false)
        }
        
        
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
        //  self.navigationView.isHidden = false
        
        print("==========+++===========+++===========")
        print(kind)
        print("==========+++===========+++===========")
    }
    override func viewWillDisappear(_ animated: Bool) {
        //  self.navigationView.isHidden = true
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
        
        if(kind==0){
        let format = DateFormatter()
        format.dateFormat = "yy-MM-dd hh:mm"
        
        
        let date = obj["createdAt"] as? NSDate
      
        cell?.timeLabel.numberOfLines=0
        cell?.timeLabel.text = format.string(from: date! as Date)
      
        }else{
        cell?.timeLabel.text="附近的人"
        }
        /*
        if(kind==1){
            let geocoder = CLGeocoder()
            
            var StrAnswer=""
            let currentLocation = CLLocation(latitude:lat!, longitude:longi!)
            geocoder.reverseGeocodeLocation(currentLocation, completionHandler: {
                (placemarks:[CLPlacemark]?, error:Error?) -> Void in
                //强制转成简体中文
                let array = NSArray(object: "zh-hans")
                UserDefaults.standard.set(array, forKey: "AppleLanguages")
                //显示所有信息
                if error != nil {
                    //print("错误：\(error.localizedDescription))")
                    //  self.textView?.text = "错误：\(error!.localizedDescription))"
                    return
                }
                
                if let p = placemarks?[0]{
                    print(p) //输出反编码信息
                    var address = ""
                    
                    if let country = p.country {
                        address.append("国家：\(country)\n")
                        //  StrAnswer=StrAnswer+" \(country)"
                    }
                    if let administrativeArea = p.administrativeArea {
                        address.append("省份：\(administrativeArea)\n")
                        StrAnswer=StrAnswer+" \(administrativeArea)"
                    }
                    if let subAdministrativeArea = p.subAdministrativeArea {
                        address.append("其他行政区域信息（自治区等）：\(subAdministrativeArea)\n")
                    }
                    if let locality = p.locality {
                        address.append("城市：\(locality)\n")
                        StrAnswer=StrAnswer+" \(locality)"
                    }
                    if let subLocality = p.subLocality {
                        address.append("区划：\(subLocality)\n")
                    }
                    if let thoroughfare = p.thoroughfare {
                        address.append("街道：\(thoroughfare)\n")
                    }
                    if let subThoroughfare = p.subThoroughfare {
                        address.append("门牌：\(subThoroughfare)\n")
                    }
                    if let name = p.name {
                        address.append("地名：\(name)\n")
                    }
                    if let isoCountryCode = p.isoCountryCode {
                        address.append("国家编码：\(isoCountryCode)\n")
                    }
                    if let postalCode = p.postalCode {
                        address.append("邮编：\(postalCode)\n")
                    }
                    if let areasOfInterest = p.areasOfInterest {
                        address.append("关联的或利益相关的地标：\(areasOfInterest)\n")
                    }
                    if let ocean = p.ocean {
                        address.append("海洋：\(ocean)\n")
                    }
                    if let inlandWater = p.inlandWater {
                        address.append("水源，湖泊：\(inlandWater)\n")
                    }
                    if(self.kind==1){
                        
                        cell?.textLabel?.text = StrAnswer
                    }
                    //self.textView?.text = address
                } else {
                    print("No placemarks!")
                }
            })
            
        }
        */
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
        if(kind == 0){
            
            let query3 = AVQuery(className: "AtoB")
            query3.whereKey("A", equalTo: AVUser.current())
            query3.findObjectsInBackground({ (results, error) in
                if let R=results {
                   
                    self.tableView?.mj_header.endRefreshing()
                    self.dataArray.removeAllObjects()
                    for i in 0..<R.count{
                        
                        let obj=R[i] as! AVObject
                         let query4=AVQuery(className: "newPost")
                        query4.whereKey("id", equalTo: obj["B"] as! String)
                        query4.findObjectsInBackground({ (RR, EE) in
                            if let RRR=RR{
                                self.dataArray.addObjects(from: RR!)
                                self.tableView?.reloadData()
                            }
                        })
                        
                    }
                    self.tableView?.reloadData()
                    
                }
            })
            
            
        }else{
            
            let query3 = AVQuery(className: "newPost")
            
            query3.findObjectsInBackground({ (results, error) in
                if let R=results {
                    self.tableView?.mj_header.endRefreshing()
                    self.dataArray.removeAllObjects()
                    for i in 0..<R.count{
                        
                        let obj=R[i] as! AVObject
                        if(obj["id"] as! String != AVUser.current()?.username){
                            
                            if let x=obj["lat"]{
                                let lat=x as! Double
                                if let y=obj["longi"]{
                                    let longi=y as! Double
                                    var currentLocation=CLLocation(latitude: self.lat!, longitude: self.longi!)
                                    var targetLocation=CLLocation(latitude: lat, longitude: longi)
                                    
                                    var distance:CLLocationDistance=currentLocation.distance(from: targetLocation)
                                    print(distance)
                                    print("===============================================================================")
                                    if(distance < 5000){
                                        var currentLocation=CLLocation(latitude: lat, longitude: longi)
                                        self.dataArray.add(obj)
                                    }
                                }
                            }
                        }
                        
                    }
                    self.tableView?.reloadData()
                    
                }
            })
            
            
            
            
            
            
        }
        
        
    }
    
    @objc func footerRefresh(){
        
        print("headerRefresh\n\n\n\n\n\n\n\n\n\n\n")
        let query = AVQuery(className: "newPost")
        query.order(byDescending: "createdAt")
        
        query.limit = 20
        query.skip = 0
        //  query.whereKey("user", equalTo: AVUser.current())
        if(kind == 0){
            
            let query3 = AVQuery(className: "AtoB")
            query3.whereKey("A", equalTo: AVUser.current())
            query3.findObjectsInBackground({ (results, error) in
                if let R=results {
                    
                    self.tableView?.mj_footer.endRefreshing()
                    self.dataArray.removeAllObjects()
                    for i in 0..<R.count{
                        
                        let obj=R[i] as! AVObject
                        let query4=AVQuery(className: "newPost")
                        query4.whereKey("id", equalTo: obj["B"] as! String)
                        query4.findObjectsInBackground({ (RR, EE) in
                            if let RRR=RR{
                                  self.dataArray.addObjects(from: RR!)
                                  self.tableView?.reloadData()
                            }
                        })
                        
                    }
                    self.tableView?.reloadData()
                    
                }
            })
        }else{
            
            let query3 = AVQuery(className: "Custom_User")
            
            query3.findObjectsInBackground({ (results, error) in
                if let R=results {
                    self.tableView?.mj_footer.endRefreshing()
                    self.dataArray.removeAllObjects()
                    for i in 0..<R.count{
                        
                        let obj=R[i] as! AVObject
                        if(obj["id"] as! String != AVUser.current()?.username){
                            
                            if let x=obj["lat"]{
                                let lat=x as! Double
                                if let y=obj["longi"]{
                                    let longi=y as! Double
                                    var currentLocation=CLLocation(latitude: self.lat!, longitude: self.longi!)
                                    var targetLocation=CLLocation(latitude: lat, longitude: longi)
                                    
                                    var distance:CLLocationDistance=currentLocation.distance(from: targetLocation)
                                    print(distance)
                                    print("===============================================================================")
                                    if(distance < 5000){
                                        var currentLocation=CLLocation(latitude: lat, longitude: longi)
                                    }
                                }
                            }
                        }
                        
                    }
                    self.tableView?.reloadData()
                    
                }
            })
            
            
            
            
            
            
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //获取最新的坐标
        let currLocation:CLLocation = locations.last!
        
        longi = currLocation.coordinate.longitude
        //获取纬度
        
        lat = currLocation.coordinate.latitude
        
        
    }
    
    //地理信息反编码
    func reverseGeocode(x:Double,y:Double,po:IndexPath){
        let geocoder = CLGeocoder()
        
        var StrAnswer=""
        let currentLocation = CLLocation(latitude:x, longitude:y)
        geocoder.reverseGeocodeLocation(currentLocation, completionHandler: {
            (placemarks:[CLPlacemark]?, error:Error?) -> Void in
            //强制转成简体中文
            let array = NSArray(object: "zh-hans")
            UserDefaults.standard.set(array, forKey: "AppleLanguages")
            //显示所有信息
            if error != nil {
                //print("错误：\(error.localizedDescription))")
              //  self.textView?.text = "错误：\(error!.localizedDescription))"
                return
            }
            
            if let p = placemarks?[0]{
                print(p) //输出反编码信息
                var address = ""
                
                if let country = p.country {
                    address.append("国家：\(country)\n")
                  //  StrAnswer=StrAnswer+" \(country)"
                }
                if let administrativeArea = p.administrativeArea {
                    address.append("省份：\(administrativeArea)\n")
                   StrAnswer=StrAnswer+" \(administrativeArea)"
                }
                if let subAdministrativeArea = p.subAdministrativeArea {
                    address.append("其他行政区域信息（自治区等）：\(subAdministrativeArea)\n")
                }
                if let locality = p.locality {
                    address.append("城市：\(locality)\n")
                   StrAnswer=StrAnswer+" \(locality)"
                }
                if let subLocality = p.subLocality {
                    address.append("区划：\(subLocality)\n")
                }
                if let thoroughfare = p.thoroughfare {
                    address.append("街道：\(thoroughfare)\n")
                }
                if let subThoroughfare = p.subThoroughfare {
                    address.append("门牌：\(subThoroughfare)\n")
                }
                if let name = p.name {
                    address.append("地名：\(name)\n")
                }
                if let isoCountryCode = p.isoCountryCode {
                    address.append("国家编码：\(isoCountryCode)\n")
                }
                if let postalCode = p.postalCode {
                    address.append("邮编：\(postalCode)\n")
                }
                if let areasOfInterest = p.areasOfInterest {
                    address.append("关联的或利益相关的地标：\(areasOfInterest)\n")
                }
                if let ocean = p.ocean {
                    address.append("海洋：\(ocean)\n")
                }
                if let inlandWater = p.inlandWater {
                    address.append("水源，湖泊：\(inlandWater)\n")
                }
                
                //self.textView?.text = address
            } else {
                print("No placemarks!")
            }
        })
        
    }
    
}

