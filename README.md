# DogPicsLibrary

**DogPicsLibrary** is a Swift package that provides a simple interface for fetching and displaying random dog images from a public API. It offers a modular design with components for networking, data parsing, and image downloading, making it easy to integrate into any iOS application.

## Features

- Fetch random dog images from a remote API.
- Download images locally.
- Parse JSON responses into usable models.
- Modular components for easy customization and extension.

## Installation

### Swift Package Manager

You can install `DogPicsLibrary` via Swift Package Manager. Simply add the following line to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/shravan3793/DogPicsLibrary.git", from: "1.0.0")
]
```

Alternatively, in Xcode:

1. Go to `File` > `Add Packages...`
2. Enter the package URL: `https://github.com/shravan3793/DogPicsLibrary.git`
3. Select the latest version and click `Add Package`.

## Usage

### 1. Fetching Dog Images

To fetch dog images, you can use the `DogPicsLibrary` class provided by the library. Here's a basic example:

```swift
import DogPicsLibrary

let fetcher = DogPicsLibrary()
let arrayOfImages : [UIImage?]? = await getImages(withCount : //your count here)

```

To fetch single image
```swift
import DogPicsLibrary


let fetcher = DogPicsLibrary()
let singleImage : UIImage? = await fetcher.getImage()

```


## Components

### Models
- **ResponseModel.swift:** Defines the structure of the dog image data model.

### Services
- **DogImageService.swift:** Manages the fetching and handling of dog images.

### Networking
- **NetworkManager.swift:** Handles all networking tasks, including making HTTP requests.
- **ImageDownloader.swift:** Downloads images.

### Utilities
- **DataParser.swift:** Parses JSON data from the network into `ResponseModel`.

## Folder Structure

The project is organized into the following structure:

```
DogPicsLibrary
├── Models
│   └── ResponseModel.swift
├── Services
│   └── DogImageService.swift
├── Networking
│   ├── NetworkManager.swift
│   └── ImageDownloader.swift
├── Utilities
│   └── DataParser.swift
└── Core
    └── DogPicsLibrary.swift
```

## Contributing

Contributions are welcome! If you have any ideas, suggestions, or bug reports, feel free to open an issue or submit a pull request.

## License
