//
//  SwiftModel.swift
//  Swift_Study
//
//  Created by DT on 2022/2/16.
//

import UIKit

class SwiftModel: NSObject {
    var title : String?
    var content : String?
    var modelID : String?
    var comments : [String]?
    
    init(title: String, content: String, id:String, comments:[String]) {
        self.title = title
        self.content = content
        self.modelID = id
        self.comments = comments
    }
}
