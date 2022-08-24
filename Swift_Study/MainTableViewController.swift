//
//  MainTableViewController.swift
//  Swift_Study
//
//  Created by james on 2022/2/10.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var list = [[String:String]]();
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let dict1 = ["title":"UI学习", "detial":"学习各种控件的使用"];
        let dict2 = ["title":"Swift语法学习", "detial":"学习Swift语法的使用"];
        let dict3 = ["title":"iCloud学习", "detial":"学习iCloud的使用"];
        list.append(dict1)
        list.append(dict2)
        list.append(dict3)
    }
    
//    var list = ["UI学习","语法学习","item3","item4","item5","item6"]
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Identifier 是用来作为可重用的标志
        let cellIdentifier = "cell"
        // 查找是否有可重复的Cell
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        // 如果没有可重用的Cell就创建一个新的
        if cell == nil {
            //系统默认一个有四种样式 .default .subtitle .value1 .value2
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        cell?.accessoryType = .disclosureIndicator;
        let dic = list[indexPath.row];
        cell?.textLabel?.text = dic["title"];
        cell?.detailTextLabel?.text = dic["detial"];
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dic = list[indexPath.row];
        switch indexPath.row {
        case 0:
            let vc = ControlViewController.instantiate();
            vc.title = dic["title"];
            self.navigationController?.pushViewController(vc, animated: true);
        case 1:
            let vc = iCloudViewController.init();
            vc.title = dic["title"];
            self.navigationController?.pushViewController(vc, animated: true);
        default:
            break
        }
    }
    
    // MARK: - Table view data source
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
