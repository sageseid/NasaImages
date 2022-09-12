# NasaImages

NasaChallenge is a a simple client app that allows users to scroll through the
catalog of NASA’s images.

JSON : https://images-api.nasa.gov/search?q=%22%22.

Designs:  https://www.figma.com/file/zy4XFycrYjVDp9zYbPSGCb/Nasa-Challenge?node-id=0%3A1.


## Technical specs
- Language: Swift
- Networking: URLSession
- UI: UIKit
- Architecture: MVVM
- ViewModelsfor storing UI state
- Custom Built Image Loader for image fetching and caching
- Swift standard coding/decoding for custom objects

## Installation
The app relies on no external libraries,
- Clone the repo 
- Open `NasaImages.xcodeproj` in XCode
  - Select your developer account
  - Choose simulator/device of choice
  - Clean Build Folder  
- Click on Run
