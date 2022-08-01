# Designing a Paywall System

A paywall is a screen that is presented to users to sell them access to our content. Our product team wants to be able to make updates to the content, layout, and product offerings of our paywalls **without making new releases of our apps**. Your goal is to implement a system that will let them render the paywalls of their dreams.

## Product Requirements
- Your paywall system should have the capacity to render **at least** the layouts for the following two example paywalls:

Disney+ | ESPN+
---- | ----
![Disney+](disney_paywall.png) | ![ESPN+](espn_paywall.png)

  - We are providing you with the image assets that you see in the paywall images above. Those assets are optimized for an iPhone 11. Your paywall should render on all iOS devices, but we will be evaluating how it looks on an iPhone 11.
  - You are given an incomplete example of a paywall response in _scripts/disney/response.json_. This JSON generates a subset of the Disney+ paywall seen above. You can use this JSON and expand it as needed, or choose to create an entirely different schema instead. What's here is intended to help you, but it does not restrict you.
- Your paywall should handle user input (tapping the buttons).
  - When a user taps one of the log in buttons, your application should present an alert with the message: `"Log In"`.
  - When a user taps one of the purchase buttons, your application should present an alert with the message: `"Purchase: \(sku)"`.
    - The SKU, a string that represents the asset being purchased, should be remotely configurable. For Disney+ use the SKU `"dplus_free_trial"` and for ESPN+ use the SKU `"eplus_free_trial"`.
- You should be able to render both paywall screens without restarting the app. The flow should work like this:
  - Start the [server](#serving-the-paywalls) to serve the Disney+ paywall: `sh scripts/serve.sh disney`.
  - Run the application.
  - See the Disney+ paywall.
  - Kill the server.
  - Restart the server to serve the ESPN+ paywall: `sh scripts/serve.sh espn`.
  - Shake the device.
  - See the ESPN+ paywall.
  - **Note:** Make sure that your `URLRequest` to fetch the JSON ignores the cache to avoid seeing stale data in the paywalls. We have provided `URLSession.paywall` for you as one option for achieving this.
- Your screen should render using native UIKit or SwiftUI components (i.e., not a web view).

## Xcode Project

- We have provided an Xcode project to get you started. Nothing in the starter template is designed to limit your choices. You are encouraged to change any and all of the template code. It is **not** required that you use this template. If you prefer to set up your own project from scratch, please do so.
- The starter project has code set up to handle the shake gesture, disable ATS, and ignore cached responses during networking. We hope this makes it a little bit easier for you to get started quickly.
- You should feel free to submit a solution using UIKit or SwiftUI. In the starter template we provide boilerplate for either approach. In the `SceneDelegate` you can switch between the two by changing the `useUIKit` constant, but you can also choose to delete the code for the UI framework you decide not to use.
- If you decide to make a brand new Xcode project, be sure to add the _scripts_ folder and _README.md_ to the project so that we can easily read your JSON files and README.

## Submission Requirements
- Add a Git repository and use it to make commits while you work.
- There is a [README](README.md) template with questions for you to answer about your submission.
- You should submit a ZIP file with your entire Git repository.

## Timing
- We want to respect your time and we ask that you please try to spend around 2 hours to complete your submission. You will not be penalized if you spend more or less time on this project.
- We are more interested in seeing you write good, clear code than seeing you "finish" the exercise.
- Focus on the requirements you think are the most important. Document the unfinished parts of your project in the README.
- We **will** review your code.
- This submission will be used to determine if you should move forward to an on-site interview.
- We understand that 2 hours is probably not enough time to finish the requirements laid out in this document. If you are extended an on-site interview, you will pair with our team members to work on your submission further. You can expect this code to be discussed and expanded on during the interview.

## Serving the Paywalls

We've provided a [script](scripts/serve.sh) to get a file server running. This script requires Python (version 2 comes installed on your Mac but the script supports version 2 or 3).

If you prefer to run some other file server feel free to do so, but it should serve either the `scripts/espn` or `scripts/disney` folders at `localhost:8000`. To run the script, call `sh serve.sh disney` or `sh serve.sh espn` which will serve the _disney_ or _espn_ folders, respectively.
