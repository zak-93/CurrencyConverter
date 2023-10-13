import Foundation

class PresenterListView {
    
    weak private var listViewInputDelegate: ListViewInputDelegate?
    
    let currencyKey = "currencys"
    var allCurrency: [String] = []
    var error: Error?
    
    func setListViewInputDelegate(listViewInputDelegate: ListViewInputDelegate) {
        self.listViewInputDelegate = listViewInputDelegate
    }
    
    private func getCurrencys(complition: @escaping(Result<[String], CurrentyError>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "currate.ru"
        urlComponent.path = "/api/"
        
        urlComponent.queryItems = [
            URLQueryItem(name: "get", value: "currency_list"),
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
                    let data = try JSONDecoder().decode(Currentys.self, from: responceData)
                    
                    DispatchQueue.main.async {
                        complition(.success(data.data))
                    }
                } catch {
                    return complition(.failure(.serverError))
                }
            }
        }.resume()
    }
}

extension PresenterListView: ListViewOutputDelegate {
    func getData() {
        getCurrencys { result in
            switch result {
            case .success(let currencys):
                self.listViewInputDelegate?.getCurrencys(data: currencys)
            case .failure(let error):
                self.listViewInputDelegate?.errorData(error: error)
            }
        }
    }
}
