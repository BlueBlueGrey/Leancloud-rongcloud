//
//  NewViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/1/31.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit
import AVOSCloud
class NewViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var catalog = [[String]]()
    var tableView:UITableView!
    var query:AVQuery?
    var Array:[AVObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化列表数据
        
        query=AVQuery(className: "factory")
        Array=query?.findObjects() as! [AVObject]
    
       // query?.countObjects()
        print(Array![0]["string"]!)
        catalog.append(["iPhone 6的故障率达26% 稳超安卓", "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1517813396&di=3757c667b2c4b865cf64c7b9ba25c8e3&imgtype=jpg&er=1&src=http%3A%2F%2Fpic4.nipic.com%2F20091217%2F3885730_124701000519_2.jpg"])
        catalog.append(["不用导航 这款无人机能够“自制”地图飞行", "http://www.hangge.com/img2.png"])
        catalog.append(["无人汽车如何应对道德困境？谷歌表示不知道无人汽车如何应对道德困境？谷歌表示不知道无人汽车如何应对道德困境？谷歌表示不知道无人汽车如何应对道德困境？谷歌表示不知道无人汽车如何应对道德困境？谷歌表示不知道无人汽车如何应对道德困境？谷歌表示不知道无人汽车如何应对道德困境？谷歌表示不知道", "http://www.hangge.com/img33.png"])
        
        //创建表视图s
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //创建一个重用的单元格
        self.tableView!.register(UINib(nibName:"TableViewCell", bundle:nil),
                                 forCellReuseIdentifier:"myCell")
        
        //设置estimatedRowHeight属性默认值
        self.tableView.estimatedRowHeight = 44.0;
        //rowHeight属性设置为UITableViewAutomaticDimension
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        self.view.addSubview(self.tableView!)
    }
    
    //在本例中，只有一个分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     //   return self.catalog.count
        return (self.Array?.count)!
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            //同一形式的单元格重复使用
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell",
                                                     for: indexPath) as! TableViewCell
            //获取对应的条目内容
           // let entry = catalog[indexPath.row]
            //单元格标题和内容设置
         //   cell.titleLabel.text = entry[0]
        //    cell.loadImage(urlString: entry[1])
            
            cell.titleLabel.text=Array![indexPath.row]["string"] as! String
            cell.loadImage(data: (Array![indexPath.row]["image"] as? AVFile)?.getData())
            
            return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

