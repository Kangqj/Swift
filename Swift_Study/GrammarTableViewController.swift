//
//  GrammarTableViewController.swift
//  Swift_Study
//
//  Created by james on 2022/2/11.
//

import UIKit

class GrammarTableViewController: UITableViewController {

    var list = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        guard let filepath = Bundle.main.path(forResource: "grammar_list", ofType: "json") else {
            return
        }
        
        guard let contents = try? String(contentsOfFile: filepath) else {
            return
        }
        
        let dic = contents.toDictionary()
//                let dic = stringValueDic(contents)
        guard let arr = dic["data_list"] as? [[String:String]] else {
            return
        }
        list.append(contentsOf: arr)

        /*
        if let filepath = Bundle.main.path(forResource: "grammar_list", ofType: "json") {
            do {
                let contents = try String(contentsOfFile: filepath)
                let dic = contents.toDictionary()
//                let dic = stringValueDic(contents)
                guard let arr = dic["data_list"] as? [[String:String]] else {
                    return
                }
                list.append(contentsOf: arr)
            } catch {
                // 内容无法加载
            }
        } else {
            // 文件未找到
        }
        */
//        let dict1 = ["title":"可选项Optional", "detail":"?，!可选项,判断nil，展开，可选链", "url":"https://zhuanlan.zhihu.com/p/462800711"]
//        let dict2 = ["title":"测试可选项为nil的场景", "detail":"nil"]
//        let dict3 = ["title":"guard的用法", "detail":"guard语句，if判断", "url":"https://www.jianshu.com/p/67f3e3ee6a32"]
//        let dict4 = ["title":"as、as!、as? 三种操作符", "detail":"转型，类型判断，消除二义性", "url":"https://www.cnblogs.com/dukework/p/6553714.html"]
//
//        list.append(dict1)
//        list.append(dict2)
//        list.append(dict3)
//        list.append(dict4)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        cell?.accessoryType = .disclosureIndicator
        let dic = list[indexPath.row]
        cell?.textLabel?.text = dic["title"] as? String;
        cell?.detailTextLabel?.text = dic["detail"] as? String;
        
        return cell!;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dic = list[indexPath.row]
        let title = dic["title"] as? String
        
        if title?.range(of: "混编") != nil {
            let ocVC = OCViewController.init()
            ocVC.title = title
            self.navigationController?.pushViewController(ocVC, animated: true)
        }
        else if title?.range(of: "让你的 Swift 代码更 Swift") != nil {
            let sVC = SwiftGraViewController.init()
            sVC.title = title
            sVC.webURL = dic["url"] as? String
            sVC.remark = dic["note"] as? String
            self.navigationController?.pushViewController(sVC, animated: true)
        }
        else {
            guard let vc = GrammarDetailViewController.instantiate() else {
                return
            }
            vc.title = title
            vc.urlS = dic["url"] as? String
            vc.note = dic["note"] as? String
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    // MARK: 字符串转字典
    func stringValueDic(_ str: String) -> [String : Any]?{
        let data = str.data(using: String.Encoding.utf8)
        if let dict = try? JSONSerialization.jsonObject(with: data!,
                        options: .mutableContainers) as? [String : Any] {
            return dict
        }

        return nil
    }
    
    // MARK: 字典转字符串
    func dicValueString(_ dic:[String : Any]) -> String?{
        let data = try? JSONSerialization.data(withJSONObject: dic, options: [])
        let str = String(data: data!, encoding: String.Encoding.utf8)
        return str
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
