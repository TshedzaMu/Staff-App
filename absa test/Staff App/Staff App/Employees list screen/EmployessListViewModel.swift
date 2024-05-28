import Foundation

protocol EmployeeSelectionDelegate: AnyObject {
    func didSelectEmployee(_ employee: Employee)
}

class EmployessListViewModel {
    
    var employeeList: [Employee]?
    var unFilteredEmployeeList: [Employee] = []
    
    lazy var interactor: StaffInteractorProtocol = StaffInteractor(service: Service())
    
    var onEmployeesFetched: (() -> Void)?
    var onFetchFailed: ((String) -> Void)?
    
    var employeeListNumber: Int {
        return employeeList?.count ?? 0
    }
    
    func getEmployeeList() {
        interactor.getEmployees { [weak self] result in
            switch result {
            case .success(let response):
                self?.employeeList = response.data
                self?.unFilteredEmployeeList = response.data ?? []
                self?.onEmployeesFetched?()
            case .failure(let error):
                let errorMessage = error.localizedDescription
                print("Failed to fetch employees, error: \(errorMessage)")
                self?.onFetchFailed?(errorMessage)
            }
        }
    }
    
    func filterEmployeeList(with text: String) {
        if text.isEmpty {
            employeeList = unFilteredEmployeeList
        } else {
            employeeList = unFilteredEmployeeList.filter { $0.first_name?.localizedCaseInsensitiveContains(text) ?? false }
        }
    }
}
