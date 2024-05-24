import Foundation

class Service {
    
    typealias SuccessHandler<T> = (T?, String?) -> ()
    
    private func makeGetRequest<T: Decodable>(url: URL, completion: @escaping SuccessHandler<T>) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                print("error: \(error!)")
                DispatchQueue.main.async {
                    completion(nil, error!.localizedDescription)
                }
                return
            }
            
            guard let data = data else {
                print("No data")
                DispatchQueue.main.async {
                    completion(nil, "No data")
                }
                return
            }
            
            print(data.count)
            let decodedData = try? JSONDecoder().decode(T.self, from: data)
            
            DispatchQueue.main.async {
                if let decodedData = decodedData {
                    completion(decodedData, nil)
                } else {
                    completion(nil, "Failed to decode data")
                }
            }
        }
        task.resume()
    }

    private func makePostRequest<T: Decodable, U: Encodable>(url: URL, body: U, completion: @escaping SuccessHandler<T>) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            DispatchQueue.main.async {
                completion(nil, "Failed to serialize JSON")
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                print("error: \(error!)")
                DispatchQueue.main.async {
                    completion(nil, error!.localizedDescription)
                }
                return
            }
            
            guard let data = data else {
                print("No data")
                DispatchQueue.main.async {
                    completion(nil, "No data")
                }
                return
            }
            
            print(data.count)
            let decodedData = try? JSONDecoder().decode(T.self, from: data)
            
            DispatchQueue.main.async {
                if let decodedData = decodedData {
                    completion(decodedData, nil)
                } else {
                    completion(nil, "Failed to decode data")
                }
            }
        }
        task.resume()
    }
    

    func login(body: LoginRequest, completed: @escaping SuccessHandler<LoginResponse>) {
        let urlString = "https://reqres.in/api/login"
        guard let url = URL(string: urlString) else {
            completed(nil, "Invalid URL")
            return
        }
        makePostRequest(url: url, body: body, completion: completed)
    }
    
    func updateDetails(body: EmployeeDetailsUpdateRequest, completed: @escaping SuccessHandler<LoginResponse>) {
        let urlString = "https://reqres.in/api/users"
        guard let url = URL(string: urlString) else {
            completed(nil, "Invalid URL")
            return
        }
        makePostRequest(url: url, body: body, completion: completed)
    }
}
