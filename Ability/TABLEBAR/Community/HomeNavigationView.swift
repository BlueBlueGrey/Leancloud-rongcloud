//
//  HomeNavigationView.swift
//  notebook
//
//  Created by Wuxingyan on 2018/4/2.
//  Copyright © 2018年 2015110345. All rights reserved.
//

import UIKit
import IBAnimatable

class HomeNavigationView: UIView,NibLoadable {

    
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var searchBtn: AnimatableButton!
    @IBOutlet weak var avatarBtn: UIButton!
    /// 搜索按钮点击
    var didSelectsearchBtn: (()->())?
    /// 头像按钮点击
    var didSelectavatarBtn: (()->())?
    /// 相机按钮点击
    var didSelectcameraBtn: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchBtn.backgroundColor = UIColor.white
        searchBtn.setTitleColor(UIColor.gray, for: .normal)
        searchBtn.setImage(UIImage(named: "search_small_16x16_"), for: [.normal, .highlighted])
        cameraBtn.setImage(UIImage(named:"home_camera_night"), for: .normal)
        cameraBtn.setImage(UIImage(named:"home_camera"), for: .highlighted)
        avatarBtn.setImage(UIImage(named:"home_no_login_head_night"), for: .normal)
        avatarBtn.setImage(UIImage(named:"home_no_login_head"), for: .highlighted)
        /*
         searchBtn.theme_backgroundColor = "colors.cellBackgroundColor"
         searchBtn.theme_setTitleColor("colors.grayColor150", forState: .normal)
         searchBtn.setImage(UIImage(named: "search_small_16x16_"), for: [.normal, .highlighted])
         cameraBtn.theme_setImage("images.home_camera", forState: .normal)
         cameraBtn.theme_setImage("images.home_camera", forState: .highlighted)
         avatarBtn.theme_setImage("images.home_no_login_head", forState: .normal)
         avatarBtn.theme_setImage("images.home_no_login_head", forState: .highlighted)
         // 首页顶部导航栏搜索推荐标题内容
         NetworkTool.loadHomeSearchSuggestInfo { (suggest) in
         self.searchBtn.setTitle(suggest, for: .normal)
         }
         */
    }
   
    
    /// 固有的大小
    override var intrinsicContentSize: CGSize {
        return UILayoutFittingExpandedSize
    }
    
    /// 重写 frame
    override var frame: CGRect {
        didSet {
            super.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        }
    }
    @IBAction func avatarBtnClicked(_ sender: UIButton) {
        didSelectavatarBtn?()
    }
    @IBAction func searchBtnClicked(_ sender: AnimatableButton) {
        didSelectsearchBtn?()
    }
    @IBAction func cameraBtnClicked(_ sender: UIButton) {
        didSelectcameraBtn?()
    }
    
    
}
