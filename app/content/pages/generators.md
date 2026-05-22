---
title: Generators
position: 5
---

Everything in Quicksilver is yours to keep. To make it simple to use, the gem provides generators for every affordance, component, and form element.
Some components have dependencies on other components, Stimulus controllers or stylesheets. Generating one such component will also generate their dependencies. For instance, generating [the Modal component](/components/modal), will generate all these files:

```bash
$ bin/rails g quicksilver_ui:component Modal
Generating Modal component...
      create  app/views/ui/modal.rb
      create  app/views/ui/icon.rb
      create  app/assets/tailwind/modal.css
  Added import for modal.css to application.css
      create  app/javascript/controllers/modal_controller.js
```
