# [iOS] ULesson

### About ###

Language: Swift
Deployment Target: iOS 15.0
Devices: iPhone

### How to install and run ###

1. Clone the project and open in XCode.
2. To build and run click 'Run' button on top bar in XCode (works only on simulator).
3. To run on device you need to get access to Apple account from client.

### Run by Bitrise ###

1. Login to Bitrise.
2. In menu on the right choose [iOS] ULessons app.
3. Click 'Start/Schedule a Build' button.
4. In 'Branch' field type "main"; In workflow choose 'Development_Deploy'.
5. The mail with new version of app will be send to emails that are defined in 'Team' tab.

### Architecture ###

CoreData based MVVM by Benjamin Acquah

**MVVM** (Model -View-ViewModel) is derived from MVC (Model-View-Controller). The idea behind MVVM pattern is that each View is backed by a ViewModel that represents the data for the view. 

**Model** - structure that stores specific information (data) in the simplest of formats. It can be transform by ViewModel.

**View** - It refers to all the object that are used to build a user interface. It is UIView, UITextField, UIButton etc. It refers also UIViewController that manages views and their lifecycle. In this project we do not use .xib and .nib files so we create Builder for each ViewController.

**ViewModel** - it sits between the Model and View/ViewController. The ViewModel converts data in the model intro human readable format that can be presented in the View by the ViewController. The ViewModel could also handle updates that users make to data presented by the View/ViewController. Updates to View data would not go directly to Model, rather they would be triggered by the ViewController talking to the ViewModel which would then talk to the Model.

**Builder** - it creates all views in ViewController. It contents all methods that are used to create views and constraints between views.

**Api router** - it is responsible for sending requests  and get response from API

**Repository** - intercepts data from api router or database. ViewModel can get this data. Repository is mediator between api router and view model.

### Networking, libraries, dependency managing ###

- AlamofireImage
- Alamofire

