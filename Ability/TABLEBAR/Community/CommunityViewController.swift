//
//  CommunityViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/3/14.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit
import AVOSCloud
class CommunityViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    
    var tableView:UITableView?
    var navigationView:UIView!
    
    var swipIndexPath:NSIndexPath?
    
    let imagePicView = UIView()
    let imagePic=UIImageView()
    let nameLable = UILabel()
    let avatorImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // 单前 用户登录
         AVUser.logOut()
        
      
        
        
        if AVUser.current() == nil {
            print("nil    ----------------")
            print("nil    ===============----------------")
            print("nil    ===============----------------")
            print("nil    ===============----------------")
            print("nil    ===============----------------")
            // story
            let story = UIStoryboard(name: "LoginStoryboard", bundle: nil)
            let loginVC = story.instantiateViewController(withIdentifier: "NavigationLogin")
            self.present(loginVC, animated: true, completion: { () -> Void in
                
            })}
        
        
        
        self.setNavigationBar()
        
        self.tableView=UITableView(frame: self.view.frame)
        
        self.tableView?.delegate=self
        self.tableView?.dataSource=self
        self.tableView?.tableHeaderView=headerView()
        self.view.addSubview(self.tableView!)
        
        
        
        // Do any additional setup after loading the view.
    }

    
    func headerView() ->UIView{
        
        CGRect(x: 0, y: 200, width: self.view.bounds.width, height:26)
        
        
        
        imagePicView.frame =  CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 225)
        imagePic.frame =  CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200)
        imagePic.image = UIImage(named: "mp")
        imagePicView.addSubview(imagePic)
        imagePic.clipsToBounds = true
        self.nameLable.frame =  CGRect(x: 0, y: 170, width: 60, height: 18)
        self.nameLable.frame.origin.x = self.view.bounds.width - 140
        self.nameLable.text = "胖大海"
        self.nameLable.font = UIFont.systemFont(ofSize: 16)
        self.nameLable.textColor = UIColor.white
        self.avatorImage.frame = CGRect(x: 0, y: 150, width: 70, height:70)
        self.avatorImage.frame.origin.x = self.view.bounds.width - 80
        self.avatorImage.image = UIImage(named: "gou")
        self.avatorImage.layer.borderWidth = 2
        self.avatorImage.layer.borderColor = UIColor.white.cgColor
        let view:UIView = UIView(frame: CGRect(x: 0, y: 200, width: self.view.bounds.width, height:26))
        view.backgroundColor = UIColor.white
        imagePicView.addSubview(nameLable)
        imagePicView.addSubview(view)
        imagePicView.addSubview(avatorImage)
        return imagePicView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell=UITableViewCell()
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setNavigationBar(){
        
       
        navigationView = UIView(frame:  CGRect(x: 0, y: -20, width: SCREEN_WIDTH, height: 65))
        navigationView.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.addSubview(navigationView)
        
        CGRect(x: 20, y: 20, width: SCREEN_WIDTH, height: 45)
        let addBookBtn = UIButton(frame: CGRect(x: 20, y: 20, width: SCREEN_WIDTH, height: 45))
        addBookBtn.setImage(UIImage(named:"plus circle"), for: .normal)
     
        addBookBtn.setTitleColor(UIColor.black, for: .normal)
        addBookBtn.setTitle("    新建书评", for: .normal)
        addBookBtn.titleLabel?.font = UIFont(name: MY_FONT, size: 15)
        addBookBtn.contentHorizontalAlignment = .left        //按钮文字现实居左
        
        addBookBtn.addTarget(self, action:#selector(pushNewPost), for: .touchUpInside)
        
        
        navigationView.addSubview(addBookBtn)
        
    }
   
    @objc func pushNewPost(){
        print("pushNewPost")
        
        let vc=pushNewPostViewController()
        GeneralFactory.addTitleWithTile(target: vc)
        self.present(vc, animated: true, completion: nil)
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
