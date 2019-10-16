# 🌩 TinyNetworking
<p align="left">
  <a href="https://github.com/jdisho/TinyNetworking">
        <img src="https://img.shields.io/cocoapods/p/TinyNetworking.svg?style=flat" />
  </a>
  <a href="https://swift.org">
        <img src="https://img.shields.io/badge/Swift-5.0-orange.svg" />
  </a>
  <a href="https://cocoapods.org/pods/TinyNetworking">
        <img src="https://img.shields.io/cocoapods/v/TinyNetworking.svg" />
  </a>
</p>

- A simple network abstraction layer written in Swift.
- A thin wrapper around NSURLSession.
- Supports CRUD methods.
- Compile-time checking for correct API endpoint accesses.
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

 `.package(url: "https://github.com/jdisho/TinyNetworking.git", .upToNextMajor(from: "3.0.0"))`

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

tinyNetworking.request(.photo(id: "1234")) { response in
  switch response {
    case let .success(result):
      let photo = try? result.map(to: Photo.self)
      print(photo)
    case let .error(error):
      print(error)
  }
}
```

## 🐍 Reactive Extensions
Reactive extensions are cool. TinyNetworking provides reactive extensions for RxSwift and **soon** for ReactiveSwift.

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
