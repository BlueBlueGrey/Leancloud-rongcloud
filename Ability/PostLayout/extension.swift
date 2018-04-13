//
//  extension.swift
//  Demo_checkCell
//
//  Created by 李春波 on 16/8/10.
//  Copyright © 2016年 lcb. All rights reserved.
//

import UIKit

extension String{
    
    //MARK:获得string内容高度
    
    func stringHeightWith(_ fontSize:CGFloat,width:CGFloat)->CGFloat{
        
        let font = UIFont.systemFont(ofSize: fontSize)
        
        let size = CGSize(width: width,height: CGFloat.greatestFiniteMagnitude)
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineBreakMode = .byWordWrapping;
        
        let attributes = [NSAttributedStringKey.font:font, NSAttributedStringKey.paragraphStyle:paragraphStyle.copy()]
        
        let text = self as NSString
        
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        
        return rect.size.height
        
    }//funcstringHeightWith
    
}//extension end

func cellHeightByData(_ data:String)->CGFloat{
    
    let content = data
    let height=content.stringHeightWith(13,width: UIScreen.main.bounds.width - 55 - 10)
    return  height
    
}

func cellHeightByData1(_ imageNum:Int)->CGFloat{
    
    let lines:CGFloat = (CGFloat(imageNum))/3
    var picHeight:CGFloat = 0
    switch lines{
    case 0...1:
        picHeight = 80
        break
    case 1...2:
        picHeight = 155
        break
    case 2...3:
        picHeight = 230
        break
    default:
        picHeight = 0
    }
    return picHeight
    
}

func cellHeightByCommentNum(_ Comment:Int)->CGFloat{
    return CGFloat(Comment * 20)
}


