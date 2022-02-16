#  An example of the core concepts of iOS development

This is a simple three screen application.  One screen allows you to view all the noaa weather regions in the country. You can add these weather stations to the favorite screen.  From the favorite screen you can select a weather region to see the latest weather disucussion. 

**Although simple the app covers the following concepts of iOS development:**

* the MVVM pattern
* view controllers and their lifecycle
* the view hierarchy
* basics of Auto Layout
* communication between view controllers and delegates
* protocols
* REST API calls 
* correct use of background thread(for network calls) and main thread(to update ui)
* weak references to avoid strong reference cycles

**Future improvments:**

* Use API call to get list of cities and abbreviations and deleted hard coding of said data
* Use location to get your current location's weather discussion
