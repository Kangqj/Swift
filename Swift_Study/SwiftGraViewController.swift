//
//  SwiftGraViewController.swift
//  Swift_Study
//
//  Created by DT on 2022/2/15.
//

/*
 // MARK: 标记
 // TODO:标识将来要完成的内容
 // FIXME:标识以后要修正或完善的内容
 // ???: 疑问的地方
 // !!!: 需要注意的地方
 */
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
        
        let button = UIButton(type: UIButton.ButtonType.system)
        button.frame = CGRect(x: 20, y: 100, width: 100, height: 40)
        button.setTitle("button", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = UIColor.green
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 10
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        
        //MARK:1.有条件的 for 循环
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
        
        //MARK:2.enumerated()
        for index in 0..<view.subviews.count {
            let subView = view.subviews[index]
            NSLog("subView %d_%@", index, subView)
        }
        
        for (index, subView) in view.subviews.enumerated() {
            NSLog("subView %d_%@", index, subView)
        }
        
        //MARK:3.first(where: )
        let modle1 = SwiftModel(title: "title1", content: "content1", id: "1", comments: ["0","1"])
        let modle2 = SwiftModel(title: "title2", content: "content2", id: "2", comments: ["0","2"])
        let modle3 = SwiftModel(title: "title3", content: "content3", id: "3", comments: ["0","3"])
        let models = [modle1, modle2, modle3]
        
        if let model = models.first(where: {$0.modelID == "3"}) {
            print("\(String(describing: model.title))-\(String(describing: model.content))-\(String(describing: model.modelID))-\(String(describing: model.comments))")
            
            guard let title = model.title else {
                return
            }
            NSLog("title:%@", title)
            
            guard let comments = model.comments else {
                return
            }
            NSLog("comments:%@", comments)
        }
        
        //MARK:4.contains(where: )
        if models.contains(where: {$0.modelID == "3"}) {
            NSLog("contains modelID == 3")
        }
        
        //MARK:5.forEach
        
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
    
    @objc func clickAction() {
        print("click")
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
