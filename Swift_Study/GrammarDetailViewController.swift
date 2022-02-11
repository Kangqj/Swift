//
//  GrammarDetailViewController.swift
//  Swift_Study
//
//  Created by james on 2022/2/11.
//

import UIKit

class GrammarDetailViewController: UIViewController {

    @IBOutlet weak var mTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    static func instantiate() ->GrammarDetailViewController?
    {
        let story = UIStoryboard(name: "GrammarDetailViewController", bundle: nil)
        guard let vc = story.instantiateViewController(identifier: "GrammarDetail") as? GrammarDetailViewController else {
            return nil
        }
        return vc
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
