//
//  discusscell.swift
//  Ability
//
//  Created by BlueGrey on 2018/4/26.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit
import SnapKit
class discussCell: UITableViewCell {
    var avatarImage: UIImageView?
    var nameLabel:UILabel?
    var detailLabel:UILabel?
    var dateLabel:UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI() {
        //初始化头像
        avatarImage = UIImageView()
        //imgView?.image = UIImage.init(named: "img.jpg")
        // imgView?.layer.borderColor = UIColor.gray.cgColor
        // imgView?.layer.borderWidth = 1.0
        self.addSubview(avatarImage!)
        
        //顶部的label 初始化
        let label1 = UILabel()
        label1.font = .systemFont(ofSize: 15)
        label1.textColor = .red
        self.addSubview(label1)
        nameLabel = label1
        
        //底部的label 初始化
        let label2 = UILabel()
        label2.font = .systemFont(ofSize: 14)
        label2.textColor = .black
        label2.numberOfLines = 0
        self.addSubview(label2)
        detailLabel = label2;
        
        let label3 = UILabel()
        label3.font = .systemFont(ofSize: 14)
        label3.textColor = .black
        label3.numberOfLines = 0
        self.addSubview(label3)
        dateLabel = label3;
        
        //设置布局 SnapKit  --- >相当去Objective-C中的Masonry
        avatarImage?.snp.makeConstraints({ (make) in
            make.top.left.equalTo(10)
            make.width.height.equalTo(40)
        })
        self.avatarImage?.layer.cornerRadius = 20
        self.avatarImage?.layer.masksToBounds = true
        
        label1.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo((avatarImage?.snp.right)!).offset(10)
            make.right.equalTo(-10)
            make.height.equalTo(21)
        }
        
        label2.snp.makeConstraints { (make) in
            make.top.equalTo(label1.snp.bottom).offset(10)
            make.left.equalTo((avatarImage?.snp.right)!).offset(10)
            make.right.equalTo(-10)
            // make.bottom.equalTo((label3.snp.top)).offset(10)
        }
        
        label3.snp.makeConstraints { (make) in
            make.top.equalTo(label2.snp.bottom).offset(10)
            make.left.equalTo((avatarImage?.snp.right)!).offset(10)
            make.right.equalTo(-10)
            
            make.height.equalTo(10)
            make.bottom.equalTo(-5)
        }
        
    }
    
}
