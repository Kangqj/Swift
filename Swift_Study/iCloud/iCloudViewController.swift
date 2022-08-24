//
//  iCloudViewController.swift
//  Swift_Study
//
//  Created by james on 2022/8/24.
//

import UIKit

class iCloudViewController: UIViewController {

    var keyStore:NSUbiquitousKeyValueStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        keyStore = NSUbiquitousKeyValueStore.default
        NotificationCenter.default.addObserver(self, selector: #selector(ubiquitousKeyValueStoreDidChange), name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification, object: keyStore)
    }
    
    func changeKey() {
        keyStore.set("hello", forKey: "name")
    }
    
    @objc func ubiquitousKeyValueStoreDidChange() {
        print("===\(keyStore.string(forKey: "name"))")
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
