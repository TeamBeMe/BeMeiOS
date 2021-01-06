//
//  SignUpService.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/05.
//

import Foundation
import Alamofire


struct SignUpService{
    static let shared = SignUpService()
    func signUp(email : String, nickName : String, password : String, image: UIImage,
                completion : @escaping (NetworkResult<Any>) -> (Void)) {
        let url = APIConstants.signupURL
        
        let header : HTTPHeaders = [
            "Content-Type":"multipart/form-data"
        ]
        
        let body : Parameters = [
            "email" : email,
            "nickname": nickName,
            "password" : password
        ]
        

        AF.upload(multipartFormData: { multiPartFormData in
            for (key,value) in body{
                if value is String{
                    let val = value as! String
                    multiPartFormData.append(val.data(using:String.Encoding.utf8)!,withName:key)
                    print(key)
                }
                else if value is Int{
                    let val = value as! Int
                    multiPartFormData.append("\(val)".data(using:String.Encoding.utf8)!, withName: key)
                    print(key)
                }
            }
            
            let imageData = image.jpegData(compressionQuality: 1.0)!
            multiPartFormData.append(imageData,withName:"image",fileName:"file.jpeg",mimeType:"image/jpeg")
            print("image")

        },to: APIConstants.signupURL, usingThreshold:UInt64.init(), method:.post, headers:header)
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
                completion(judgeSignUpData(status: statusCode, data: data))
            case .failure(let err):
                print(err)
                completion(.networkFail)
                
            
            }
            
            
        })
            
            
            
            

        
        
        
        
    }
    
    private func judgeSignUpData(status : Int, data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<SignUpData>.self, from : data) else{
            print("called7")
            return .pathErr
            
        }
       print(status)
        switch status{
        case 200..<300:
            print("called1")
            return .success(decodedData.data)
        case 400..<500 :
            print("called2")
            return .requestErr(decodedData.message)
        case 500 :
            print("called3")
            return .serverErr
            
        default :
            print("called4")
            return .networkFail
            
            
        }
    }
}
