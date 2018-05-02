//
//  recommendViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/5/2.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SGPagingView

class recommendViewController:UIViewController {
    

    
    var titles = ["关注","附近"]
    /// 标题和内容
    private var pageTitleView: SGPageTitleView?
    private var pageContentView: SGPageContentView?
    /// 屏幕的宽度
    let screenWidth = UIScreen.main.bounds.width
    /// 屏幕的高度
    let screenHeight = UIScreen.main.bounds.height
    let newsTitleHeight: CGFloat = 50
    let kMyHeaderViewHeight: CGFloat = 280
    let kUserDetailHeaderBGImageViewHeight: CGFloat = 146
    
    
    /// 自定义导航栏
    //  private lazy var navigationBar = HomeNavigationView.loadViewFromNib()
    
    private lazy var disposeBag = DisposeBag()
    /// 添加频道按钮
    private lazy var addChannelButton: UIButton = {
        let addChannelButton = UIButton(frame: CGRect(x: screenWidth - newsTitleHeight, y: 0, width: newsTitleHeight, height: newsTitleHeight))
        //  addChannelButton.theme_setImage("images.add_channel_titlbar_thin_new_16x16_", forState: .normal)
        let separatorView = UIView(frame: CGRect(x: 0, y: newsTitleHeight - 1, width: newsTitleHeight, height: 1))
        //     separatorView.theme_backgroundColor = "colors.separatorViewColor"
        
        addChannelButton.addSubview(separatorView)
        return addChannelButton
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setupUI()
        clickAction()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension recommendViewController {
    func setupChildViewControllers() {
        for i in 0..<2 {
            let vc = onerecommendViewController()
            
            vc.kind=i
            
            addChildViewController(vc)
        }
    }
}

extension recommendViewController {
    
    /// 设置 UI
    private func setupUI() {
        //view.theme_backgroundColor = "colors.cellBackgroundColor"
        // 添加频道
        // 设置自定义导航栏
        //   navigationItem.titleView = navigationBar
        view.addSubview(addChannelButton)
        let configuration = SGPageTitleViewConfigure()
        configuration.titleColor = .black
        configuration.titleSelectedColor = .gray
        configuration.indicatorColor = .clear
        configuration.indicatorStyle = SGIndicatorStyleCover;
        configuration.indicatorAdditionalWidth = 25 // 指示器额外增加的长度（标题文字宽度之外的宽度）
        configuration.indicatorBorderWidth = 1 // 指示器边框宽度
        configuration.indicatorBorderColor = .lightGray // 指示器圆角颜色
        configuration.indicatorCornerRadius = 20// 指示器圆角大小
        configuration.indicatorHeight = 25
        // 标题名称的数组
        self.pageTitleView = SGPageTitleView(frame: CGRect(x:20, y: 50, width: screenWidth - newsTitleHeight, height: newsTitleHeight), delegate: self, titleNames: titles, configure: configuration)
        self.pageTitleView!.backgroundColor = .clear
        
        self.view.addSubview(pageTitleView!)
        
        
        
        setupChildViewControllers()
        
        // 内容视图
        self.pageContentView = SGPageContentView(frame: CGRect(x: 0, y: 100, width: screenWidth, height: self.view.height - newsTitleHeight), parentVC: self, childVCs: self.childViewControllers)
        self.pageContentView!.delegatePageContentView = self
        self.view.addSubview(self.pageContentView!)
        
        let labeltemp=UILabel(frame: CGRect(x:20, y: 50, width: screenWidth - newsTitleHeight, height: newsTitleHeight))
        labeltemp.backgroundColor = .blue
        //  self.view.addSubview(labeltemp)
    }
    
    
    
    /// 点击事件
    private func clickAction() {
        
        
    }
    
    @objc func returnClick(){
        //self.navigationItem.leftBarButtonItems?.removeAll()
        let vc = HomepageViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - SGPageTitleViewDelegate
extension recommendViewController: SGPageTitleViewDelegate, SGPageContentViewDelegate {
    /// 联动 pageContent 的方法
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        self.pageContentView!.setPageContentViewCurrentIndex(selectedIndex)
    }
    
    /// 联动 SGPageTitleView 的方法
    func pageContentView(_ pageContentView: SGPageContentView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.pageTitleView!.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}
