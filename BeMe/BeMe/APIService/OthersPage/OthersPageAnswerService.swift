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
    
    func getOthersPageAnswer(userId: Int, page: Int, completion : @escaping (NetworkResult<Any>) -> (Void) ){
        let url = APIConstants.othersPageAnswerURL+String(userId)+"?page="+String(page)
        
        let header : HTTPHeaders = [
            "Content-Type":"application/json",
//            "token":UserDefaults.standard.string(forKey: "token")!
            "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjA5Nzc3ODg2LCJleHAiOjE2MzU2OTc4ODYsImlzcyI6ImJlbWUifQ.34mc263uDc9vYq9N8BVzfqVdsgKzL51Ld03kB0afcSQ"
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
        guard let decodedData = try? decoder.decode(GenericResponse<[HomePageData]>.self, from : data) else{
            return .pathErr
        }
        
        switch status{
        case 200..<300:
            print("질문 page 받아오기 성공")
            print(decodedData.data)
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

