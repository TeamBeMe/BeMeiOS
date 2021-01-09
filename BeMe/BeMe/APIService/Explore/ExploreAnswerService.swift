//
//  ExploreAnswerService.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/09.
//

import Foundation
import Alamofire

struct ExploreAnswerService {
   static let shared = ExploreAnswerService()
   
   func getExploreAnswer(page: Int = 1, category: Int?, sorting: String, completion: @escaping (NetworkResult<Any>) -> Void) {
      let token = UserDefaults.standard.string(forKey: "token") ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjEwMDk5MjQwLCJleHAiOjE2MzYwMTkyNDAsImlzcyI6ImJlbWUifQ.JeYfzJsg-kdatqhIOqfJ4oXUvUdsiLUaGHwLl1mJRvQ"
      let header: HTTPHeaders = ["Content-Type":"application/json", "token":token]
      
      var params: Parameters = [:
      ]
      
      if let c = category {
         params = [
            "page": "\(page)",
            "category": "\(c)",
            "sorting": "\(sorting)"
         ]
      } else {
         params = [
            "page": "\(page)",
            "sorting": "\(sorting)"
         ]
      }
      let url = APIConstants.explorationDiffArticleURL
      let dataRequest = AF.request(url, method: .get, parameters: params, headers: header)
      
      dataRequest
         .validate(statusCode: 200..<500)
         .responseData { (response) in
            switch response.result {
            case .success:
               guard let statusCode = response.response?.statusCode else { return }
               guard let value = response.value else { return }
               
               let networkResult = self.judge(by: statusCode, value)
               
               completion(networkResult)
            case .failure: completion(.networkFail)
            }
         }
   }
   
   private func judge(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
      let decoder = JSONDecoder()
      guard let decodedData = try? decoder.decode(GenericResponse<ExploreAnswerData>.self, from : data) else { return .pathErr }
   
      switch statusCode {
      case 200..<300: return .success(decodedData)
      case 400..<500: return .pathErr
      case 500: return .serverErr
      default: return .networkFail
      }
   }
}

