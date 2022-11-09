#  SimpleEstimate

This app was inspired by the business I own and run. Keeping track of my clients, their invoices, and new bids/estimates could get messy real quick. Paper and pencil are hard to keep track of but using something like MS Excel on your mobile phone can be difficult to navigate all the cells on such a small screen. Simple Estimate has helped streamline making estimates for clients and storing that information in a user friendly way.

<img width="681" alt="AllScreens" src="https://user-images.githubusercontent.com/109991327/200639853-57f5b464-2c36-4973-963a-9ebffcc07614.png">

Link to App Store: https://apps.apple.com/us/app/simple-estimate/id6443957682

One of the more challenging things I faced with this app wasn't in any big features but in the small, less noticable UX. I used CoreData to persist all my data and there are times in the app when a user might not want that data to be saved or altered. In order for the app to behave correctly, I needed the information stored in the CoreData model to only be saved when told to. Otherwise, that data would be cleared out to avoid persisting unnecessary info or changes.
