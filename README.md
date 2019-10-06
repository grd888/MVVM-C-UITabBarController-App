# A UITabBarController-based reference app using the MVVM-C design pattern

I created this app to document my take on how to apply the Model-View-ViewModel and Coordinator (MVVM-C) design patterns within UITabBarController-based apps.

## A few things to note in this app

- It doesn't use storyboards, everything is done in code with Autolayout
- It uses Dependency Injection to inject View Controller dependencies, starting with View Models
- View Controller navigation is done in the Coordinators.

I'm releasing this as Open Source so feel free to use the code in your own projects if you find it useful.
