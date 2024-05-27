import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func didLoginSuccessfully()
    func didFailToLogin(withError error: String)
}

class LoginViewModel {
    weak var delegate: LoginViewModelDelegate?
    
    private let interactor: StaffInteractorProtocol
    
    init(interactor: StaffInteractorProtocol) {
        self.interactor = interactor
    }
    
    func login(email: String, password: String) {
        let loginRequest = LoginRequest(email: email, password: password)
        interactor.login(body: loginRequest) { result in
            switch result {
            case .success(let response):
                print("Login successful, token: \(response.token ?? "")")
                if let token = response.token {
                    TokenManager.shared.saveToken(token)
                    self.delegate?.didLoginSuccessfully()
                } else {
                    self.delegate?.didFailToLogin(withError: "Invalid token")
                }
            case .failure(let error):
                self.delegate?.didFailToLogin(withError: error.localizedDescription)
            }
        }
    }
}
