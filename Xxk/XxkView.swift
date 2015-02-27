//
//  XxkView.swift
//  Xxk
//
//  Created by qzp on 15/2/26.
//  Copyright (c) 2015年 qzp. All rights reserved.
//

import UIKit

protocol XxkViewDelegate {
    func selectItemAtIndex(index : Int)
}

class XxkView: UIView {
  
    let BOTTOM_HIGHT : CGFloat = 5.0
    var NUMBER = 4
    let DURATION = 0.2
    let bgColor : UIColor = UIColor.orangeColor()
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var bottomLabel : UILabel!
    var canShake : Bool? = false
    var itemsArr = NSMutableArray()
    var textColor = UIColor(red: 66.0/255.0, green: 156.0/255.0, blue: 250.0/255.0, alpha: 1)
    var textSelectedColor = UIColor.blueColor()
   
    var delegate : XxkViewDelegate!
    private var viewArr = NSMutableArray()
    
    
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        initializeUserInterface()
//    }
    
    init(frame: CGRect,items : NSArray) {
        super.init(frame: frame)
        itemsArr.addObjectsFromArray(items)
        NUMBER = itemsArr.count
        initializeUserInterface()
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initializeUserInterface() {
        
        self.backgroundColor = UIColor(red: 231.0/255.0, green: 236.0/255.0, blue: 238.0/255.0, alpha: 1)
        let W = CGRectGetWidth(self.bounds)
        let H = CGRectGetHeight(self.bounds)
        
        var cW = CGFloat(Int(W) / NUMBER)
        bottomLabel = UILabel(frame: CGRectMake(0, H - BOTTOM_HIGHT, cW, BOTTOM_HIGHT ))
        bottomLabel.backgroundColor = bgColor
        print(bgColor)
        self.addSubview(bottomLabel)
        
        var topLabelView = UILabel(frame: CGRectMake(0, 0, W, 1))
        topLabelView.backgroundColor = UIColor(red: 0.477, green: 0.5, blue: 0.492, alpha: 0.5)
        self.addSubview(topLabelView)
        
        var bottomLabelView = UILabel(frame: CGRectMake(0, H - 1, W, 1))
        bottomLabelView.backgroundColor = UIColor(red: 0.477, green: 0.5, blue: 0.492, alpha: 0.5)
        self.addSubview(bottomLabelView)
        
        for var i = 0; i < NUMBER; i++ {
            println(self.itemsArr[i])
            var view = myView(CGRectMake(cW * CGFloat(i), 0, cW, H - BOTTOM_HIGHT), item: self.itemsArr[i])
            viewArr.addObject(view)
            self.addSubview(view)
            
            
            var button = UIButton(frame: CGRectMake(cW * CGFloat(i) , 0, cW, H))
            button.backgroundColor = UIColor.clearColor()
            button.tag = 10 + i;
            button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
            self.addSubview(button)
            
           
        }
        
        

    }
    
    func myView(frame : CGRect,item : AnyObject) -> UIView {
        var myView = UIView(frame: frame)
      
        if item.isKindOfClass(NSString) {
            var label = UILabel(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
            label.text = item as NSString
            label.textColor = textColor
            label.textAlignment = .Center
            myView.addSubview(label)
            
        }
        else if item.isKindOfClass(NSDictionary) {
            var itemDic = item as NSDictionary
            var title = itemDic.allKeys[0] as NSString
            var imgName = itemDic.objectForKey(title) as NSString
            
            var  label = UILabel(frame: CGRectMake(0, frame.size.height * 0.7, frame.size.width, frame.size.height * 0.3))
            label.textAlignment = .Center
            label.text = title
            label.textColor = textColor
            myView.addSubview(label)
            
            var imgView = UIImageView(frame: CGRectMake(0, frame.size.height * 0.05, frame.size.width, frame.size.height * 0.6))
            imgView.image = UIImage(named: imgName)
           imgView.contentMode = UIViewContentMode.ScaleAspectFit
            myView.addSubview(imgView)
        }
        else if item.isKindOfClass(UIView) {
            myView.addSubview(item as UIView)
        }
        
        return myView
    }
    

    func buttonPressed(button : UIButton) {
        //避免重复点击
        button.userInteractionEnabled = false
        for var i = 10 ; i < 10 + NUMBER; i++ {
            if i != button.tag {
            var btn = self.viewWithTag(i) as UIButton
            btn.userInteractionEnabled = true
            }
        }
        
       
        //println(button.tag)
        var index = button.tag - 10
        let W = CGRectGetWidth(self.bounds)
        let H = CGRectGetHeight(self.bounds)
        
        if self.delegate != nil {
         self.delegate.selectItemAtIndex(index)
        }
        
        var cW = CGFloat(Int(W) / NUMBER)
        UIView.animateWithDuration(DURATION, animations: { () -> Void in
            var frame = self.bottomLabel.frame
            frame.origin.x = CGRectGetWidth(self.bounds) / CGFloat(self.NUMBER) * CGFloat(index)
            self.bottomLabel.frame = frame
        }) { (b) -> Void in
            if let r = self.canShake {
                if r == false {return}
            }
            //抖动
            var currentOrginX = self.bottomLabel.frame.origin.x
            var lCX = currentOrginX - 5
            var rCX = currentOrginX + 5
            UIView.animateWithDuration(0.05, animations: { () -> Void in
                var frame = self.bottomLabel.frame
                frame.origin.x = lCX;
                self.bottomLabel.frame = frame
                
            }, completion: { (b) -> Void in
                UIView.animateWithDuration(0.05, animations: { () -> Void in
                    var frame = self.bottomLabel.frame
                    frame.origin.x = rCX
                    self.bottomLabel.frame = frame
                }, completion: { (b) -> Void in
                    var frame = self.bottomLabel.frame
                    frame.origin.x = currentOrginX
                    self.bottomLabel.frame = frame
                })
            })
            
        }
    
    }
}
