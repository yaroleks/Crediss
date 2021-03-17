# General
This application requires: 
- A workstation with MacOS installed
- Xcode 12+ (the app was designed on Xcode 12.3)
- Cocoapods last version installed
- Running server



## Instructions
1. Install the latest Xcode from the Appstore, or start already installed XCode 12+ on your computer
2. Install Cocoapods on your MacOS with the command `sudo gem install cocoapods`
    - If you don't have `gem` installed on your computer:
    - Install gem with Homebrew - write in the treminal: `brew install ruby`
    - If you don't have Homebrew installed - write in the treminal :  `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
3. From terminal, use `cd` command to navigate into Credis folder on your computer, and from the terminal: `pod install`. Now you should open a file .xcworkspace from your project folder.

    ![Alt text](xcworkspace.png?raw=true)

4. Run the server locally with the command `sbt run`

5. In Xcode, select a device e.g. iPhone 12 Pro 

    ![Alt text](deviceSelection.png?raw=true)
    

6. Run the project with Cmd+R



## Notes

- Added a feature to remove User with swiping to the left.
- The production app should have used **Coordinator** pattern responsible for moving between screen as it's one of the Best iOS devleopment practices.
- Another Best practice is to inject dependencies with **Dependenty Injection** mechanism, so the classes may be tested more effectively with Unit tests.



