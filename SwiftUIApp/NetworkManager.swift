//
//  NetworkManager.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 8/15/24.
//

import Alamofire

public class NetworkManager {
    func getApod(request: NasaRequestModel, completion: @escaping (Result<[NasaResponseModel], Error>) -> Void) {
        let urlString = "https://api.nasa.gov/planetary/apod?api_key=\(request.key)&count=\(request.count)"
    
    AF.request(urlString)
      .validate()
      .responseDecodable(of: [NasaResponseModel].self) { response in
        switch response.result {
        case .success(let responseList):
          completion(.success(responseList))
        case .failure(let error):
          completion(.failure(error))
        }
      }
  }
}
