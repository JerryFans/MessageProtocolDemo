//
//  ViewController.swift
//  MessageProtocolDemo
//
//  Created by JerryFans on 2023/11/8.
//

import UIKit
import JFPopup

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        JFMessageCenter.shared.obs(with: self)
        
        let btn = UIButton(type: .custom)
        btn.addTarget(self, action: #selector(click), for: .touchUpInside)
        btn.setTitle("点我", for: .normal)
        btn.frame = CGRect(x: 150, y: 200, width: 100, height: 100)
        btn.backgroundColor = .red
        
        view.addSubview(btn)
       
        
    }
    
    @objc func click() {
        DispatchQueue.global().async {
            JFMessageCenter.shared.sendMessage(selector: #selector(JFMessageProtocol.messageProtocol_testMethod)) { proto in
                proto.messageProtocol_testMethod?()
            }
        }
    }
}



extension ViewController: JFMessageProtocol {
    func messageProtocol_testMethod() {
        JFPopup.toast {
            [
                .hit("我是通知转协议"),
                .position(.center)
            ]
        }
//        JFPopup.toast(hit: "我是通知转协议")
        print("我是通知转协议")
        print(Thread.current)
    }
}

