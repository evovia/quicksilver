---
title: Overview
position: 1
---

The main way users interact with web apps is through forms. Rails already have some pretty neat helpers for these forms, but they often become boiler-plate heavy - especially when using Tailwind. There have been several attempts to solve this (like [simple_form](https://github.com/heartcombo/simple_form)), and that works great. But Rails already comes with a `FormBuilder` class, so why not just use this? We were inspired by/stole from [Brand New Box's form builders](https://github.com/brandnewbox/app-form-builder), when we built our own.

Under the hood, everything is still Phlex components, but we now have a common interface that is familiar to anyone who have used Rails' form builders before. Furthermore, it is very easy to extend the form builder and add new methods to render more complex things, like our [`Group`](/forms/group/) component.

We added a new helper, `app_form_with`, as it makes it easier, if we have to opt out of using the custom form builder.
