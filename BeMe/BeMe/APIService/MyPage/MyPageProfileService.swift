//
//  MyPageProfileService.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/13.
//

import Foundation
import Alamofire

struct MyPageProfileService {
    static let shared = MyPageProfileService()
    
    func getMyProfile(completion : @escaping (NetworkResult<Any>) -> (Void) ){
        let url = APIConstants.myPageProfileURL
        
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
                
                
                
                completion(judgeGetProfile(status: statusCode, data: data))
                
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
            
        }
        
        
        
    }
    
    func setMyProfile(image: UIImage, completion : @escaping (NetworkResult<Any>) -> (Void) ){
        let url = APIConstants.myPageProfileURL
        
        let header : HTTPHeaders = [
            //            "Content-Type":"application/json",
            "Content-Type":"multipart/form-data",
            //            "token":UserDefaults.standard.string(forKey: "token")!
            "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjA5Nzc3ODg2LCJleHAiOjE2MzU2OTc4ODYsImlzcyI6ImJlbWUifQ.34mc263uDc9vYq9N8BVzfqVdsgKzL51Ld03kB0afcSQ"
        ]
        AF.upload(multipartFormData: { multiPartFormData in
            let imageData = image.jpegData(compressionQuality: 1.0)!
            multiPartFormData.append(imageData,withName:"image",fileName:"file.jpeg",mimeType:"image/jpeg")
            print("image")
            
        },to: url, usingThreshold:UInt64.init(), method:.put, headers:header)
        .responseJSON(completionHandler: { response in
            switch response.result {
            case .success :
                guard let statusCode = response.response?.statusCode else{
                    return
                }
                guard let data = response.data else{
                    return
                }
                print(response)
                completion(judgeSetProfile(status: statusCode, data: data))
            case .failure(let err):
                print(err)
                completion(.networkFail)
                
                
            }
            
            
        })
    }
    
    private func judgeGetProfile(status : Int, data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<MyProfile>.self, from : data) else{
            return .pathErr
        }
        
        switch status{
        case 200..<300:
            //            print(decodedData.message)
            //            print(decodedData.data)
            return .success(decodedData.data)
        case 400..<500 :
            return .requestErr(decodedData.message)
        case 500 :
            return .serverErr
            
        default :
            return .networkFail
            
            
        }
        
    }
    private func judgeSetProfile(status : Int, data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<ProfileResult>.self, from : data) else{
            return .pathErr
        }
        
        switch status{
        case 200..<300:
            //            print(decodedData.message)
            //            print(decodedData.data)
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


struct ProfileResult: Codable {
    let id: Int
    let profileImg: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case profileImg = "image"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(Int.self, forKey: .id)) ?? -1
        profileImg = (try? values.decode(String.self, forKey: .profileImg)) ?? ""
        
        
    }
}


