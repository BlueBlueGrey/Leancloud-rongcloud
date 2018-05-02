//
//  AppDelegate.swift
//  Ability
//
//  Created by BlueGrey on 2017/12/23.
//  Copyright © 2017年 blueGrey. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import LeanCloud
import AVOSCloud

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
 
    var window: UIWindow?
    var token=""
   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      
        
        AVOSCloud.setApplicationId("LceoyBY6iLUSsnF9YuYxePrE-gzGzoHsz", clientKey: "L3yIaz320K2pVuLzRCDh3TlS")
        LeanCloud.initialize(applicationID: "LceoyBY6iLUSsnF9YuYxePrE-gzGzoHsz", applicationKey: "L3yIaz320K2pVuLzRCDh3TlS")

//        let post = LCObject(className: "TestObject")
//        
//        post.set("words", value: "Hello World!")
//        
//        post.save()
        //requestToken1(userID: "01")
        //RCIM.shared().initWithAppKey("3argexb630cme")
        
      
        
        
        self.window = UIWindow(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        
        let tabbatController = UITabBarController()
        
        let communityViewController=UINavigationController(rootViewController: CommunityViewController())
        
        let messageViewController=UINavigationController(rootViewController: secViewController())
        
        let mineViewController=UINavigationController(rootViewController: MineViewController())
        
       //let home=UINavigationController(rootViewController: HomepageViewController())
        //tabbatController.viewControllers=[communityViewController,messageViewController,mineViewCo//ntroller,home]
//        let home=UINavigationController(rootViewController: LocationViewController())
//        tabbatController.viewControllers=[communityViewController,messageViewController,mineViewController,home]
        
        
        let home=UINavigationController(rootViewController: LocalTwpViewController())
        tabbatController.viewControllers=[communityViewController,messageViewController,mineViewController,home]
        
        let tabitem1 = UITabBarItem(title: "广场", image: UIImage(named: "bio"), selectedImage: UIImage(named: "bio_red"))
        let tabitem2 = UITabBarItem(title: "消息", image: UIImage(named: "chat 3"), selectedImage: UIImage(named: "chat 3_red"))
        let tabitem3 = UITabBarItem(title: "我的", image: UIImage(named: "pencil"), selectedImage: UIImage(named: "pencil_red"))
       
        let tabitem4=UITabBarItem(title: "推荐", image: UIImage(named: "jian"), selectedImage: UIImage(named: "jian"))
        communityViewController.tabBarItem=tabitem1
        messageViewController.tabBarItem=tabitem2
        mineViewController.tabBarItem=tabitem3
        
        home.tabBarItem=tabitem4
       // communityViewController.tabBarController?.tabBar.tintColor=MAIN_RED
        
       // self.window?.rootViewController = tabbatController
        
        
        let rootViewController = MainTabBarController()
        rootViewController.delegate = self
        window?.rootViewController = rootViewController
        rootViewController.tabBarController?.tabBar.tintColor=MAIN_RED
        rootViewController.view.tintColor=MAIN_RED
        self.window?.makeKeyAndVisible()
 
 
        
        return true
    }
    
    func requestToken1(userID:String) -> Void {
        let dicUser = ["userId":userID,
                       "name":userID,
                       "portraitUrl":"http://img3.duitang.com/uploads/item/201508/30/20150830083023_N3rTL.png"
        ] //请求token的用户信息
        let urlStr = "https://api.cn.ronghub.com/user/getToken.json" //网址接口
        let appKey = "3argexb630cme"
        let appSecret = "11pfdtC8NnB"
        let nonce = "\(arc4random())"   //生成随机数
        let timestamp = "\(NSDate().timeIntervalSince1970)"//时间戳
        var sha1Value = appSecret + nonce + timestamp
        sha1Value = sha1Value.sha1()//数据签名,sha1是一个加密的方法
        let headers = [ //照着文档要求写的Http 请求的 4个head
            "App-key":appKey
            ,"Nonce":nonce
            ,"Timestamp":timestamp
            ,"Signature":sha1Value
        ]
        Alamofire.request(urlStr, method: .post, parameters: dicUser , encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            print(response)
            if let dic = response.result.value  as? NSDictionary{
                let code = dic.value(forKey: "code") as! NSNumber
                if code.stringValue == "200" {
                    print(dic.value(forKey: "token"))
                    self.token=dic.value(forKey: "token") as! String
                    
                    print("sadfasf  "+self.token)
                    self.ConnectOne()
                }
            }
        }
    }

    func ConnectOne()->Void{
        RCIM.shared().initWithAppKey("3argexb630cme")
        
        
        RCIM.shared().connect(withToken: token,success: { (userId) -> Void in
            print("登陆成功。当前登录的用户ID：\(userId)")
        }, error: { (status) -> Void in
            print("登陆的错误码为:\(status.rawValue)")
        }, tokenIncorrect: {
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            print("token错误")
        })
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Ability")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
//        if #available(iOS 10.0, *) {
//            let context = persistentContainer.viewContext
//        } else {
//            // Fallback on earlier versions
//        }
//        if connect.hasChanges {
//            do {
//                try connect.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
    }

}

extension AppDelegate: UITabBarControllerDelegate{
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("\(viewController)")
    }
}

