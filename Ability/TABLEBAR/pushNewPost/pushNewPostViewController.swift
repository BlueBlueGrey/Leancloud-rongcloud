//
//  pushNewPostViewController.swift
//  Ability
//
//  Created by BlueGrey on 2018/3/18.
//  Copyright © 2018年 blueGrey. All rights reserved.
//

import UIKit
import AVOSCloud
//  发说说的页面

class pushNewPostViewController: CSViewController,UITextViewDelegate{

    var textView:CLTextView!
    var phontView:CLPhotosVIew!
    var imgArr:NSMutableArray!
    /*懒加载*/
    func ImgArr() -> NSMutableArray {
        if imgArr == nil {
            self.imgArr = NSMutableArray()
        }
        return imgArr
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
        
        // Do any additional setup after loading the view.
        
        let width = self.view.frame.size.width
        let height=self.view.frame.size.height
        // let textView = CLTextView(frame: CGRect(x: 0, y: 64, width: width, height: 300))
        textView = CLTextView(frame: CGRect(x: 0, y: 64, width: width, height: height-350))
        textView.backgroundColor = UIColor.white
        textView.delegate = self
        textView.placehoder = "请输入要评论的内容..."
        self.view.addSubview(textView)
        
        
        
        
       // let he=(imgArr.count/3)*125+50
        let photosView = CLPhotosVIew(frame: CGRect(x: 10,y: 100,width: Int(textView.frame.size.width-20),height: 250))
        self.phontView = photosView
        photosView.photoArray = [UIImage(named: "images_01")!]
        var weakSelf = pushNewPostViewController()
        weakSelf = self
        photosView.clickcloseImage = {(index:NSInteger) -> Void in
            weakSelf.ImgArr().removeObject(at: index)
        }
        
        /*点击添加图片View打开选择图片界面*/
        photosView.clickChooseView = {
            let imagePickerVc = TZImagePickerController(maxImagesCount: 9, delegate: nil)
            
            
            
            imagePickerVc?.didFinishPickingPhotosHandle = {(photos:[UIImage]!,assets:[Any]!,isSelectOriginalPhoto:Bool) -> Void in
                weakSelf.ImgArr().addObjects(from: photos)
                let arr = weakSelf.ImgArr().addingObjects(from: [UIImage(named:"images_01")!])
                weakSelf.phontView.photoArray = arr
            }
            
            
            
            weakSelf.present(imagePickerVc!, animated: true, completion: nil)
        }
        //textView.addSubview(photosView)
        self.view.addSubview(photosView)
    }

    func textViewDidChange(_ textView: UITextView) {
        let textH: CGFloat = textView.text!.boundingRect(with: CGSize(width: self.view.frame.size.width - 20, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], context: nil).size.height
        
        
        var frame = self.phontView.frame
        
        frame.origin.y = 100+textH
       
        let height=self.view.frame.size.height
        
        if(textH>=(height-250)){
            frame.origin.y = (height-250)
        }
        
        self.phontView.frame = frame
    }
        
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func sure(){
        
        print("sure")
        
        
      //  print(imgArr.count)
        
        let obj=AVObject(className: "newPost")
        obj.setObject(AVUser.current(), forKey: "user")
        obj.setObject(textView.text, forKey: "text")
        
        for i in 0..<imgArr.count{
            
            var file=AVFile(data:UIImagePNGRepresentation(imgArr[i] as! UIImage)!)
            
            file.saveInBackground({ (success, error) in
                if(success){
                    print("sdafsdf")
                    obj.addUniqueObjects(from: [file.objectId], forKey: "pictureArr")
                    obj.saveInBackground()
                }else{
                    print("sdafsdf     error")
                }
            }, progressBlock: { (num) in
                print(num)
            })
          
        }
        obj.saveInBackground()
        /*
        let obj=AVObject(className: "factory")
        if let temp=photoImageView.image
        {
            let data=UIImagePNGRepresentation((photoImageView.image)!)
            let file=AVFile(data: data!)
            obj.setObject(file, forKey: "image")
        }
        obj.setObject(text.text, forKey: "string")
        
        obj.saveInBackground()*/
        
    }

    override func close(){
        print("close")
        self.dismiss(animated: true, completion: nil)
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
