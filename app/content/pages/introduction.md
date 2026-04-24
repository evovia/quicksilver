---
title: Introduction
---

## Why have you done this?
At [Evovia](https://www.evovia.com/) we are currently revamping the UI/UX of the site heavily. It is a Rails app, which had the first commit made on the 8th of August, 2014 and much of the front end has not been changed since then. The app was built with Bootstrap 4 alpha (not 4.0) and changing this has been hard, as there were many breaking changes between the alpha version and the actual release.

The app has grown a lot in the past 12 years. We do not want to redo the whole app and then release it at once - we want to update it bit by bit. But not all changes will be contained to a single page. Some partials or components are rendered in multiple places and contexts, but we cannot break existing pages or make them look too weird.

## The solution - Tailwind, Phlex and affordances
Write about this at length

## Why not ViewComponent
No caching, but feature complete

## Prior art and inspiration
[RubyUI](https://www.rubyui.com/)
[GitHub's ViewComponent](https://viewcomponent.org/)
[Rails Designer's UI components](https://railsdesigner.com/components/)
[app-form-builder by Brand New Box](https://github.com/brandnewbox/app-form-builder) 
[Stephen Margheim's blog](https://fractaledmind.com/posts/)
