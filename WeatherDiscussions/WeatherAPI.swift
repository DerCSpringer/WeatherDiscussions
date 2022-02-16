
import Foundation

struct WeatherAPI {
    static func weatherDiscussionFor(forecastOffice: String, completion: @escaping (String) -> Void) {

        var currentForecastDiscussionURL: URL?

        let queue: DispatchQueue = DispatchQueue(label: "com.gcd.weatherDiscussion", attributes: .concurrent)
        let semaphore = DispatchSemaphore(value: 0)

        let session = URLSession(configuration: .default)
        var baseURL = URLComponents(string: "https://api.weather.gov")!
        baseURL.path = "/products/types/AFD/locations/\(forecastOffice)"
        let forecastURL = baseURL.url!

        queue.async {
            session.dataTask(with: forecastURL) { data, _, _ in
                if let data = data,
                   let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    guard let forecastDiscussions = json["@graph"] as? [[String:Any]] else {
                        return
                    }
                    guard let latestForecastDiscussion = forecastDiscussions.first?["@id"] as? String else {
                        return
                    }
                    if let forecastDiscussionURL = URL(string: latestForecastDiscussion) {
                        currentForecastDiscussionURL = forecastDiscussionURL
                        semaphore.signal()
                    }
                }

            }.resume()

            semaphore.wait()
            guard currentForecastDiscussionURL != nil else {
                return
            }
            session.dataTask(with: currentForecastDiscussionURL!) { data, _, _ in
                if let data = data,
                   let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    guard let forecastDiscussion = json["productText"] as? String else {
                        return
                    }
                    semaphore.signal()
                    completion(forecastDiscussion)
                }

            }.resume()
        }
    }
}
