//
//  TableViewCell.swift
//  Ability
//
//  Created by BlueGrey on 2018/1/31.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //标题文本标签
    @IBOutlet weak var titleLabel: UILabel!
    
    //内容图片
    @IBOutlet weak var contentImageView: UIImageView!
    
    //内容图片的宽高比约束
    internal var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                contentImageView.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                contentImageView.addConstraint(aspectConstraint!)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //清除内容图片的宽高比约束
        aspectConstraint = nil
    }
    
    
    //加载内容图片（并设置高度约束）
    func loadImage(data:Data?) {
        
        //从网络获取数据流,再通过数据流初始化图片
        if let imageData = data, let image = UIImage(data: imageData) {
            //计算原始图片的宽高比
            let aspect = image.size.width / image.size.height
            //设置imageView宽高比约束
            aspectConstraint = NSLayoutConstraint(item: contentImageView,
                                                  attribute: .width, relatedBy: .equal,
                                                  toItem: contentImageView, attribute: .height,
                                                  multiplier: aspect, constant: 0.0)
            //加载图片
            contentImageView.image = image
        }else{
            //去除imageView里的图片和宽高比约束
            aspectConstraint = nil
            contentImageView.image = nil
        }
    }
}

