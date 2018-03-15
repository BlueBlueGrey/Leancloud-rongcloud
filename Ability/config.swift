//
//  config.swift
//  XBook
//
//  Created by xlx on 15/12/5.
//  Copyright © 2015年 xlx. All rights reserved.
//

import Foundation


let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height


let MAIN_RED = UIColor(red: 235/255, green: 114/255, blue: 118/255, alpha: 1)

let MY_FONT = "Bauhaus ITC"


func RGB(r:Float,g:Float,b:Float)->UIColor{
    return UIColor(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: 1)

}
