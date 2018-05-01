//
//  CaiyiViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/5/1.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit

class CaiyiViewController: CSViewController {

    var xueke:SSButton?
    var shougong:SSButton?
    var wudao:SSButton?
    var yingyue:SSButton?
    var meishu:SSButton?
    var youxi:SSButton?
    var sheying:SSButton?
    var yundong:SSButton?
    var qita:SSButton?
    var label:UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
        
        label=UILabel(frame: CGRect(x: 20, y: 60, width: 200, height: 20))
        label?.text="  请选择你擅长的选项"
        self.view.addSubview(label!)
        
        let w=view.frame.width/2
        let h:CGFloat=20
        xueke = SSButton.init(frame: CGRect.zero,
                                             type: .custom,
                                             imageSize: CGSize(width:40,height:40),
                                             space: 8,
                                             titleTextType: SSButton.TitleTextType(rawValue: 0)!)
        
        xueke?.setTitle("学科", for: .normal)
        xueke?.setTitleColor(UIColor.black, for: .normal)
        
        xueke?.setImage(UIImage.init(named: "xueke"), for: .normal)  
        xueke?.frame = CGRect(x: w-170, y: 120, width: 100, height: 100)
        xueke?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.xueke?.layer.cornerRadius=(xueke?.frame.width)!/2
        xueke?.clipsToBounds=true
        self.view.addSubview(xueke!)
        xueke?.setTitleColor(UIColor.white, for: .selected)
        xueke?.addTarget(self, action: #selector(Click1), for: .touchUpInside)
        
        
        
        
        shougong = SSButton.init(frame: CGRect.zero,
                              type: .custom,
                              imageSize: CGSize(width:40,height:40),
                              space: 8,
                              titleTextType: SSButton.TitleTextType(rawValue: 0)!)
        
        shougong?.setTitle("手工", for: .normal)
        
        shougong?.setTitleColor(UIColor.black, for: .normal)
        shougong?.setImage(UIImage.init(named: "shougong"), for: .normal)
        shougong?.frame = CGRect(x: w-50, y: 120, width: 100, height: 100)
        shougong?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.shougong?.layer.cornerRadius=(xueke?.frame.width)!/2
        shougong?.clipsToBounds=true
        self.view.addSubview(shougong!)
        shougong?.setTitleColor(UIColor.white, for: .selected)
        shougong?.addTarget(self, action: #selector(Click2), for: .touchUpInside)
        
        
        
        
        
        wudao = SSButton.init(frame: CGRect.zero,
                              type: .custom,
                              imageSize: CGSize(width:40,height:40),
                              space: 8,
                              titleTextType: SSButton.TitleTextType(rawValue: 0)!)
        
        wudao?.setTitle("舞蹈", for: .normal)
        
        wudao?.setTitleColor(UIColor.black, for: .normal)
        wudao?.setImage(UIImage.init(named: "tiaowu"), for: .normal)
        wudao?.frame = CGRect(x: w+70, y: 120, width: 100, height: 100)
        wudao?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.wudao?.layer.cornerRadius=(xueke?.frame.width)!/2
        wudao?.clipsToBounds=true
        self.view.addSubview(wudao!)
        wudao?.setTitleColor(UIColor.white, for: .selected)
        wudao?.addTarget(self, action: #selector(Click3), for: .touchUpInside)
        
        
       
        yingyue = SSButton.init(frame: CGRect.zero,
                              type: .custom,
                              imageSize: CGSize(width:40,height:40),
                              space: 8,
                              titleTextType: SSButton.TitleTextType(rawValue: 0)!)
        
        yingyue?.setTitle("音乐", for: .normal)
        yingyue?.setTitleColor(UIColor.black, for: .normal)
        yingyue?.setImage(UIImage.init(named: "yingyue"), for: .normal)
        yingyue?.frame = CGRect(x:w-170, y:240, width: 100, height: 100)
        yingyue?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.yingyue?.layer.cornerRadius=(xueke?.frame.width)!/2
        yingyue?.clipsToBounds=true
        self.view.addSubview(yingyue!)
        yingyue?.setTitleColor(UIColor.white, for: .selected)
        yingyue?.addTarget(self, action: #selector(Click4), for: .touchUpInside)
        
        
        
        meishu = SSButton.init(frame: CGRect.zero,
                              type: .custom,
                              imageSize: CGSize(width:40,height:40),
                              space: 8,
                              titleTextType: SSButton.TitleTextType(rawValue: 0)!)
        
        meishu?.setTitle("美术", for: .normal)
        meishu?.setTitleColor(UIColor.black, for: .normal)
        xueke?.setImage(UIImage.init(named: "meishu"), for: .normal)
        meishu?.frame = CGRect(x: w-50, y: 240, width: 100, height: 100)
        meishu?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.meishu?.layer.cornerRadius=(meishu?.frame.width)!/2
        meishu?.clipsToBounds=true
        self.view.addSubview(meishu!)
        meishu?.setTitleColor(UIColor.white, for: .selected)
        meishu?.addTarget(self, action: #selector(Click5), for: .touchUpInside)
        
        
        
        youxi = SSButton.init(frame: CGRect.zero,
                              type: .custom,
                              imageSize: CGSize(width:40,height:40),
                              space: 8,
                              titleTextType: SSButton.TitleTextType(rawValue: 0)!)
        
        youxi?.setTitle("游戏", for: .normal)
        youxi?.setTitleColor(UIColor.black, for: .normal)
        youxi?.setImage(UIImage.init(named: "youxi"), for: .normal)
        youxi?.frame = CGRect(x:w+70, y: 240, width: 100, height: 100)
        youxi?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.youxi?.layer.cornerRadius=(youxi?.frame.width)!/2
        youxi?.clipsToBounds=true
        self.view.addSubview(youxi!)
        youxi?.setTitleColor(UIColor.white, for: .selected)
        youxi?.addTarget(self, action: #selector(Click6), for: .touchUpInside)
        
        
        
        sheying = SSButton.init(frame: CGRect.zero,
                              type: .custom,
                              imageSize: CGSize(width:40,height:40),
                              space: 8,
                              titleTextType: SSButton.TitleTextType(rawValue: 0)!)
        
        sheying?.setTitle("sheying", for: .normal)
        sheying?.setTitleColor(UIColor.black, for: .normal)
        sheying?.setImage(UIImage.init(named: "sheying"), for: .normal)
        sheying?.frame = CGRect(x: w-170, y: 360, width: 100, height: 100)
        sheying?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.sheying?.layer.cornerRadius=(sheying?.frame.width)!/2
        sheying?.clipsToBounds=true
        self.view.addSubview(sheying!)
        sheying?.setTitleColor(UIColor.white, for: .selected)
        sheying?.addTarget(self, action: #selector(Click7), for: .touchUpInside)
        
        
        
        yundong = SSButton.init(frame: CGRect.zero,
                              type: .custom,
                              imageSize: CGSize(width:40,height:40),
                              space: 8,
                              titleTextType: SSButton.TitleTextType(rawValue: 0)!)
        
        yundong?.setTitle("运动", for: .normal)
        yundong?.setTitleColor(UIColor.black, for: .normal)
        yundong?.setImage(UIImage.init(named: "yundong"), for: .normal)
        yundong?.frame = CGRect(x: w-50, y: 360, width: 100, height: 100)
        yundong?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.yundong?.layer.cornerRadius=(xueke?.frame.width)!/2
        yundong?.clipsToBounds=true
        self.view.addSubview(yundong!)
        yundong?.setTitleColor(UIColor.white, for: .selected)
        yundong?.addTarget(self, action: #selector(Click8), for: .touchUpInside)
        
        
        qita = SSButton.init(frame: CGRect.zero,
                              type: .custom,
                              imageSize: CGSize(width:40,height:40),
                              space: 8,
                              titleTextType: SSButton.TitleTextType(rawValue: 0)!)
        
        qita?.setTitle("其他", for: .normal)
        qita?.setTitleColor(UIColor.black, for: .normal)
        qita?.setImage(UIImage.init(named: "qita"), for: .normal)
        qita?.frame = CGRect(x: w+70, y: 360, width: 100, height: 100)
        qita?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.qita?.layer.cornerRadius=(qita?.frame.width)!/2
        qita?.clipsToBounds=true
        self.view.addSubview(qita!)
        qita?.setTitleColor(UIColor.white, for: .selected)
        qita?.addTarget(self, action: #selector(Click9), for: .touchUpInside)
    
     
    }
    @objc func Click1(sender:SSButton){
    
        sender.isSelected = !(sender.isSelected)
        
        if(sender.isSelected){
            sender.backgroundColor=UIColor.gray
        }else{
             sender.backgroundColor=UIColor.white
        }
    }
    
    @objc func Click2(sender:SSButton){
        
        sender.isSelected = !(sender.isSelected)
        
        if(sender.isSelected){
            sender.backgroundColor=UIColor.gray
        }else{
            sender.backgroundColor=UIColor.white
        }
    }
    
    @objc func Click3(sender:SSButton){
        
        sender.isSelected = !(sender.isSelected)
        
        if(sender.isSelected){
            sender.backgroundColor=UIColor.gray
        }else{
            sender.backgroundColor=UIColor.white
        }
    }
    
    @objc func Click4(sender:SSButton){
        
        sender.isSelected = !(sender.isSelected)
        
        if(sender.isSelected){
            sender.backgroundColor=UIColor.gray
        }else{
            sender.backgroundColor=UIColor.white
        }
    }
    
    @objc func Click5(sender:SSButton){
        
        sender.isSelected = !(sender.isSelected)
        
        if(sender.isSelected){
            sender.backgroundColor=UIColor.gray
        }else{
            sender.backgroundColor=UIColor.white
        }
    }
    
    @objc func Click6(sender:SSButton){
        
        sender.isSelected = !(sender.isSelected)
        
        if(sender.isSelected){
            sender.backgroundColor=UIColor.gray
        }else{
            sender.backgroundColor=UIColor.white
        }
    }
    @objc func Click7(sender:SSButton){
        
        sender.isSelected = !(sender.isSelected)
        
        if(sender.isSelected){
            sender.backgroundColor=UIColor.gray
        }else{
            sender.backgroundColor=UIColor.white
        }
    }
    @objc func Click8(sender:SSButton){
        
        sender.isSelected = !(sender.isSelected)
        
        if(sender.isSelected){
            sender.backgroundColor=UIColor.gray
        }else{
            sender.backgroundColor=UIColor.white
        }
    }
    @objc func Click9(sender:SSButton){
        
        sender.isSelected = !(sender.isSelected)
        
        if(sender.isSelected){
            sender.backgroundColor=UIColor.gray
        }else{
            sender.backgroundColor=UIColor.white
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func sure(){
        
        print("sure")
        
        
        //  print(imgArr.count)
        
       // let obj=AVObject(className: "newPost")
       // obj.setObject(AVUser.current()?.username, forKey: "id")
       //
        
        
        //obj.saveInBackground()
        /*
         let obj=AVObject(className: "factory")
         if let temp=photoImageView.image
         {
         let data=UIImagePNGRepresentation((photoImageView.image)!)
         let file=AVFile(data: data!)
         obj.setObject(file, forKey: "image")
         }
         obj.setObject(text.text, forKey: "string")
         
         obj.saveInBackground()*/
        
    }
    
    override func close(){
        print("close")
        self.dismiss(animated: true, completion: nil)
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
