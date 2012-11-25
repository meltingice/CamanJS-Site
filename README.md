# CamanJS Site

**This is a new version of the site that is currently only deployed at [dev.camanjs.com](http://dev.camanjs.com).**

## Development

The CamanJS website is powered by Jekyll. You'll need Ruby and Rubygems to get started.

In order to get code highlighting to work, you'll need to have Python and Pygments installed.

```
sudo easy_install pygments
```

When you're ready, in the base directory run:

```
bundle install
bundle exec foreman start
```

The site will be available at http://localhost:4000 and changes will automatically recompile.