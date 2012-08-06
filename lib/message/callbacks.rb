module Message::Callbacks
  def self.included(base)
    base.class_eval do
      before_validation :foo
    end
  end

  def foo
    # ...
    puts "fooooo...."
  end
end