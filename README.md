# TOWA Code challenge

### Architecture
The app uses **MVVM** architecture 

[![mvvm-pattern.png](https://i.postimg.cc/gkRWFnyR/mvvm-pattern.png)](https://postimg.cc/QHXPcNyx)

Every viewcontroller will have a viewmodel. The **Viewmodel** will be reponsible for the business logic and will feed the data to the view. The **Viewcontroller** is just a view whereas it's only reponsibility is to render the data provided by the **ViewModel**. The **Model** is just a struct/class that represents the data that will be retrieved in the apis. The complete the binding between the **ViewModel** and **View** the app uses [RXSwift](https://github.com/ReactiveX/RxSwift) to bind and make the **ViewModel** data reactive so that the view will be notified of changes instantaneously.

# Libraries Used
- RxSwift
- RxCocoa
- SnapKit
- ObjectMapper
- R.swift
- Alamofire
- KeychainSwift
- CDAlertView
- RxMKMapView
- SkyFloatingLabelTextField
- FontAwesome.swift

# Unit Testing Libraries
- RxBlocking
- RxTest
- Quick
- Nimble

# Implementation

### R.swift

All resource are stored in R.swift

**R.swift** is a tool to get strong typed, autocompleted resources like images, fonts and segues in Swift projects.
- Never type string identifiers again
- Supports images, fonts, storyboards, nibs, segues, reuse identifiers and more
- Compile time checks and errors instead of runtime crashes


### Alamofire

Used as middleware

**Alamofire’s** Session is roughly equivalent in responsibility to the URLSession instance it maintains: it provides API to produce the various Request subclasses encapsulating different URLSessionTask subclasses, as well as encapsulating a variety of configuration applied to all Requests produced by the instance.

### KeychainSwift

User to store confidential data

**KeychainSwift** is a collection of helper functions for saving text and data in the Keychain. As you probably noticed Apple's keychain API is a bit verbose. This library was designed to provide shorter syntax for accomplishing a simple task: reading/writing text values for specified keys:

### Unit testing
### RxBlocking, RxTest, Quick, Nimble

**Rx** is a generic abstraction of computation expressed through Observable<Element> interface, which lets you broadcast and subscribe to values and other events from an Observable stream.

# APP Screens

[![Screen-Shot-2022-07-10-at-5-51-18-PM.png](https://i.postimg.cc/mDsPW0JN/Screen-Shot-2022-07-10-at-5-51-18-PM.png)](https://postimg.cc/WD5NMf2h)

# Unit Test Result

[![Screen-Shot-2022-07-10-at-5-30-31-PM.png](https://i.postimg.cc/qRBYN7Cm/Screen-Shot-2022-07-10-at-5-30-31-PM.png)](https://postimg.cc/t1fDfpkP)