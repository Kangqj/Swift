//
//  NetworkViewController.swift
//  Swift_Study
//
//  Created by DT on 2022/2/16.
//

import UIKit
import Alamofire
import AlamofireImage
import Moya

class NetworkViewController: UIViewController {
    
    var webURL : String?
    var remark : String?
    var imageView: UIImageView?
    let weatherUrl:String = "http://weatherapi.market.xiaomi.com/wtr-v2/temp/realtime?cityId=101040100"
    
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
        
        imageView = UIImageView(frame: CGRect(x: 30, y: 180, width: 200, height: 200))
        self.view.addSubview(imageView!)
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
        let url = URL(string: "https://pis.junsangs.com/api/bing/api.php")!
        imageView?.af_setImage(withURL: url)
        
        //文档目录
        let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString
        //缓存目录
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString
        //临时目录
        let tempPath = NSTemporaryDirectory() as NSString
        NSLog("%@\n%@\n%@", documentPath, cachePath, tempPath)
        
        Alamofire.request("https://pis.junsangs.com/api/bing/api.php").response { response in

            print(response)
        }
        
//        getWeatherInfoByAlamofire()
        getWeatherInfoByMoya()
    }
    
    func getWeatherInfoByAlamofire() -> Void {
            Alamofire.request(weatherUrl,method:.get,parameters:nil,encoding: URLEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success(let json ):
                    let jsonDic = json as? NSDictionary
                    print(jsonDic! as NSDictionary);
                    break
                case .failure(let error):
                    print("error:\(error)")
                    break
                }
            }
        }
    
    /// 基本使用
    func getWeatherInfoByMoya() {
        NetworkProvider.request(NetworkAPI.realtimeWeather(cityId: "101040100")) { result in
            if case .success(let response) = result {
               // 解析数据
                let jsonDic = try! response.mapJSON() as! NSDictionary
                self.showAlert(weatherDic: jsonDic)
            }
        }
    }

    func showAlert(weatherDic:NSDictionary) -> Void {
               let dataDic = weatherDic["weatherinfo"] as! NSDictionary
               let temp = dataDic["temp"] as!String
               let sd = dataDic["SD"] as!String
               
               
               let alertController = UIAlertController(title:"提示",message:"重庆当前温度：\(temp)℃,湿度：\(sd)",preferredStyle: .alert);
               let canceAction = UIAlertAction(title:"取消",style:.cancel,handler:nil);
               let okAciton = UIAlertAction(title:"确定",style:.default,handler: {
                   action in
                   print("他点击了确定")
               })
               alertController.addAction(canceAction);
               alertController.addAction(okAciton);
               self.present(alertController, animated: true, completion: nil)
           }

}
