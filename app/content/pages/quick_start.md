---
title: Quick Start
position: 2
---

## Installation
### Add the Gem
```bash
bundle add quicksilver_ui
```

### Install It
Add all dependencies to your Gemfile.

```bash
bin/rails generate quicksilver_ui:install
```

It also adds an initializer and [our base component](/components/base).

Restart your server

Now you can use [the built-in generators](/pages/generators).

```bash
$ bin/rails generate quicksilver_ui:component --help
Usage:
  rails generate quicksilver_ui:component NAME [options]

Options:
  [--skip-namespace]        # Skip namespace (affects only isolated engines)
                            # Default: false
  [--skip-collision-check]  # Skip collision check
                            # Default: false
  [--force]                 # Indicates when to generate force
                            # Default: false

Runtime options:
  -p, [--pretend], [--no-pretend], [--skip-pretend]  # Run but do not make any changes
  -q, [--quiet], [--no-quiet], [--skip-quiet]        # Suppress status output
  -s, [--skip], [--no-skip], [--skip-skip]           # Skip files that already exist

Generate a QuicksilverUI component into your application.

Available components:

  accordion
  alert
  avatar
  badge
  dropdown
  icon
  modal
```
