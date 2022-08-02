# Disney Streaming Take-Home

Welcome to the Disney Streaming take-home interview!

Check out the [prompt](PROMPT.md) to get started.

## README Questions:

The following are some sample questions for you to get started on your README, but feel free to format it in any way you see fit.

1. Describe any important assumptions that you have made in your code.
1. What edge cases have you considered in your code? What edge cases have you yet to handle?
1. What are some things you would like to do if you had more time? Is there anything you would have to change about the design of your current code to do these things? Give a rough outline of how you might implement these ideas.

## Assumptions

1. I decided to use the given base project and json format to keep things easier.
2. The flow of the app is meant to only support what was described in [Product Requirements](PROMPT.md#product-requirements). After seen the ESPN screen you won't be able to go back to the Disney screen by shaking the device. You'll need to restart the server to serve the disney json and restart the app.
3. I noticed the UI elements were not equally spaced in the vertical axis, so I thought using a stack would be more complex than using auto layout.
4. I am assuming the order of the components array in the json response will mandate the order in which the components should be laid out.
5. I added the provided images into an xcassets catalog for displaying them easily. In real life I would have to make another request to actually retrive the images, which means a placeholder image would be required while all the assets load, or maybe not even that and just a loading spinner would suffice. This would probably be a decision that should be made in conjunction with UX, Product and Backend to understand latency and reasonable loading times.

## Architecture

## Dependency Injection

## UI

## Unit Tests

## Enhancements

### Decrease loading times by caching json responses and/or assets. 

This depends on what Product and Business want to support, several scenarios come to mind:
- Screen layout is fixed -> we could cache the PaywallLayout locally on device using CoreData or other database system. Storing the json object in UserDefaults could also work, but then we would need to decode it everytime, which can be time consuming.
- Assets don't change -> we could cache the images either in memory for the duration of a session to avoid filling up the device's storage.
- Screen layout and assets change too often -> continue to request for this data in an adhoc fashion, as done in this example, and avoid caching

### Better support high latency requests

Because we are serving the images on a local server, reloading data is relatively fast, however, this may not always be the case for all users. I would define strategies and flows for tipycal slow scenarios to provide a better user experience:

1. Loading spinner: show a spinner to indicate to the user that data is being fetched, limit this to a few seconds and if not successful try again in the background and provide the new screens the next time the user hits the trigger
2. Placeholder images: request for data is two fold, i.e fetching json and image assets. We may be able to present and "incomplete" experience with minimal information and provide placeholders for assets that have yet to be downloaded.
3. Caching mechanisms: depends on the decision made on the previous enhancement

### More testing

I added a simple set of unit tests for verifying that the view model is working as expected. I decided not to create a test for each method in the view model because they pretty much follow the same pattern.

I did not add an UI Tests, but it would be interesting to update the code to support accessibilityIdentifier and use them to verify the UI hierarchy.

### Localization support

Right now all elements are using a center alignment, which is easy to implement. However, in real life we may need to consider LTR and RTL languages as well as semantics.

Tipically I would create a Localization.strings file for each supported language, and inside define key value pairs for each string used in the application, however, since we receiving the information from a server, there is a chance we might be able to receive localized content directly from the backend, in which case there would be no need to use .strings files.

### Security

These paywalls seem to indicate that the user is not currently authenticated, in which case we would only need to sign the requests with some app generated token or similar to authenticate the request in the backend.

Right now the endpoint used to retrieve the data is hardcoded into the PaywallService class, however, we should protect at least the host and port on the URL with some sort of encription. I would create a secrets module where we can safely store encripted information that can later be accessed from our clients.

### Robust service (REST)

Right now the provided server needs to be restarted in order to provide parameterized assets. I would instead use a service that takes a parameter `type` to decide which assets to return.
