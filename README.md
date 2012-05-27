# Css Builder

A ruby interface for creating CSS files; LESS and SASS planned;

## Installation

    gem install css_builder

## Usage

```ruby
require "css_builder"
css = CssBuilder.new

css.div(:id => "hello", :class => "world") {
  color "green"
  background_color "blue"
}

css.table([], [:tag => "tr"], [:tag => "td", :nth_child => "odd"]) do
  border "1px #345 solid"
  background_color "#efefef"
end

css.comment! "This is a magical momment"

css.value! # outputs =>
```
```css
div#hello.world {
  color : green;
  background-color : blue;
}

table tr td:nth-child(odd) {
  border : 1px #345 solid;
  background-color : #efefef;
}

/* This is a magical momment */
```
```ruby
###

css = CssBuilder.new

css.class!("astro", [], [:class => "stars", :nth_child => 2]) {
  color "green"
  background_color "blue"
}

css.value! # outputs =>
```
```css
.astro .stars:nth-child(2) {
  color : green;
  background-color : blue;
}
```
```ruby
###

css = CssBuilder.new

css.id!("bears", [:class => "grizzly"], [:class => "claws", :hover => nil]) {
  background_color "red"
  font_family "Sharp"
}

css.value! # outputs =>
```
```css
#bears.grizzly .claws:hover() {
  background-color : red;
  font-family : Sharp;
}
```
```ruby
###

css = CssBuilder.new

css.div([], [:selector => "~"], [:tag => "span"]) {
  border "1px"
}

css.value! # outputs =>
```
```css
div ~ span {
  border : 1px;
}
```

## LESS support

The LESS templating language has limited support right now. You can use it in the following way.

    ###

    css = CssBuilder.new

    css.div {
      font_size "1.2em"
      class!("roger") {
        color "green"
      }
      a {
        text_decoration "none"
        self.&(:hover => nil) {
          color "#333"
        } 
      }
    }

    css.value! # outputs =>

    div {
      font-size : 1.2em;
      .roger {
        color : "green";
      }
      a {
        text-decoration : "none";
        &:hover() {
          color : "#333";
        }
      }
    }

Variables

    ###

    css = CssBuilder.new

    @css.variable!("color", "#4D926F")

    @css.id!("header") {
      color variable!("color")
    }

    css.value! # outputs =>

    @color: #4D926F;

    #header {
      color: @color;
    }

Mixins

    ###

    css = CssBuilder.new

    @css.mixin!("rounded-corners", ["radius", "5px"]) {
      border_radius variable!("radius")
      _webkit_border_radius variable!("radius")
      _moz_border_radius variable!("radius")
    }

    @css.id!("header") {
      mixin! "rounded-corners"
    }

    @css.id!("footer") {
      mixin!("rounded-corners", "10px")
    }

    css.value! # outputs =>

    .rounded-corners (@radius: 5px) {
      border-radius: @radius;
      -webkit-border-radius: @radius;
      -moz-border-radius: @radius;
    }

    #header {
      .rounded-corners;
    }
    #footer {
      .rounded-corners(10px);
    }

## Contributing to css_builder
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Justin Derrek Van Eaton. See LICENSE.txt for
further details.

