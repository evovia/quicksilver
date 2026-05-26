---
title: Combobox
description: Useful for searching - in sync or async
position: 12
---

This component can be used in two modes, depending on how you feed it choices.

# Async Mode
When you give a combobox a URL, it will assume that this URL returns search results. All filtering must be done server side and a `turbo_stream` update on `params[:frame_id]` must be returned. There is a component, `Form::Combobox::AsyncSearchResult`, that renders the result in a similar way to the sync version, but you can return anything as the situation requires it.

```html
<%= form.combobox :user_ids,
  users_path,
  selected: some_user,
  multiple: true
```

```ruby
<%= turbo_stream.update params[:frame_id],
  renderable: Form::Combobox::AsyncSearchResult.new(
  results: @users,
  text_method: ->(user) { "#{user.name} (#{user.email})" }
) %>

```

# Sync Mode
When given an Array of objects, the combobox filters them client side in JavaScript.
