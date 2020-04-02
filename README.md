# 🌩 TinyNetworking
<p align="left">
    <img src="https://img.shields.io/badge/Swift-5.1-orange.svg" />
    <img src="https://img.shields.io/badge/platforms-iOS | macOS | watchOS | tvOS-brightgreen.svg?style=flat" alt="Mac" />
    <a href="https://twitter.com/_disho">
        <img src="https://img.shields.io/badge/twitter-@_disho-blue.svg?style=flat" alt="Twitter: @_disho" />
    </a>
</p>

- A simple network abstraction layer written in Swift.
- A thin wrapper around NSURLSession.
- Supports CRUD methods.
- Compile-time checking for correct API endpoint accesses.
- Combine extensions to the API.
- (Optional) RxSwift extensions to the API.
- Inspired by [Moya](https://github.com/Moya/Moya).
- No external dependencies. 

## 🛠 Installation

### CocoaPods
To integrate TinyNetworking into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'TinyNetworking'
    
#or
    
pod 'TinyNetworking/RxSwift' # for the RxSwift extentions
```

Then, run the following command:

```bash
$ pod install
```

### Carthage 
*Coming Soon*

### Swift Package Manager 
Add the following as a dependency to your `Package.swift`:

 `.package(url: "https://github.com/jdisho/TinyNetworking.git", .upToNextMajor(from: "4.0.0"))`

### Manually
If you prefer not to use any of the dependency managers, you can integrate TinyNetworking into your project manually, by downloading the source code and placing the files on your project directory.

## 🏃‍♀️ Getting started
Set up an `enum` with all of your API resources like the following:

```swift
enum Unsplash {
  case me
  case photo(id: String)
  case collection(id: String)
  case likePhoto(id: String)
  ...
}
```

Extend `enum` and confom to `Resource` protocol.

```swift
extension Unsplash: Resource {
  var baseURL: URL {
    return URL(string: "https://api.unsplash.com")!
  }
  
  var endpoint: Endpoint {
    switch self {
    case .me:
      return .get(path: "/me")
    case let .photo(id: id):
      return .get(path: "/photos/\(id)")
    case let .collection(id: id):
      return .get(path: "/collections/\(id)")
    case let .likePhoto(id: id):
      return .post(path: "/photos/\(id)/like")
    }
  }
 
  var task: Task {
    var params: [String: Any] = [:]
    return .requestWithParameters(params, encoding: URLEncoding())
  }
  
  var headers: [String: String] {
    return ["Authorization": "Bearer xxx"]
  }
  
  var cachePolicy: URLRequest.CachePolicy {
    return .useProtocolCachePolicy
  }
}
```

### ⚙️ Making and handling a request
```swift
import TinyNetworking

let tinyNetworking = TinyNetworking<Unsplash>()

tinyNetworking.request(.photo(id: "1234")) { result in
  switch result {
    case let .success(response):
      let photo = try? response.map(to: Photo.self)
      print(photo)
    case let .failure(error):
      print(error)
  }
}
```

### 🔖 Response
After making a request, `TinyNetworking` gives a result back in the form of `Result<Response, TinyNetworkingError>`, which has two cases to `switch` over. In case of success, a `Response` object is given, otherwise an error.

The `Response` object gives the possibility to use: 
- Raw data from the request. 
- The `URLRequest` object.
- The HTTP response.
- Debug description. 
- The JSON repdesentation of the data.
- The pretty printed version of the data in a JSON format.
- Method to map/decode the data to a decodable object. A decodable object, is an object that conforms to `Codable` (`Decodable+Encodable`) protocol.


## 🐍 Reactive Extensions
Reactive extensions are cool. TinyNetworking provides reactive extensions for Combine, RxSwift and **soon** for ReactiveSwift.

### Combine 
```swift 
return tinyNetworking
     .requestPublisher(resource: .photo(id: id))
     .map(to: Photo.self)
```

### RxSwift
```swift
return tinyNetworking.rx
     .request(resource: .photo(id: id))
     .map(to: Photo.self)
```
## ✨ Example
See [Papr](https://github.com/jdisho/Papr/tree/papr-tinyNetworking-version)

## 👤 Author
This tiny library is created with ❤️ by [Joan Disho](https://twitter.com/_disho) at [QuickBird Studios](www.quickbirdstudios.com)

### 📃 License
TinyNetworking is released under an MIT license. See [License.md](https://github.com/jdisho/TinyNetworking/blob/master/LICENSE) for more information.
