//
//  ViewController.swift
//  RomWavesCustom
//
//  Created by 戴明亮 on 17/3/8.
//  Copyright © 2017年 戴明亮. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableView: UITableView? = { () -> (UITableView) in
        let tab = UITableView.init(frame: UIScreen.main.bounds, style: .plain)
       
        return tab
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView?.delegate = self
        tableView?.dataSource = self
        guard let tableView = tableView else {
            return
        }
        view.addSubview(tableView)
    }
    
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func demo() {
        
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         var cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cellId")
        }

        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId")
        
        
        if headerView == nil {
            headerView = UITableViewHeaderFooterView.init(reuseIdentifier: "headerId")
            
            let  waves  = RomWavesCustom.init(frame: CGRect.init(x: 0, y: 120, width: UIScreen.main.bounds.width, height: 80))
            headerView?.addSubview(waves)
            let imgv = UIImageView.init()
            imgv.image = UIImage.init(named: "swiftIcon")
            let size = CGSize.init(width: 50, height: 50)
                //imgv.image?.size ?? CGSize.init(width: 50, height: 50);
            imgv.center = CGPoint.init(x: UIScreen.main.bounds.size.width * 0.5, y: 145 - size.height * 0.5)
            imgv.bounds = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
            imgv.layer.cornerRadius = size.width * 0.5
            imgv.clipsToBounds = true
            let originY = imgv.frame.origin.y
            waves.currentYOffset = {  (offset) -> () in
                var rect = imgv.frame
                var inset = offset
                inset -= 25
     
                rect.origin.y = (originY - 25) + inset
              
                imgv.frame =  rect
            }
            
            headerView?.addSubview(imgv)
            
        }

        headerView?.layer.backgroundColor = UIColor.init(colorLiteralRed: 245/255.0, green: 68/255.0, blue: 4/255.0, alpha: 0.95).cgColor
       
        return headerView;

    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200;
    }
    
}
