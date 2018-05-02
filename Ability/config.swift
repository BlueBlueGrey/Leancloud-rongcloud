//
//  config.swift
//  XBook
//
//  Created by xlx on 15/12/5.
//  Copyright © 2015年 xlx. All rights reserved.
//

import Foundation

import AVOSCloud
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height


let MAIN_RED = UIColor(red: 235/255, green: 114/255, blue: 118/255, alpha: 1)

let MY_FONT = "Bauhaus ITC"


func RGB(r:Float,g:Float,b:Float)->UIColor{
    return UIColor(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: 1)

}

func getUserInfo(withUserId userId: String!, completion: ((RCUserInfo?) -> Void)!) {
    let  query=AVQuery(className: "Custom_User")
    query.whereKey("id", matchesRegex: userId)
    let temp=query.findObjects() as! [AVObject]
    var url=""
    if(temp.count>0)
    {
        let U=temp[0]["portrait"] as! AVFile
        url=U.url!
        //  let U=temp!["image"] as! AVFile
        //  photoImageView.image=UIImage(data: U.getData()!)
        // text.text=temp?["string"] as! String
    }
    print(url)
    return completion(RCUserInfo(userId: userId, name: userId, portrait: url))
}
