//
//  CryptoViewModel.swift
//  CryptoRxMVVM
//
//  Created by Furkan buğra karcı on 8.08.2024.
//

import Foundation
import RxSwift
import RxCocoa
class CryptoViewModel{
    
    let cryptos:PublishSubject<[Crypto]>=PublishSubject()
    let error:PublishSubject<String>=PublishSubject()
    let loading:PublishSubject<Bool>=PublishSubject()
    
    
    
func requestData(){
    self.loading.onNext(true)
    let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
    Webservice().downloadCurrencies(url: url) { result in
        self.loading.onNext(false)
        switch result{
        case.success(let cryptos):
            self.cryptos.onNext(cryptos)
            
        case.failure(let error):
            print(error)
        }
    }
}
}
