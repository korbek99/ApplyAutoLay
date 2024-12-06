//
//  webService.swift
//  ApplyAutoLay
//
//  Created by Jose Preatorian on 04-12-24.
//

import Foundation
import UIKit

class webServicesHits {
    var urlbase:String = ""
    var utils = UtilServices()
    func getArticles( completion: @escaping ([Hit]?) -> ()) {
        
        guard let endpointData = utils.getEndpoint(fromName: "crearIssue") else { return }
        
        print(endpointData.url)
        
        let url = URL(string: endpointData.url.absoluteString)!
        
        URLSession.shared.dataTask(with: url) { [self] data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                
            } else if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON recibido: \(jsonString)")
                }
                do {
                    let articleList = try JSONDecoder().decode(HitNews.self, from: data)
                    print(articleList)
                    completion(articleList.hits)
                } catch {
                    print("Error al decodificar JSON: \(error.localizedDescription)")
                    completion(nil)
                }
            }
            
        }.resume()
    }
 
}

