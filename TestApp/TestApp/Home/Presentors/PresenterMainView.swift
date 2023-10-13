import Foundation

class PresenterMainView {
    
    weak private var mainViewInputDelegate: MainViewInputDelegate?
    var error: Error?
    
    func setMainViewInputDelegate(mainViewInputDelegate: MainViewInputDelegate) {
        self.mainViewInputDelegate = mainViewInputDelegate
    }
    
    private func getCurrencyConverter(firstValue: String, secondValue: String, complition: @escaping(Result<Double, CurrentyError>) -> Void) {
        let currency = "\(firstValue)\(secondValue)"
        
        if firstValue == secondValue {
            return complition(.success(1.0))
        }
        
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "currate.ru"
        urlComponent.path = "/api/"
        
        urlComponent.queryItems = [
            URLQueryItem(name: "get", value: "rates"),
            URLQueryItem(name: "pairs", value: currency),
            URLQueryItem(name: "key", value: "5c65d51a8eba269b6538bd9ddf2c2f49")
        ]
        
        guard let url = urlComponent.url else {
            return complition(.failure(.invalidURL))
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            guard error == nil else {
                return complition(.failure(.invalidData))
            }
            guard (responce as! HTTPURLResponse).statusCode == 200 else {
                return complition(.failure(.serverError))
            }
            
            if let responceData = data {
                do {
                    let data = try JSONDecoder().decode(Converter.self, from: responceData)
                    if let intData = Double(data.data[currency] ?? "1") {
                        DispatchQueue.main.async {
                            complition(.success(intData))
                        }
                    }
                } catch  {
                    DispatchQueue.main.async {
                        return complition(.failure(.noCurrency))
                    }
                }
            }
        }.resume()
    }
}

extension PresenterMainView: MainViewOutputDelegate {
    func getData(firstValue: String, secondValue: String) {
        getCurrencyConverter(firstValue: firstValue, secondValue: secondValue) { result in
            switch result {
            case .success(let value):
                self.mainViewInputDelegate?.getData(data: value)
            case .failure(let error):
                self.mainViewInputDelegate?.errorData(error: error)
            }
        }
    }
}
