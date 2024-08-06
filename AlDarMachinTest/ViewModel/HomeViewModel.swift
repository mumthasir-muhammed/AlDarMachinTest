//
//  HomeViewModel.swift
//  AlDarMachinTest
//
//  Created by Mumthasir VP on 06/08/24.
//

import Foundation

class HomeViewModel: NSObject {
    private(set) var newsData : News! {
        didSet {
            self.bindHomeViewModelToController()
        }
    }
    override init() {
        super.init()
        callFuncToGetNewsData()
    }
    
    var bindHomeViewModelToController : (() -> ()) = {}
    
    func callFuncToGetNewsData() {
        APIService.shared.apiCall(urlString: "\(Constants.baseUrl)q=all&apiKey=\(Constants.apiKey)", type: News.self) { result in
            switch result {
            case .success(let responseModel):
                self.newsData =  responseModel
            case .failure(let error):
                debugPrint("#Error on service all::\(error)")
            }
        }
    }
    
    func callFuncToGetNewsDataBasedOnTags(tag: String,  completion:  @escaping (News?) -> Void) {
        APIService.shared.apiCall(urlString: "\(Constants.baseUrl)q=\(tag)&apiKey=\(Constants.apiKey)", type: News.self) { result in
            switch result {
            case .success(let responseModel):
                completion(responseModel)
            case .failure(let error):
                debugPrint("#Error on service all:\(error)")
                completion(nil)
            }
        }
    }
}
