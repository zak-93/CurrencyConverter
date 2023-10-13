import Foundation

// MARK: Обработка ошибок с сервера / Error form the server
enum CurrentyError: Error, LocalizedError {
    case invalidURL
    case serverError
    case invalidData
    case noCurrency
    case unkown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Некорректный URL"
        case .serverError:
            return "Ошибка сервера"
        case .invalidData:
            return "Некорректные данные с сервера"
        case .noCurrency:
            return "Нет такой валютной пары, выберите другую"
        case .unkown(let error):
            return error.localizedDescription
        }
    }
}

// MARK: Обработака ошибок введения данных / Data entry error handling
enum ErrorMainView {
    case noCarrency
    case noValue
    case invalidValue
    
    var errorDescription: String? {
        switch self {
        case .noCarrency:
            return "Выберите валюту"
        case .noValue:
            return "Введите число"
        case .invalidValue:
            return "Некорректное число"
        }
    }
}

// MARK: Выбор левой или правой пары // Click left or right pair
enum CurrencyValue {
    case left
    case right
}

//MARK: Значение по умолчанию в валютных парах / Default value in currency pair
enum DefaultValue: String {
    case currency
}
