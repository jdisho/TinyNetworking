<p align="center">
  <img src="https://github.com/jdisho/TinyNetworking/blob/master/Images/tinynetworking-logo.png">
</p>

<p align="center">
  <a href="https://github.com/jdisho/TinyNetworking">
        <img src="https://img.shields.io/cocoapods/p/TinyNetworking.svg?style=flat" />
  </a>
  <a href="https://swift.org">
        <img src="https://img.shields.io/badge/Swift-4.0-orange.svg" />
  </a>
  <a href="https://cocoapods.org/pods/TinyNetworking">
        <img src="https://img.shields.io/cocoapods/v/TinyNetworking.svg" />
  </a>
 
</p>

#
**TinyNetworking** is a simple network abstraction layer written in Swift.

- 🌯 Just a thin wrapper around NSURLSession.
- ✌️ Supports CRUD methods.
- 🚦 Compile-time checking for correct API endpoint accesses.
- 🐍 (Optional) RxSwift extensions to the API.
- ❤️ Inspired by [Moya](https://github.com/Moya/Moya).
- 🎉 No external dependencies. 

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
*Comming Soon*

### Swift Package Manager 
*Comming Soon*

### Manually

If you prefer not to use any of the dependency managers, you can integrate TinyNetworking into your project manually, by downloading the source code and placing the files on your project directory.

## 👨🏻‍💻 Usage
Set up an `enum` with all of your API resources like this example:

```swift
enum Unsplash {
  case me
  case photo(id: String)
  case collection(id: String)
  case likePhoto(id: String)
  ...
}
```

Extend `enum` and confom to `ResourceType` protocol.

```swift
extension Unsplash: ResourceType {
  var baseURL: URL {
    guard let url = URL(string: "https://api.unsplash.com") else {
      fatalError("FAILED: https://api.unsplash.com")
    }
    return url
  }
  
  var endpoint: String {
    switch self {
    case .me:
      return "/me"
    case let .photo(id):
      return "/photos/\(id)"
    case let .collection(id):
      return "/collections/\(id)"
    case let .likePhoto(id):
      return "/photos/\(id)/like"
    }
  }
  
  var method: HTTPMethod {
    switch self {
      case .me, .photo, .collection:
        return .get
      case .likePhoto:
        return .post
    }
  }
  
  // Sends paramters in URL or in HTTP Body
  var task: Task {
    var params = [:]
    return .requestWithParameters(params)
  }
  
  var headers: [String: String] {
    return ["Authorization": "Bearer xxx"]
  }
}
```

### ⚙️ Making and handling a request

```swift
import TinyNetworking

let tinyNetworking = TinyNetworking<Unsplash>()

tinyNetworking.request(.photo("1234")) { response in
  switch response {
    case let .success(result):
      let photo = try? result.map(to: Photo.self)
      print(photo)
    case let .error(error):
      print(error)
  }
}
```

## 🔥 Reactive Extensions
Reactive extensions are cool. TinyNetworking provides reactive extensions for RxSwift and **soon** for ReactiveSwift.

### RxSwift
```swift
return tinyNetworking.rx
     .request(resource: .photo(id: id))
     .map(to: Photo.self)
```
## ✨ Example
See [Papr](https://github.com/jdisho/Papr/tree/papr-tinyNetworking-version)

## 🐨 Author
This tiny library is created with ❤️ by [Joan Disho](https://twitter.com/_disho) at [QuickBird Studios](www.quickbirdstudios.com)

### 📃 License

TinyNetworking is released under an MIT license. See [License.md](https://github.com/jdisho/TinyNetworking/blob/master/LICENSE) for more information.
