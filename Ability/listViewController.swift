//
//  listViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/1/27.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit

class listViewController: RCConversationListViewController {

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setDisplayConversationTypes([RCConversationType.ConversationType_PRIVATE.rawValue, RCConversationType.ConversationType_DISCUSSION.rawValue, RCConversationType.ConversationType_CHATROOM.rawValue, RCConversationType.ConversationType_GROUP.rawValue, RCConversationType.ConversationType_APPSERVICE.rawValue, RCConversationType.ConversationType_SYSTEM.rawValue])
        //设置需要将哪些类型的会话在会话列表中聚合显示
        self.setCollectionConversationType([RCConversationType.ConversationType_DISCUSSION.rawValue, RCConversationType.ConversationType_GROUP.rawValue,RCConversationType.ConversationType_PRIVATE.rawValue])
        
        
        
    }
    
    
    
    
    @IBAction func newConversation(sender: UIBarButtonItem) {
        //打开会话界面
        let optionAlert = UIAlertController(title: "选择",message: "会话类型",preferredStyle: .actionSheet)
        
        let DiscussionAction = UIAlertAction(title: "讨论组",style: .default,handler: { (alert:UIAlertAction!) -> Void in
            print("打印了讨论组")
            RCIMClient.shared().createDiscussion(
                "第一个讨论组",
                userIdList: ["gavin","galler","vivian"],
                success: { (discussion) -> Void in
                    print("创建讨论组:\(discussion)")
                    //把人加入讨论组
                    RCIMClient.shared().addMember(
                        toDiscussion: "discussion1",
                        userIdList: ["gavin","galler","vivian"],
                        success: { (discussion) -> Void in
                            print("开始创建讨论组聊天页面")
                            let discussChat = RCConversationViewController()
                            discussChat.conversationType = RCConversationType.ConversationType_DISCUSSION
                            discussChat.targetId = "discussion1"
                            discussChat.title = "第一个讨论组"
                            self.navigationController?.pushViewController(discussChat, animated: true)
                            self.tabBarController?.tabBar.isHidden = true
                    },
                        error: { (status) -> Void in
                            print("加人失败\(status)")
                    })
                    
            },
                error: { (status) -> Void in
                    print("创建失败：\(status)")
            })
            
        })
        let GroupAction = UIAlertAction(title: "群组",style: .default,handler: { (alert:UIAlertAction!) -> Void in
            print("点击了群组")
            let groupChat = RCConversationViewController(conversationType: RCConversationType.ConversationType_GROUP, targetId: "group1")
            groupChat?.title = "一起来嗨皮啊"
            self.navigationController?.pushViewController(groupChat!, animated: true)
            self.tabBarController?.tabBar.isHidden = true
            
        })
        let ChatroomAction = UIAlertAction(title: "聊天室",style: .default,handler: { (alert:UIAlertAction!) -> Void in
            print("点击了聊天室")
            //新建一个聊天会话View Controller对象
            let chat = RCConversationViewController()
            //设置会话的类型为聊天室
            chat.conversationType = RCConversationType.ConversationType_CHATROOM
            //设置会话的目标会话ID
            chat.targetId = "chatroom1"
            //设置聊天会话界面要显示的标题
            chat.title = "这是一个聊天室啊"
            //设置加入聊天室时需要获取的历史消息数量，最大值为50
            chat.defaultHistoryMessageCountOfChatRoom = 20
            //显示聊天会话界面
            self.navigationController?.pushViewController(chat, animated: true)
            self.tabBarController?.tabBar.isHidden = true
            
        })
        
        
        
        
        
        
        let PrivateChat = UIAlertAction(title:"asDdf",style: .default,handler: { (alert:UIAlertAction!) -> Void in
            print("点击了聊hgjhgj")
            //新建一个聊天会话View Controller对象
            let chat = RCConversationViewController()
            //设置会话的类型为聊天室
            chat.conversationType = RCConversationType.ConversationType_PRIVATE
            //设置会话的目标会话ID
            chat.targetId = "bbb"
            //设置聊天会话界面要显示的标题
            chat.title = "这是一个bbb"
            //设置加入聊天室时需要获取的历史消息数量，最大值为50
            chat.defaultHistoryMessageCountOfChatRoom = 20
            //显示聊天会话界面
            self.navigationController?.pushViewController(chat, animated: true)
            self.tabBarController?.tabBar.isHidden = true
            
        })
        
        
        let CancelAction = UIAlertAction(title: "取消",style: .cancel,handler: { (alert:UIAlertAction!) -> Void in
            print("点击了取消")
            
        })
        optionAlert.addAction(PrivateChat)
        optionAlert.addAction(DiscussionAction)
        optionAlert.addAction(GroupAction)
        optionAlert.addAction(ChatroomAction)
        optionAlert.addAction(CancelAction)
        
        self.present(optionAlert, animated: true, completion: nil)
    }
    
    override func onSelectedTableRow(_ conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, at indexPath: IndexPath!) {
        //打开会话界面
        let chat = RCConversationViewController(conversationType: model.conversationType, targetId: model.targetId)
        chat?.title = model.conversationTitle
        self.navigationController?.pushViewController(chat!, animated: true)
        self.tabBarController?.tabBar.isHidden=true
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
