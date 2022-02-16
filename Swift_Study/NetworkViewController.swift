//
//  NetworkViewController.swift
//  Swift_Study
//
//  Created by DT on 2022/2/16.
//

import UIKit
import Alamofire

class NetworkViewController: UIViewController {
    
    var webURL : String?
    var remark : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let rightItem = UIBarButtonItem(title: "资料", style: .plain, target: self, action: #selector(showInfo))
        self.navigationItem.rightBarButtonItem = rightItem
        
        let button = UIButton(type: UIButton.ButtonType.system)
        button.frame = CGRect(x: 30, y: 120, width: 100, height: 40)
        button.setTitle("Request", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.backgroundColor = UIColor .blue
        button.layer.cornerRadius = 10
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(networkRequest), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func showInfo() {
        guard let vc = GrammarDetailViewController.instantiate() else {
            return
        }
        
        vc.title = title
        vc.urlS = webURL
        vc.note = remark
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func networkRequest() {
        Alamofire.request("https://www.baidu.com", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.error == nil {
                NSLog("请求成功\(String(describing: response.result.value))")
            }
            else {
                NSLog("请求失败\(String(describing: response.error))")
            }
        }
    }
}
