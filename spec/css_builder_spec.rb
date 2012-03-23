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

  end

  describe "Classes" do 

    it "can create a simple css class block" do
      @css.class!("theMan") {}
      @css.value!.should match /^.theMan\s+\{\s+\}/
    end

    it "can create a css class block with an additional class" do
      @css.class!("henry-theGreat", :class => "sauce") {}
      @css.value!.should match /^.henry-theGreat\.sauce\s+\{\s+\}/
    end

    it "can create a css class block with an additional classes by spaces" do
      @css.class!(" henry theGreat-is  not so great  ") {}
      @css.value!.should match /^.henry\.theGreat-is\.not\.so\.great\s+\{\s+\}/
    end

    it "can create a css class block with a class and a child ID and class selector" do
      @css.class!("magic", [:class => "sauce"], [:id => "RED", :class => "tasty"]) {}
      @css.value!.should match /^.magic\.sauce\s+#RED\.tasty\s+\{\s+\}/
    end

    it "can create a css class block with a class and a child class with a psuedo selector" do
      @css.class!("magic", [:class => "sauce"], [:class => "tasty", :hover => nil]) {}
      @css.value!.should match /^.magic\.sauce\s+\.tasty:hover\(\)\s+\{\s+\}/
    end

    it "can create a css class block with a class and a child class with a psuedo selector with params" do
      @css.id!("the_magic", [:class => "sauce"], [:class => "tasty", :nth_child => 2]) {}
      @css.value!.should match /^.the-magic\.sauce\s+\.tasty:nth-child\(2\)\s+\{\s+\}/
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

  end

end
