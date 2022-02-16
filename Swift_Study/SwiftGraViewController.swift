//
//  SwiftGraViewController.swift
//  Swift_Study
//
//  Created by DT on 2022/2/15.
//

import UIKit

class SwiftGraViewController: UIViewController {

    var webURL : String?
    var remark : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        
        let rightItem = UIBarButtonItem(title: "资料", style: .plain, target: self, action: #selector(showNote))
        self.navigationItem.rightBarButtonItem = rightItem;

        //有条件的 for 循环
        for subView in view.subviews {
            if subView is UIButton {
                NSLog("is UIButton %@", subView)
            }
            else {
                NSLog("is not WKWebView")
            }
        }
        
        for case let wk as UIButton in view.subviews {
            NSLog("is UIButton %@", wk)
        }
        
        for wk in view.subviews where wk is UIButton {
            NSLog("is UIButton %@", wk)
        }
    }
    
    @objc func showNote() {
        
        guard let vc = GrammarDetailViewController.instantiate() else {
            return
        }
        
        vc.title = title
        vc.urlS = webURL
        vc.note = remark
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
