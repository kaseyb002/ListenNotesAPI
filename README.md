# ListenNotesAPI
ListenNotesAPI lets you search podcasts easily. This is a Swift wrapper for accessing the ListenNotesAPI.

## Example

```swift
ListenNotesAPI.searchPodcasts(withText: "star wars") { result in
    switch result {
    case .success(let searchResults):
        searchResults.podcasts.forEach { podcast in
            print(podcast.title)
        }
    case .failure(let error):
        print(error.message)
    }
}
```

## Getting Started

#### Cocoapods


#### Set API Key
First you must set your ListenNotes API Key: 

```swift
ListenNotesAPI.Config.set(apiKey: "YOUR_API_KEY")
``` 
