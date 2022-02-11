//
//  GrammarDetailViewController.swift
//  Swift_Study
//
//  Created by james on 2022/2/11.
//

import UIKit
import WebKit

class GrammarDetailViewController: UIViewController {

    @IBOutlet weak var mWebView: WKWebView!
    var urlS : String?
    var note : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightItem = UIBarButtonItem(title: "笔记", style: .plain, target: self, action: #selector(showNote))
        self.navigationItem.rightBarButtonItem = rightItem;
        
        /*
         可选项无法直接使用，需要展开之后才能使用，确保变量不为nil后才可以使用，这个在编辑阶段就确保了程序的稳定性
         使用可选项绑定来判断可选项是否包含值，如果包含就把值赋给一个临时常量或变量
         可选绑定可以与if或while语句使用来检查可选项内部的值，并赋值给一个临时常量或变量
         */
        if let urlm = urlS {
            let urlr = URL(string: urlm)
            if let url = urlr {
                let request = URLRequest(url: url)
                mWebView.load(request)
            }
        }
        
        /*
        在可选项后加问号（?）进行函数调用
        如果可选项不为nil，返回一个可选项结果，否则返回nil，函数返回得到的可选项直接使用也是不行的，也需要判断展开才可以
         如：
         urlS?.append("aa")
         */
        
        /*
         !会强制认为可选类型变量有值，当可选类型变量为nil时，程序就会crash
         */
//        let url = URL(string: urlS!)!
//        let request = URLRequest(url: url)
//        mWebView.load(request)
    }
    
    static func instantiate() ->GrammarDetailViewController?
    {
        let story = UIStoryboard(name: "GrammarDetailViewController", bundle: nil)
        guard let vc = story.instantiateViewController(identifier: "GrammarDetail") as? GrammarDetailViewController else {
            return nil
        }
        return vc
    }
    
    @objc func showNote() {
        let alertVC = UIAlertController(title: "笔记", message: note, preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "OK", style: .default) {
            action in
        }
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true, completion: nil)
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
