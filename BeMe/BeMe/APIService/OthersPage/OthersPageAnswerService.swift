//
//  OthersPageAnswerService.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/11.
//

import Foundation
import Alamofire

struct OthersPageAnswerService {
    static let shared = OthersPageAnswerService()
    
    func getOthersAnswer(userId: Int, page: Int, completion : @escaping (NetworkResult<Any>) -> (Void) ){
        // page deault -> 0
        let url = APIConstants.othersPageAnswerURL+String(userId)+"?page="+String(page)
        
        let header : HTTPHeaders = [
            "Content-Type":"application/json",
            "token":UserDefaults.standard.string(forKey: "token")!
//            "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjEwMDk5MjQwLCJleHAiOjE2MzYwMTkyNDAsImlzcyI6ImJlbWUifQ.JeYfzJsg-kdatqhIOqfJ4oXUvUdsiLUaGHwLl1mJRvQ"
        ]

        
        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        
        dataRequest.responseData{ response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else{
                    return
                }
                guard let data = response.value else{
                    return
                    
                }
               
                completion(judge(status: statusCode, data: data))

            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
            
        }
        
        
        
    }
    
    private func judge(status : Int, data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<OthersAnswer>.self, from : data) else{
            print("디코딩 실패")
            return .pathErr
        }
        
        switch status{
        case 200..<300:
            print("통신 성공")
//            print(decodedData.message)
//            print(decodedData.data?.answers[0].isScrapped)
            return .success(decodedData.data)
        case 400..<500 :
            return .requestErr(decodedData.message)
        case 500 :
            return .serverErr
            
        default :
            return .networkFail
            
            
        }
        
        
    }
    
    
    
}

