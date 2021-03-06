//
//  MainTabBarController.swift
//  BSBDJ
//
//  Created by apple on 2017/11/6.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 通过 appearance统一设置UITabBarItem的文字属性，属性后面带UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
        let tabBar = UITabBarItem.appearance()
        let attrs_Normal = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.gray]
        let attrs_Select = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.darkGray]
        tabBar.setTitleTextAttributes(attrs_Normal, for: .normal)
        tabBar.setTitleTextAttributes(attrs_Select, for: .selected)
        setupUI()

    }
}



extension MainTabBarController {
    fileprivate func setupUI() {

        setValue(MainTabBar(), forKey: "tabBar")

        let vcArray:[UIViewController] = [HomepageViewController(), secViewController(), MineViewController(),recommendViewController() ]
        let titleArray = [("广场", "bio"), ("消息", "chat 3"), ("我的", "pencil"), ("推荐", "jian")]
        for (index, vc) in vcArray.enumerated() {
            vc.tabBarItem.title = titleArray[index].0
            vc.tabBarItem.image = UIImage(named: "\(titleArray[index].1)")
            //vc.tabBarItem.selectedImage = UIImage(named: "tabBar_\(titleArray[index].1)_click_icon")
            let nav = MainNavigationController(rootViewController: vc)
            addChildViewController(nav)
        }
    }

}
