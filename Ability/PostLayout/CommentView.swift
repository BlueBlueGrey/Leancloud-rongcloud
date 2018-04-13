//
//  CommentView.swift
//  Demo_checkCell
//
//  Created by 李春波 on 16/8/22.
//  Copyright © 2016年 lcb. All rights reserved.
//

import UIKit

class CommentView: UIView {
    var nameLabel = UILabel()
    var commentLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        self.nameLabel.frame = CGRect(x: 0,y: 2,width: 60,height: 20)
        self.nameLabel.textAlignment = .left
        self.nameLabel.font = UIFont.systemFont(ofSize: 15)
        self.commentLabel.frame = CGRect(x: 65,y: 2,width: 200,height: 20)
        self.commentLabel.font = UIFont.systemFont(ofSize: 15)
        self.nameLabel.textColor = UIColor.blue
        self.commentLabel.textAlignment = .left
        self.addSubview(nameLabel)
        self.addSubview(commentLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
