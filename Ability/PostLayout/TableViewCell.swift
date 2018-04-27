//
//  TableViewCell.swift
//  Demo_checkCell
//
//  Created by 李春波 on 16/8/10.
//  Copyright © 2016年 lcb. All rights reserved.
//

import UIKit
import  AVOSCloud
typealias heightChange = (_ cellFlag:Bool) -> Void
typealias likeChange = (_ cellFlag:Bool) -> Void
typealias commentChange = () -> Void
protocol clickImageDelegate {
    func showOpV()-> Void
}
class defalutTableViewCell: UITableViewCell {
    var clickdelegate:clickImageDelegate?
    var flag = true
    var show = false
    var likeflag = true
    var nameLabel = UILabel()
    var avatorImage:UIImageView!
    let pbVC = PhotoBrowser()
    var contentLabel = UILabel()
    let displayView = DisplayView()
    var remoteThumbImage = [IndexPath:[String]]()
    var remoteImage :[String] = []
    var timeLabel = UILabel()
    var btn = UIButton()
    let menuview = Menu()
    var zhankaiBtn:UIButton!
    var collectionViewFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var cellflag1 = false
    var heightZhi:heightChange?
    var likechange:likeChange?
    var commentchange:commentChange?
    var likeView = Comment_Like_View()
    
    var likeLabelArray:[String] = []
    var commentView = pingLunFun()
    var commentNameLabel = UILabel()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if avatorImage == nil{
            avatorImage = UIImageView(frame: CGRect(x: 8, y: 10, width: 40, height: 40))
            self.contentView.addSubview(avatorImage)
        }
        nameLabel.frame = CGRect(x: 55, y: 8, width: 60, height: 17)
        nameLabel.textColor = UIColor(red: 74/255, green: 83/255, blue: 130/255, alpha: 1)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.contentView.addSubview(nameLabel)
        contentLabel.numberOfLines = 0
        contentLabel.textColor = UIColor.black
        contentLabel.font = UIFont.systemFont(ofSize: 13)
        contentLabel.textAlignment = .justified
        contentLabel.sizeToFit()
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.gray
        timeLabel.text = "两小时前"
        btn.setImage(UIImage(named:"menu"), for: UIControlState())
        btn.addTarget(self, action: #selector(defalutTableViewCell.click), for: .touchUpInside)
        
        
        
        
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(displayView)
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(btn)
        
    }
    
    @objc func click(){
        
        btn.setImage(UIImage(named:"good"), for: UIControlState())
        //menuview.clickMenu()
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(_ name:String,imagePic:String,content:String,imgData:[String],indexRow:IndexPath,selectItem:Bool){
        var h = cellHeightByData(content)
        let h1 = cellHeightByData1(imgData.count)
        var h2:CGFloat = 0.0
        nameLabel.text = name
        
        let  query=AVQuery(className: "Custom_User")
        query.whereKey("id", matchesRegex: name)
        let temp=query.findObjects() as! [AVObject]
        if(temp.count>0)
        {
            let U=temp[0]["portrait"] as! AVFile
            self.avatorImage.image=UIImage(data: U.getData()!)
            //  let U=temp!["image"] as! AVFile
            //  photoImageView.image=UIImage(data: U.getData()!)
            // text.text=temp?["string"] as! String
        }
        
        
        
        
      //  avatorImage.image = UIImage(named: imagePic)
        if h<13*5{
            contentLabel.frame = CGRect(x: 55, y: 25, width: UIScreen.main.bounds.width - 55 - 10, height: h)
            collectionViewFrame = CGRect(x: 50, y: h+10+15, width: 230, height: h1)
            h2 = h1 + h + 27
        }
        else{
            if !selectItem{
                cellflag1 = !selectItem
                h = 13*5
                contentLabel.frame = CGRect(x: 55, y: 25, width: UIScreen.main.bounds.width - 55 - 10, height: h)
                zhankaiBtn = UIButton(frame: CGRect(x: 55,y: h+10+17,width: 60,height: 15))
                zhankaiBtn.setTitle("展开全文", for: UIControlState())
                zhankaiBtn.addTarget(self, action: #selector(clickDown), for: .touchUpInside)
                zhankaiBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                zhankaiBtn.setTitleColor(UIColor(red: 74/255, green: 83/255, blue: 130/255, alpha: 1), for: UIControlState())
                self.contentView.addSubview(zhankaiBtn)
                collectionViewFrame = CGRect(x: 50, y: h+10+15+15, width: 230, height: h1)
                h2 = h1 + h + 27 + 12
            }
            if selectItem{
                cellflag1 = !selectItem
                contentLabel.frame = CGRect(x: 55, y: 25, width: UIScreen.main.bounds.width - 55 - 10, height: h)
                zhankaiBtn = UIButton(frame: CGRect(x: 55,y: h+10+17,width: 60,height: 15))
                zhankaiBtn.setTitle("点击收起", for: UIControlState())
                zhankaiBtn.addTarget(self, action: #selector(defalutTableViewCell.clickDown(_:)), for: .touchUpInside)
                zhankaiBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                zhankaiBtn.setTitleColor(UIColor(red: 74/255, green: 83/255, blue: 130/255, alpha: 1), for: UIControlState())
                self.contentView.addSubview(zhankaiBtn)
                collectionViewFrame = CGRect(x: 50, y: h+10+15+15, width: 230, height: h1)
                h2 = h1 + h + 27 + 12
            }
        }
        contentLabel.text = content
        displayView.frame = collectionViewFrame
        timeLabel.frame = CGRect(x: 55, y: h2, width: 100, height: 15)
        btn.frame = CGRect(x: 0, y: h2, width: 15, height: 12)
        btn.frame.origin.x = UIScreen.main.bounds.width - 10 - 15
        self.menuview.frame = CGRect(x: 0, y: h2 - 8, width: 14.5, height: 0)
        self.menuview.frame.origin.x = UIScreen.main.bounds.width - 10 - 15
        self.menuview.likeBtn.setImage(UIImage(named: "btn_star_evaluation_press"), for: UIControlState())
        
        
        self.menuview.likeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.menuview.commentBtn.setImage(UIImage(named: "c"), for: UIControlState())
        self.menuview.commentBtn.setTitle("评论", for: UIControlState())
        self.menuview.commentBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.menuview.likeBtn.tag = indexRow.row
        self.menuview.likeBtn.addTarget(self, action: #selector(defalutTableViewCell.LikeBtn(_:)), for: .touchUpInside)
        self.menuview.commentBtn.addTarget(self, action: #selector(defalutTableViewCell.CommentBtn(_:)), for: .touchUpInside)
        for i in 0..<imgData.count{
            let imgUrl = imgData[i]
            self.remoteImage.append(imgUrl)
        }
        self.remoteThumbImage[indexRow] = self.remoteImage
        displayView.imgsPrepare(imgs: remoteThumbImage[indexRow]!, isLocal: false)
        pbVC.showType = .modal
        pbVC.photoType = PhotoBrowser.PhotoType.host
        pbVC.hideMsgForZoomAndDismissWithSingleTap = true
        var models: [PhotoBrowser.PhotoModel] = []
        for i in 0 ..< self.remoteThumbImage[indexRow]!.count{
            let model = PhotoBrowser.PhotoModel(hostHDImgURL:self.remoteThumbImage[indexRow]![i], hostThumbnailImg: (displayView.subviews[i] as! UIImageView).image, titleStr: "", descStr: "", sourceView: displayView.subviews[i])
            models.append(model)
        }
        pbVC.photoModels = models
        
        
        self.contentView.addSubview(self.menuview)
    }
    
    @objc func clickDown(_ sender:UIButton){
        
        if flag{
            flag = false
            if self.heightZhi != nil{
                self.heightZhi!(self.cellflag1)
            }
            
        }
        else{
            flag = true
            if self.heightZhi != nil{
                self.heightZhi!(self.cellflag1)
            }
        }
        
    }
    
    @objc func CommentBtn(_ sender:UIButton){
        if self.commentchange != nil{
            self.commentchange!()
        }
        menuview.menuHide()
    }
    
    @objc func LikeBtn(_ sender:UIButton){
        
        
        if !likeflag{
            
            //服务器接口上传数据
            goodComm[sender.tag]["good"]!.remove(at: goodComm[sender.tag]["good"]!.index(of: "胖大海")!)
            if self.likechange != nil{
                self.likechange!(self.likeflag)
            }
            menuview.menuHide()
        }
        else{
            goodComm[sender.tag]["good"]!.append("胖大海")
            if self.likechange != nil{
                self.likechange!(self.likeflag)
            }
            menuview.menuHide()
        }
        
    }
}



