//
//  FollowingFollowService.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/08.
//

import Foundation

import Alamofire

struct FollowingGetService{
    
    static let shared = FollowingGetService()
    
    func getHomeData(completion : @escaping (NetworkResult<Any>) -> (Void) ){
        let url = APIConstants.followGetURL
        
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
        guard let decodedData = try? decoder.decode(GenericResponse<FollowingGetData>.self, from : data) else{
            return .pathErr
        }
        
        switch status{
        case 200..<300:
            print("팔로잉 팔로워 조회 성공")
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
