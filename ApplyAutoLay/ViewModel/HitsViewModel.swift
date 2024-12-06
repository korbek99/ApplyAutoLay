//
//  HitsViewModel.swift
//  ApplyAutoLay
//
//  Created by Jose Preatorian on 04-12-24.
//

import Foundation

class HitsViewModel {
    
    private let webService: webServicesHits
     var hits: [Hit] = []
    var reloadData: (() -> Void)?
    var showError: ((String) -> Void)?
    
    init(webService: webServicesHits = webServicesHits()) {
        self.webService = webService
    }
    
    func fetchArticules() {
        webService.getArticles { [weak self] results in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let results = results {
                    self.hits = results
                    self.reloadData?()
                } else {
                    self.showError?("Failed to load data.")
                }
            }
        }
    }
  
    func articulos(at index: Int) -> Hit? {
        guard index >= 0 && index < hits.count else { return nil }
        return hits[index]
    }
}
