//
//  DesignViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/4/30.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit
import AVOSCloud
class DesignViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var token=""
    
    
    
    let dataArry=[" 个性签名"," 特长标签"," 性别"," 生日"," 学校"," 行业"," 职业"," 兴趣标签"]
    let caiyi=["学科","手工","舞蹈","音乐","美术","游戏","摄影","运动","其他"]
    var shanchang=[false,false,false,false,false,false,false,false,false]
    var ganxingqu=[false,false,false,false,false,false,false,false,false]
    var IndexClick:IndexPath?
    
    var tableView:UITableView?
    let imagePicView = UIView()

    
    
    var imageine:UIImageView?

    var labelId:UILabel?
    
    var obj:AVObject?
    
    var l1=""
    var l2=""
    var l3=""
    var l4=""
    var l5=""
    var l6=""
    var l7=""
    var l8=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
      
    
        self.tableView=UITableView(frame: self.view.frame)
        
        self.tableView?.delegate=self
        self.tableView?.dataSource=self
        self.tableView?.tableHeaderView=headerView()
        self.tableView?.tableFooterView=UIView()
        self.view.addSubview(self.tableView!)
      
        
        let  query=AVQuery(className: "Custom_User")
        query.whereKey("id", equalTo: AVUser.current()?.username)
        let temp=query.findObjects() as! [AVObject]
        if(temp.count>0)
        {
         obj=temp[0]
        }
     
        
            if let detail=obj!["signature"]
            {
                l1 = detail as! String
            }
        
            if let detail=obj!["special"]
            {
                let arry=detail as! [Bool]
                for i in 0...8{
                    shanchang[i]=arry[i]
                    if(arry[i]){
                        l2=l2+"\(caiyi[i])、"
                    }
                }
               
            }
        
            
            if let detail=obj!["sex"]
            {
                l3 = detail as! String
            }
        
            if let detail=obj!["birth"]
            {
                l4 = detail as! String
            }
          
            if let detail=obj!["school"]
            {
                l5 = detail as! String
            }
       
            if let detail=obj!["business"]
            {
                l6 = detail as! String
            }
            
            if let detail=obj!["work"]
            {
                l7 = detail as! String
            }
         
            if let detail=obj!["interest"]
            {
                let arry=detail as! [Bool]
                for i in 0...8{
                    ganxingqu[i]=arry[i]
                    if(arry[i]){
                        l8=l8+"\(caiyi[i])、"
                    }
                }
            
            }
           
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden=true
        let  query=AVQuery(className: "Custom_User")
        query.whereKey("id", equalTo: AVUser.current()?.username)
        let temp=query.findObjects() as! [AVObject]
        if(temp.count>0)
        {
            obj=temp[0]
        }
        
        
        if let detail=obj!["signature"]
        {
            l1 = detail as! String
        }
        
        if let detail=obj!["special"]
        {
            let arry=detail as! [Bool]
            for i in 0...8{
                shanchang[i]=arry[i]
                if(arry[i]){
                    l2=l2+"\(caiyi[i])、"
                }
            }
            l2 = detail as! String
        }
        
        
        if let detail=obj!["sex"]
        {
            l3 = detail as! String
        }
        
        if let detail=obj!["birth"]
        {
            l4 = detail as! String
        }
        
        if let detail=obj!["school"]
        {
            l5 = detail as! String
        }
        
        if let detail=obj!["business"]
        {
            l6 = detail as! String
        }
        
        if let detail=obj!["work"]
        {
            l7 = detail as! String
        }
        
        if let detail=obj!["interest"]
        {
            l8 = detail as! String
        }
        
        
        tableView?.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
       self.tabBarController?.tabBar.isHidden=false
    }
    
    override func viewDidLayoutSubviews() {
        self.tableView?.separatorInset = UIEdgeInsets.zero
        self.tableView?.layoutMargins = UIEdgeInsets.zero
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets.zero
    }
    
    
    func headerView() ->UIView{
        
        CGRect(x: 0, y: 200, width: self.view.bounds.width, height:26)
        
        imagePicView.frame =  CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 225)
       
      
        imageine=UIImageView(frame: CGRect(x: self.view.frame.width/2-50, y: 50, width: 100, height: 100))
        imagePicView.addSubview(imageine!)
        
        let  query=AVQuery(className: "Custom_User")
        query.whereKey("id", equalTo: AVUser.current()?.username)
        let temp=query.findObjects() as! [AVObject]
        if(temp.count>0)
        {
            let U=temp[0]["portrait"] as! AVFile
            imageine?.image=UIImage(data: U.getData()!)
          
        }
        
        labelId=UILabel(frame: CGRect(x: self.view.frame.width/2-50, y: 150, width: 100, height: 40))
        labelId?.text=AVUser.current()?.username
        labelId?.textAlignment=NSTextAlignment.center
        imagePicView.addSubview(labelId!)
        return imagePicView
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellId: String
        var cell: UITableViewCell? = nil
        var style: UITableViewCellStyle
        let image = UIImage (named: "cellImage")
        var text: String
        let detailText = "detail_text"
        cellId = "value1xx"
        style = UITableViewCellStyle.value1
        
        var text_detail=""
        cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell (style: style, reuseIdentifier: cellId)
        }
        text=dataArry[indexPath.row]
        //cell?.imageView?.image = image
        cell?.textLabel?.text = text
        
        switch indexPath.row {
        case 0:
            
                cell?.detailTextLabel?.text = l1
            break
            
        case 1:
            
            l2=""
            for i in 0...8{
                if(shanchang[i]){
                    l2=l2+"\(caiyi[i])、"
                }
            }
                cell?.detailTextLabel?.text = l2
           
            break
        case 2:
            
            
                cell?.detailTextLabel?.text = l3
            
            break
        case 3:
            
            
                cell?.detailTextLabel?.text = l4
            
            break
        case 4:
            
            
                cell?.detailTextLabel?.text = l5
            
            break
        case 5:
            
            
                cell?.detailTextLabel?.text = l6
            
            break
        case 6:
            
        
                cell?.detailTextLabel?.text = l7
            
            break
        case 7:
            l2=""
            for i in 0...8{
                if(ganxingqu[i]){
                    l8=l8+"\(caiyi[i])、"
                }
            }
        
                cell?.detailTextLabel?.text = l8
            
            break
        default:
            break
        }
       
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell!
    }
    
   
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let cell=tableView.cellForRow(at: indexPath)
        print("sdfasd\n\n")
        print(cell?.textLabel?.text)
        print("q\n\n\n")
        switch cell?.textLabel?.text {
        case " 个性签名"?:
            print("sdfasd\n\n")
            print(indexPath.row)
            let vc=SignatureViewController()
            vc.placehoderStr="Ta说这个性签名还得再想想"
            GeneralFactory.addTitleWithTile(target: vc)
            if(l1 != ""){
                vc.textView.text=l1
            }
            vc.closure={
                (str:String) -> ()
                in
                self.l1=str
            }
            self.present(vc, animated: true, completion: nil)
            
            break
            //    text = " 个性签名"
            
        case " 特长标签"?:
              let vc=CaiyiViewController()
              vc.shanchang=self.shanchang
              GeneralFactory.addTitleWithTile(target: vc)
              
              vc.closure={
                (x:[Bool]) -> ()
                in
                self.shanchang=x
              }
             
            self.present(vc, animated: true, completion: nil)
            
              
              
              
            break
            
            //    text = " 特长标签"
            
        case " 性别"?:
            
            let alertController = UIAlertController()
            let cancelAction = UIAlertAction(title: "男", style: .default, handler:
            {(action:UIAlertAction)->Void in self.l3="男"})
            let deleteAction = UIAlertAction(title: "女", style: .default, handler: {(action:UIAlertAction)->Void in self.l3="女"})
           
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel,handler:nil))
            self.present(alertController, animated: true, completion: nil)
            
            break
        //    text = " 性别"
        case " 生日"?:
            
            
            let alertController:UIAlertController=UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
            // 初始化 datePicker
            let datePicker = UIDatePicker( )
            //将日期选择器区域设置为中文，则选择器日期显示为中文
            datePicker.locale = NSLocale(localeIdentifier: "zh_CN") as Locale
            // 设置样式，当前设为同时显示日期和时间
            datePicker.datePickerMode = UIDatePickerMode.date
            // 设置默认时间
            datePicker.date = NSDate() as Date
            // 响应事件（只要滚轮变化就会触发）
            // datePicker.addTarget(self, action:Selector("datePickerValueChange:"), forControlEvents: UIControlEvents.ValueChanged)
            alertController.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default){
                (alertAction)->Void in
                
               // print("date select: \(datePicker.date.description)山东分公司的风格")
                
                let format = DateFormatter()
                format.dateFormat = "yyyy-MM-dd"
                
                print("date select: \(format.string(for:datePicker.date))山东分公司的风格")
                self.l4=format.string(for:datePicker.date)!
            })
            alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel,handler:nil))
            
            alertController.view.addSubview(datePicker)
            
            self.present(alertController, animated: true, completion: nil)
            
            break
            
        //    text = " 生日"
        case " 学校"?:
            let vc=SignatureViewController()
            vc.placehoderStr="请输入您的学校"
            GeneralFactory.addTitleWithTile(target: vc)
            self.present(vc, animated: true, completion: nil)
            
            break
            
        //   text = " 学校"
        case " 行业"?:
            
            let vc=HangTableViewController()
            vc.closure={
                (str:String) -> ()
                in
                self.l6=str
            }
            self.present(vc, animated: true, completion: nil)
            
            
            break
        //    text = " 行业"
        case " 职业"?:
            
            let vc=SignatureViewController()
             vc.placehoderStr="请输入您的职业"
            GeneralFactory.addTitleWithTile(target: vc)
            self.present(vc, animated: true, completion: nil)
            
            break
            
       
        case " 兴趣标签"?:
            let vc=InterestViewController()
            
            vc.shanchang=self.ganxingqu
            GeneralFactory.addTitleWithTile(target: vc)
            
            vc.closure={
                (x:[Bool]) -> ()
                in
                self.ganxingqu=x
            }
            GeneralFactory.addTitleWithTile(target: vc)
            self.present(vc, animated: true, completion: nil)
            break
            
       
        default: break
            
            //  text = ""
        }
        
        tableView.reloadData()
    }
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return self.dataArray.count
        return dataArry.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    
    
    
    func setNavigationBar(){
        /*
        
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
        */
        
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
    
    
    
}

