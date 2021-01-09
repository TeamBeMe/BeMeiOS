//
//  ExploreCategoryService.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/09.
//

import Foundation
import Alamofire

struct ExploreCategoryService {
    static let shared = ExploreCategoryService()
    
    func getExploreCategory(completion: @escaping (NetworkResult<Any>) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjEwMDk5MjQwLCJleHAiOjE2MzYwMTkyNDAsImlzcyI6ImJlbWUifQ.JeYfzJsg-kdatqhIOqfJ4oXUvUdsiLUaGHwLl1mJRvQ"
        let header: HTTPHeaders = ["Content-Type":"application/json", "token":token]
        
        let url = APIConstants.explorationCategoryURL
        let dataRequest = AF.request(url, method: .get, headers: header)
        
        dataRequest.validate(statusCode: 200..<500)
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
        guard let decodedData = try? decoder.decode(GenericResponse<[ExploreCategory]>.self, from : data) else { return .pathErr }

        switch statusCode {
        case 200..<300: return .success(decodedData)
        case 400..<500: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
}

