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
    
    
    
    let dataArry=[" 个性签名","特长标签"," 性别"," 生日"," 学校"," 行业"," 职业"," 兴趣标签"]
    var IndexClick:IndexPath?
    
    var tableView:UITableView?
    let imagePicView = UIView()

    
    
    var imageine:UIImageView?

    var labelId:UILabel?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
      
    
        self.tableView=UITableView(frame: self.view.frame)
        
        self.tableView?.delegate=self
        self.tableView?.dataSource=self
        self.tableView?.tableHeaderView=headerView()
        self.tableView?.tableFooterView=UIView()
        self.view.addSubview(self.tableView!)
      
     
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden=true
        
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
        style = UITableViewCellStyle.default
        text = "default_text"
        var text_detail=""
        cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell (style: style, reuseIdentifier: cellId)
        }
        text=dataArry[indexPath.row]
        cell?.imageView?.image = image
        cell?.textLabel?.text = text
        cell?.detailTextLabel?.text = detailText
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
            GeneralFactory.addTitleWithTile(target: vc)
            self.present(vc, animated: true, completion: nil)
            
            break
            //    text = " 个性签名"
            
        case "特长标签"?:
              let vc=CaiyiViewController()
            GeneralFactory.addTitleWithTile(target: vc)
            self.present(vc, animated: true, completion: nil)
            
            break
            
            //    text = " 特长标签"
            
        case " 性别"?:
            
            let alertController = UIAlertController()
            let cancelAction = UIAlertAction(title: "男", style: .default, handler: nil)
            let deleteAction = UIAlertAction(title: "女", style: .default, handler: nil)
            let archiveAction = UIAlertAction(title: "保存", style: .destructive, handler: nil)
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            alertController.addAction(archiveAction)
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
                print("date select: \(datePicker.date.description)")
                //获取上一节中自定义的按钮外观DateButton类，设置DateButton类属性thedate
              //  let myDateButton=self.Datebutt as? DateButton
             //   myDateButton?.thedate=datePicker.date
                //强制刷新
              //  myDateButton?.setNeedsDisplay()
            })
            alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel,handler:nil))
            
            alertController.view.addSubview(datePicker)
            
            self.present(alertController, animated: true, completion: nil)
            
            break
            
        //    text = " 生日"
        case " 学校"?:
            let vc=SignatureViewController()
            GeneralFactory.addTitleWithTile(target: vc)
            self.present(vc, animated: true, completion: nil)
            
            break
            
        //   text = " 学校"
        case " 行业"?:
            
            let vc=SignatureViewController()
            GeneralFactory.addTitleWithTile(target: vc)
            self.present(vc, animated: true, completion: nil)
            
            
            break
        //    text = " 行业"
        case " 职业"?:
            
            let vc=SignatureViewController()
            GeneralFactory.addTitleWithTile(target: vc)
            self.present(vc, animated: true, completion: nil)
            
            break
            
       
        case " 兴趣标签"?: break
            
       
        default: break
            
            //  text = ""
        }
        
        
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

