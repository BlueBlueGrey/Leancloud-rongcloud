//
//  LOGINViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/3/11.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit
import LeanCloud
import AVOSCloud
import Alamofire
class LOGINViewController: UIViewController,UITextFieldDelegate{

    var token=""
    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var id: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        
        id.delegate=self
        id.returnKeyType=UIReturnKeyType.done
        password.delegate=self
        password.returnKeyType=UIReturnKeyType.done
        
        photo.image=UIImage(named:"mp")?.roundCornersToCircle()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        id.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        print("停止编辑")
        if(id.text != ""){
            
            print("id.text")
            let  query=AVQuery(className: "Custom_User")
            query.whereKey("id", matchesRegex: id.text!)
            let temp=query.findObjects() as! [AVObject]
            if(temp.count>0)
            {
            let U=temp[0]["portrait"] as! AVFile
            self.photo.image=UIImage(data: U.getData()!)
          //  let U=temp!["image"] as! AVFile
          //  photoImageView.image=UIImage(data: U.getData()!)
           // text.text=temp?["string"] as! String
            }
        }
        return true
    }
    
    @IBAction func LOGIN(_ sender: UIButton) {
        
        AVUser.logInWithUsername(inBackground: self.id.text!, password: self.password.text!) { (user, error) -> Void in
            if error == nil {
                self.requestToken1(userID: self.id.text!)
                self.dismiss(animated: true, completion: { () -> Void in
                    
                })
            }else{
                
                
          ProgressHUD.showError(error?.localizedDescription)
                
                }
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
