//
//  ViewController.swift
//  CryptoRxMVVM
//
//  Created by Furkan buğra karcı on 8.08.2024.
//

import UIKit
import RxSwift
class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    let cryptoVM = CryptoViewModel()
    let disposeBag=DisposeBag()
    var cryptoList = [Crypto]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
        
        
        setupBindings()
        cryptoVM.requestData()
        
    }
    
    private func setupBindings(){
        cryptoVM.error.observe(on: MainScheduler.asyncInstance).subscribe { error in
                print(error)
        }.disposed(by: disposeBag)
        
        cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { cryptos in
                self.cryptoList=cryptos
                self.tableView.reloadData()
            }.disposed(by: disposeBag)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = cryptoList[indexPath.row].currency
        content.secondaryText = cryptoList[indexPath.row].price
        cell.contentConfiguration=content
        return cell
        
    }

}

