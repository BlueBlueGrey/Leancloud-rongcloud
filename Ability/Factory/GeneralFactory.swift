//
//  GeneralFactory.swift
//  Ability
//
//  Created by BlueGrey on 2018/3/18.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit

class GeneralFactory: NSObject {
    
    
    static func addTitleWithTile(target:CSViewController,title1:String="关闭",title2:String = "确认"){
        
     
        
        let btn1 = UIButton(frame: CGRect(x: 10, y: 20, width: 40, height: 20))
        btn1.setTitle(title1, for: .normal)
        btn1.contentHorizontalAlignment = .left
        btn1.setTitleColor(MAIN_RED, for: .normal)
        btn1.titleLabel?.font = UIFont(name: MY_FONT, size: 14)
        btn1.tag = 1234
        target.view.addSubview(btn1)
        
        
       
        
        let btn2 = UIButton(frame: CGRect(x: SCREEN_WIDTH-50, y: 20, width: 40, height: 20))
        btn2.setTitle(title2, for: .normal)
        btn2.contentHorizontalAlignment = .right
        btn2.setTitleColor(MAIN_RED, for: .normal)
        btn2.titleLabel?.font = UIFont(name: MY_FONT, size: 14)
        btn2.tag = 1235
        target.view.addSubview(btn2)
        
        
        btn1.addTarget(target, action: Selector("close"), for: .touchUpInside)
        btn2.addTarget(target, action: Selector("sure"), for: .touchUpInside)
        
        
    }
    
    
    
    
}
