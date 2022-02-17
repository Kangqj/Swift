//
//  NetworkModel.swift
//  Swift_Study
//
//  Created by DT on 2022/2/17.
//

import UIKit

class NetworkModel: NSObject {
    func getRandomUrl() -> URL {
        return URL(string: "https://pis.junsangs.com/api/bing/api.php")!
    }
}
