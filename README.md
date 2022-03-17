# tokr-realm-ios-example
A quick example of displaying rNFTs in iOS

# Setup

This demo makes use of [Web3Auth's](https://web3auth.io/) OpenLogin SDK. To run the demo you'll first need to setup a developer account in their system [here](https://dashboard.web3auth.io/). Once your account is setup click the "Plug and Play" link on the left side of the page and create a project. Make note of the Client ID you'll need that in a second.

In the dashboard for the new project you'll need to add a redirect url. For now just add "com.rhove.RNFTDemo://auth". This is needed to handle the redirects from the Web3Auth in-app browser that is launched during user authentication.

Head back over to the directory that you've cloned the project in and navigate to "RNFTDemo -> RNFTDemo -> Supporting Files". Duplicate the "Debug.xcconfig.template" file and rename it to "Debug.xcconfig". Open this file and replace "YOUR_OPEN_LOGIN_CLIENT_ID" with the client id for the project you just created.

<img width="921" alt="xcconfig" src="https://user-images.githubusercontent.com/282512/158829714-a21e7323-c902-470b-8be6-c04bbd542b67.png">
<figcaption align="center"><b>Fig.1 - Duplicate and Rename XCConfig Files</b></figcaption>

<img width="925" alt="debug-xcconfig" src="https://user-images.githubusercontent.com/282512/158829762-666e5a1f-cfd3-48d2-80f0-46460d3b5e3a.png">
<figcaption align="center"><b>Fig.2 - Replace Open Auth Client ID</b></figcaption>
