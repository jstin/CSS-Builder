require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "CssBuilder" do
  
  before :each do
    @css = CssBuilder.new
  end
  
  describe "Comments" do 

    it "can create a css comment" do
      @css.comment! "This is a dumb comment"
      @css.value!.should match /\/\*\s+This is a dumb comment\s+\*\/$/
    end

  end

  describe "ID's" do 

    it "can create a simple css ID block" do
      @css.id!("Magic") {}
      @css.value!.should match /^#Magic\s+\{\s+\}/
    end

    it "can create a css ID block with a class" do
      @css.id!("magic", :class => "sauce") {}
      @css.value!.should match /^#magic\.sauce\s+\{\s+\}/
    end

    it "can create a css ID block with a class and a child class selector" do
      @css.id!("magic", [:class => "sauce"], [:class => "tasty"]) {}
      @css.value!.should match /^#magic\.sauce\s+\.tasty\s+\{\s+\}/
    end

    it "can create a css ID block with a classes and a child class with a psuedo selector" do
      @css.id!("magic", [:class => "hot sauce"], [:class => "tasty", :hover => nil]) {}
      @css.value!.should match /^#magic\.hot\.sauce\s+\.tasty:hover\(\)\s+\{\s+\}/
    end

    it "can create a css ID block with a class and a child class with a psuedo selector with params" do
      @css.id!("the_magic", [:class => "sauce"], [:class => "tasty", :nth_child => 2]) {}
      @css.value!.should match /^#the-magic\.sauce\s+\.tasty:nth-child\(2\)\s+\{\s+\}/
    end

    it "can create a css ID block tag sub-selector" do
      @css.id!("the_magic", [:class => "sauce"], [:class => "word", :tag => "div"]) {}
      @css.value!.should match /^#the-magic\.sauce\s+div\.word\s+\{\s+\}/
    end

  end

  describe "Classes" do 

    it "can create a simple css class block" do
      @css.class!("theMan") {}
      @css.value!.should match /^\.theMan\s+\{\s+\}/
    end

    it "can create a css class block with an additional class" do
      @css.class!("henry-theGreat", :class => "sauce") {}
      @css.value!.should match /^\.henry-theGreat\.sauce\s+\{\s+\}/
    end

    it "can create a css class block with an additional classes by spaces" do
      @css.class!(" henry theGreat-is  not so great  ") {}
      @css.value!.should match /^\.henry\.theGreat-is\.not\.so\.great\s+\{\s+\}/
    end

    it "can create a css class block with a class and a child ID and class selector" do
      @css.class!("magic", [:class => "sauce"], [:id => "RED", :class => "tasty"]) {}
      @css.value!.should match /^\.magic\.sauce\s+#RED\.tasty\s+\{\s+\}/
    end

    it "can create a css class block with a class and a child class with a psuedo selector" do
      @css.class!("magic", [:class => "sauce"], [:class => "tasty", :hover => nil]) {}
      @css.value!.should match /^\.magic\.sauce\s+\.tasty:hover\(\)\s+\{\s+\}/
    end

    it "can create a css class block with a class and a child class with a psuedo selector with params" do
      @css.class!("the_magic", [:class => "sauce"], [:class => "tasty", :nth_child => 2]) {}
      @css.value!.should match /^\.the-magic\.sauce\s+\.tasty:nth-child\(2\)\s+\{\s+\}/
    end

    it "can create a css class block tag sub-selector" do
      @css.class!("water", [:class => "melon"], [:class => "alls", :tag => "section"]) {}
      @css.value!.should match /^\.water\.melon\s+section\.alls\s+\{\s+\}/
    end

    it "can create a css class block with css3 sub-selectors" do
      @css.class!("food", [], [:selector => ">"], [:tag => "div"]) {}
      @css.value!.should match /^\.food\s+>\s+div\s+\{\s+\}/
    end

  end

  describe "Tags" do 

    it "can create a simple css tag block" do
      @css.h1 {}
      @css.value!.should match /^h1\s+\{\s+\}/
    end

    it "can create a css tag block with an additional class" do
      @css.table(:class => "henry-theGreat") {}
      @css.value!.should match /^table.henry-theGreat\s+\{\s+\}/
    end

    it "can create a css tag block with an additional class and ID" do
      @css.span(:id => "zing", :class => "henry-theGreat") {}
      @css.value!.should match /^span#zing.henry-theGreat\s+\{\s+\}/
    end

    it "can create a css tag block with an additional classes by spaces and child id selector" do
      @css.div([:class => " henry theGreat-is  not so great  "], [:id => "trees"]) {}
      @css.value!.should match /^div.henry\.theGreat-is\.not\.so\.great\s+#trees\s+\{\s+\}/
    end

    it "can create a css tag block with many child selectors" do
      @css.tr([:class => "one"], [:class => "two"], [:class => "three"], [:class => "four"]) {}
      @css.value!.should match /^tr.one\s+\.two\s+\.three\s+\.four\s+\{\s+\}/
    end

    it "can create a css tag block with no class and many child selectors" do
      @css.td([], [:class => "two"], [:class => "three"], [:class => "four"]) {}
      @css.value!.should match /^td\s+\.two\s+\.three\s+\.four\s+\{\s+\}/
    end

    it "can create a css tag block with a psuedo selector" do
      @css.a(:hover => nil) {}
      @css.value!.should match /^a:hover\(\)\s+\{\s+\}/
    end

    it "can create a css tag block tag sub-selectors" do
      @css.table([], [:tag => "tr"], [:class => "overalls", :tag => "td"]) {}
      @css.value!.should match /^table\s+tr\s+td\.overalls\s+\{\s+\}/
    end

    it "can create a css tag block with css3 sub-selectors" do
      @css.table([], [:selector => "~"], [:tag => "td"]) {}
      @css.value!.should match /^table\s+~\s+td\s+\{\s+\}/
    end

  end

  describe "Blocks" do 

    it "can have a single css attribute" do
      @css.p {
        color "red"
      }
      @css.value!.should match /^p\s+\{\s+color\s+:\s+red;\s+\}/
    end

    it "can have css attributes" do
      @css.h1 {
        color "#438"
        font_size "10em"
        border "0px green solid"
      }
      @css.value!.should match /^h1\s+\{\s+color\s+:\s+#438;\s+font-size\s+:\s+10em;\s+border\s+:\s+0px\s+green\s+solid;\s+\}/
    end

    it "can have css attributes and many selectors" do
      @css.body([], [:tag => 'p'], [:tag => 'span']) {
        background_image "url('http://magical.mystery.code.com/placeholder.image')"
      }
      @css.value!.should match /^body\s+p\s+span\s+\{\s+background-image\s+:\s+url\('http:\/\/magical.mystery.code.com\/placeholder.image'\);\s+\}/
    end

  end

  describe "LESS" do 

    it "can create and set variables" do
      @css.variable!("color", "#4D926F")

      @css.id!("header") {
        color variable!("color")
      }
      @css.value!.should match /^@color\s+:\s+#4D926F;\s+#header\s+\{\s+color\s+:\s+@color;\s+\}/
    end

    it "can create and use mixins" do
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

      @css.value!.should match /^\.rounded-corners\s+\(@radius:\s+5px\)\s+{\s+border-radius\s+:\s+@radius;\s+-webkit-border-radius\s+:\s+@radius;\s+-moz-border-radius\s+:\s+@radius;\s+}\s+#header\s+{\s+\.rounded-corners;\s+}\s+#footer\s+{\s+\.rounded-corners\s+\(10px\);\s+}/
    end

    it "can create and use mixins many params" do
      @css.mixin!("rounded-corners", ["radius", "5px"], ["color", "red"]) {
        border_radius variable!("radius")
      }

      @css.id!("footer") {
        mixin!("rounded-corners", "10px", "green")
      }

      @css.value!.should match /^\.rounded-corners\s+\(@radius:\s+5px,\s+@color:\s+red\)\s+{\s+border-radius\s+:\s+@radius;\s+}\s+#footer\s+{\s+\.rounded-corners\s+\(10px,\s+green\);\s+}/
    end

    it "can create and use mixins no defualt" do
      @css.mixin!("rounded-corners", ["radius"]) {
        border_radius variable!("radius")
      }

      @css.value!.should match /^\.rounded-corners\s+\(@radius\)\s+{\s+border-radius\s+:\s+@radius;\s+}/
    end

    it "can create and use mixins empty" do
      @css.mixin!("rounded-corners", []) {
        border_radius variable!("radius")
      }

      @css.value!.should match /^\.rounded-corners\s+\(\)\s+{\s+border-radius\s+:\s+@radius;\s+}/
    end

  end

end
