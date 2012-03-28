# Css Builder

A ruby interface for creating CSS files; LESS and SASS planned;

## Installation

    gem install css_builder

## Usage

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

    div#hello.world {
      color : green;
      background-color : blue;
    }

    table tr td:nth-child(odd) {
      border : 1px #345 solid;
      background-color : #efefef;
    }

    /* This is a magical momment */

    ###

    css = CssBuilder.new

    css.class!("astro", [], [:class => "stars", :nth_child => 2]) {
      color "green"
      background_color "blue"
    }

    css.value! # outputs =>

    .astro .stars:nth-child(2) {
      color : green;
      background-color : blue;
    }

    ###

    css = CssBuilder.new

    css.id!("bears", [:class => "grizzly"], [:class => "claws", :hover => nil]) {
      background_color "red"
      font_family "Sharp"
    }

    css.value! # outputs =>

    #bears.grizzly .claws:hover() {
      background-color : red;
      font-family : Sharp;
    }

    ###

    css = CssBuilder.new

    css.div([], [:selector => "~"], [:tag => "span"]) {
      border "1px"
    }

    css.value! # outputs =>

    div ~ span {
      border : 1px;
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

