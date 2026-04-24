---
name: Button
description: You need buttons in your app. This is how you get them.
published_at: 2026-04-17 11:59:15 UTC
---

Buttons already exist in HTML, so let's not make a component for them. Instead we use [affordances](https://fractaledmind.com/2025/12/01/ui-affordances/) to make it simple to style them.

```ruby
  button class: "ui-button ui-button-primary" do
    "Click me!"
  end
```

<button class="ui-button ui-button-primary">
  Click me!
</button>

One of the upsides of affordances is, that we can now style other things as buttons as well. You want a link, that looks like a button? You got it.

```ruby
  a href: "#", class: "ui-button ui-button-primary" do
    "Click me!"
  end
```

<a href="#" class="ui-button ui-button-primary">
  Click me!
</a>

What about a submit input? No problem.

```ruby
  input value: "Click me!",
    type: "submit",
    class: "ui-button ui-button-primary"
```

<input type="submit" value="Click me!" class="ui-button ui-button-primary"></input>


It all looks the same and it is easy to reason about.
