# tokr-realm-ios-example
A quick example of displaying rNFTs in iOS

# Setup

This demo makes use of [Web3Auth's](https://web3auth.io/) OpenLogin SDK. To run the demo you'll first need to setup a developer account in their system [here](https://dashboard.web3auth.io/). Once your account is setup click the "Plug and Play" link on the left side of the page and create a project. Make note of the Client ID you'll need that in a second.

In the dashboard for the new project you'll need to add a redirect url. For now just add "com.rhove.RNFTDemo://auth". This is needed to handle the redirects from the Web3Auth in-app browser that is launched during user authentication.

Head back over to the directory that you've cloned the project in and navigate to "RNFTDemo -> RNFTDemo -> Supporting Files". Duplicate the "Debug.xcconfig.template" file and rename it to "Debug.xcconfig". Open this file and replace "YOUR_OPEN_LOGIN_CLIENT_ID" with the client id for the project you just created.
