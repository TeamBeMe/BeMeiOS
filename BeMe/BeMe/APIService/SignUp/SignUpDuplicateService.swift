//
//  SignUpService.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/05.
//

import Foundation
import Alamofire


struct SignUpDuplicateService{
    static let shared = SignUpDuplicateService()
    func check(nickName : String, completion : @escaping (NetworkResult<Any>) -> (Void)) {
        let url = APIConstants.signupDuplicateURL+nickName
        
        let header : HTTPHeaders = [
            "Content-Type":"application/json"
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
        guard let decodedData = try? decoder.decode(GenericResponse<SignUpDuplicateData>.self, from : data) else{
            return .pathErr
        }
        
        switch status{
        case 200..<300:
            print("닉네임 중복 검사 성공")
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
