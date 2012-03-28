class CssBuilder

  def initialize
    @css = ''
  end

  def value!
    @css
  end

  def comment!(comment)
    css! "/* #{comment} */"
    _newline
    _newline
    @css
  end

  def id!(*args, &block)
    _start_tag("##{args[0]}", *args[1..-1], &block)
    @css
  end

  def class!(*args, &block)
    _start_tag(_class(args[0]), *args[1..-1], &block)
    @css
  end

  def method_missing(m, *args, &block)

    if block
      _start_tag(m, *args, &block)
    else
      _indent
      css! _dasherize m
      css! " : #{args.first};"
      _newline
    end
   
    @css
  end

private

  def _start_tag(value, *args, &block)
    css! _dasherize(value)

    _args_tag_values(args)

    _open
    _newline 

    self.instance_eval(&block)

    _close
    _newline
    _newline
  end

  def css!(val)
    @css << val
  end

  def _newline
    css! "\n"
  end

  def _close
    css! "}"
  end

  def _open
    css! " {"
  end

  def _indent
    css! "  "
  end

  def _class(v)
    ".#{v.strip.gsub(/\s+/, '.')}"
  end

  def _dasherize(v)
    v.to_s.gsub(/_/, '-')
  end

  def _args_tag_values(args)
    args.each do |arg|
      case arg
      when ::Array
        _args_tag_values(arg)
        css! " "
      when ::Hash
        _args_hash_values(arg)
      else
      end
    end
  end

  def _args_hash_values(hash)
    if hash.has_key?(:selector)
      css! hash.delete(:selector)
    end
    css! _dasherize hash.delete(:tag) if hash.has_key?(:tag)
    css! "##{hash.delete(:id)}" if hash.has_key?(:id)
    css! _class(hash.delete(:class)) if hash.has_key?(:class)
    hash.each do |k,v|
      css! ":#{_dasherize k}(#{v})"
    end
  end

end
