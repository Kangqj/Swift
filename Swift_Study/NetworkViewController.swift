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
    var textView: UITextView?
    let weatherUrl:String = "http://weatherapi.market.xiaomi.com/wtr-v2/temp/realtime?cityId=101040100"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let rightItem = UIBarButtonItem(title: "资料", style: .plain, target: self, action: #selector(showInfo))
        self.navigationItem.rightBarButtonItem = rightItem
        
        let button = UIButton(type: UIButton.ButtonType.system)
        button.frame = CGRect(x: 30, y: 120, width: 100, height: 40)
        button.setTitle("Get Pciture", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.backgroundColor = UIColor .blue
        button.layer.cornerRadius = 10
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(picRequest), for: .touchUpInside)
        
        let wbutton = UIButton(type: UIButton.ButtonType.system)
        wbutton.frame = CGRect(x: 140, y: 120, width: 100, height: 40)
        wbutton.setTitle("Get Weather", for: UIControl.State.normal)
        wbutton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        wbutton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        wbutton.backgroundColor = UIColor .red
        wbutton.layer.cornerRadius = 10
        self.view.addSubview(wbutton)
        wbutton.addTarget(self, action: #selector(getWeatherInfoByMoya), for: .touchUpInside)
        
        let getbutton = UIButton(type: UIButton.ButtonType.system)
        getbutton.frame = CGRect(x: 250, y: 120, width: 100, height: 40)
        getbutton.setTitle("Get Poetry", for: UIControl.State.normal)
        getbutton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        getbutton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        getbutton.backgroundColor = UIColor .brown
        getbutton.layer.cornerRadius = 10
        self.view.addSubview(getbutton)
        getbutton.addTarget(self, action: #selector(poetryRequest), for: .touchUpInside)
        
        let width = (self.view.frame.size.width-30)/2
        imageView = UIImageView(frame: CGRect(x: 10, y: 180, width: width, height: 200))
        self.view.addSubview(imageView!)
        imageView?.layer.borderWidth = 0.5
        imageView?.layer.borderColor = UIColor.gray.cgColor
        
        textView = UITextView(frame: CGRect(x: 20 + width, y: 180, width: width, height: 400))
        textView?.font = UIFont.systemFont(ofSize: 14)
        textView?.textColor = UIColor.black
        self.view.addSubview(textView!)
        textView?.isEditable = false
        textView?.layer.borderWidth = 0.5
        textView?.layer.borderColor = UIColor .gray.cgColor
        textView?.layer.cornerRadius = 10
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
    
    @objc func picRequest() {
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
            let jsonDic = response as? [String:Any]
            self.textView?.text = jsonDic?.toJsonString()
        }
    }
    
    func getWeatherInfoByAlamofire() -> Void {
        Alamofire.request(weatherUrl,method:.get,parameters:nil,encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success(let json ):
                let jsonDic = json as? NSDictionary
                print(jsonDic! as NSDictionary);
                self.textView?.text = json as? String
                break
            case .failure(let error):
                print("error:\(error)")
                break
            }
        }
    }
    
    /// 基本使用
    @objc func getWeatherInfoByMoya() {
        NetworkProvider.request(NetworkAPI.realtimeWeather(cityId: "101040100")) { result in
            if case .success(let response) = result {
               // 解析数据
                let jsonDic = try? response.mapJSON() as? [String:Any]
                self.textView?.text = jsonDic?.toJsonString();
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
    
    @objc func poetryRequest() {
        
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            NetworkProvider.request(NetworkAPI.getPoetryToken) { result in
                if case .success(let response) = result {
                    let jsonDic = try? response.mapJSON() as? [String:Any]
                    self.textView?.text = jsonDic?.toJsonString()
                    
                    let token = jsonDic?["data"] as? String
                    UserDefaults.standard.setValue(token, forKey: "token")
                    self.getPoetryDetailRequest(token: token)
                }
            }
            return
        }
        getPoetryDetailRequest(token: token)
    }
    
    func getPoetryDetailRequest(token:String?) {
        guard let p_tk = token else {
            return
        }
        
        NetworkProvider.request(NetworkAPI.getPoetryDetail(token: p_tk)) { result in
            if case .success(let response) = result {
                let jsonDic = try? response.mapJSON() as? [String:Any]
                self.textView?.text = jsonDic?.toJsonString()
            }
        }
    }
}
