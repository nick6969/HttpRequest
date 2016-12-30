//
//  ViewController.swift
//  HttpRequest
//
//  Created by nick on 2016/12/30.
//  Copyright © 2016年 nick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let url = "http://opendata2.epa.gov.tw/AQX.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        request()
        
    
    }

    func request(){
        var request = URLRequest(url: URL(string:url)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request)
        { (data , res , err) in
            guard err == nil else
            {
                print(err!.localizedDescription)
                return
            }
            
            if
                let data = data,
                let arrayDic = self.convert(data)
            {
                arrayDic.forEach
                {
                    $0.enumerated().forEach
                    {
                        print($0)
                    }
                }
                
            }
        }.resume()
    }

    func convert(_ data :Data)->[[String:Any]]?{
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers ) as? [[String:Any]]
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }

    
    

}

