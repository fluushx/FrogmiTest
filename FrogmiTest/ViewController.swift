//
//  ViewController.swift
//
//  Created by Felipe Ignacio Zapata Riffo//

import UIKit
import Foundation
import HGPlaceholders
import ViewAnimator

class ViewController: UIViewController{

 
    var resultDatum = [Datum]()
    var result = [ResultData]()
    var num = 1
     
    private let apiCaller = APICaller()
    let tableView: TableView = {
       let tableVew = TableView()
        tableVew.register(TableViewCell.self    , forCellReuseIdentifier: TableViewCell.identifier)
        tableVew.translatesAutoresizingMaskIntoConstraints = false
        
        return tableVew
    }()
    
    private func createSpinerFooter()->UIView{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spiner = UIActivityIndicatorView()
        spiner.center = footerView.center
        footerView.addSubview(spiner)
        spiner.startAnimating()
        
        return footerView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.showLoadingPlaceholder()
   
    }
    
    func animation(){
        let animation = AnimationType.from(direction: .top, offset: 200)
        UIView.animate(views:tableView.visibleCells,animations: [animation])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpTableView()


        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.apiCaller.fecthData(completion: { [weak self] results in
            switch results {
            case .success(let data):
                print(data)
                self!.resultDatum = data.data
                self?.tableView.reloadData()
                self?.animation()
 
                 
             case .failure(_):
                self!.tableView.showErrorPlaceholder()
                break
            }
            
        })
    })
        
}
    
    private func setUpTableView(){
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
 
     
}

extension ViewController:UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resultDatum.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        let data = resultDatum[indexPath.row].attributes
        cell.typeLabel.text = data.name
        cell.direccionLabel.text = data.full_address
        cell.codeLabel.text = "| \(data.code)"
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let position = scrollView.contentOffset.y

        if position > tableView.contentSize.height-100-scrollView.frame.size.height{
        
            self.tableView.tableFooterView = self.createSpinerFooter()
            
            DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: { [self] in
                self.num += 1
                
                if num < 90 {
                    
                    let urlScroll =  "https://api.frogmi.com/api/v3/stores?per_page=\(self.num)"
                     
                    self.apiCaller.fecthDataPerPage(urlBase: urlScroll) { [weak self] results in
                        switch results {
                        case .success(let data):
                            
                            self!.resultDatum = data.data
                            
                            self?.tableView.reloadData()
                            self?.animation()
                             
                        case .failure(_):
                            self!.tableView.showErrorPlaceholder()
                            break
                        }
                        
                    }
                }
        
            })
           
        }
    }
}
