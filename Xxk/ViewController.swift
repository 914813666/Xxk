//
//  ViewController.swift
//  Xxk
//
//  Created by qzp on 15/2/26.
//  Copyright (c) 2015年 qzp. All rights reserved.
//

import UIKit

class ViewController: UIViewController,XxkViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //var xxkView = XxkView(frame: CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 70))
        var arr = ["选择1","选择2","选择3","选择4","选择5"]
        var arr2 = [["图片1":"ask_card_games@2x.png"],["图片2":"4s_btn_call_normal@2x.png"],["图片3":"ask_card_health@2x.png"]]
        var xxkView = XxkView(frame: CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 70), items: arr)
       
        xxkView.canShake = true
        self.view.addSubview(xxkView)
        
        var xxkView2 = XxkView(frame: CGRectMake(0, 200, CGRectGetWidth(self.view.bounds), 80), items: arr2)
        xxkView2.delegate = self
        xxkView2.canShake = false
        self.view.addSubview(xxkView2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func selectItemAtIndex(index: Int) {
        print(index)
    }

}

