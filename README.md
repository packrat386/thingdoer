# Thingdoer

Have you ever wanted to just do the thing? Now you can.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'thingdoer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thingdoer

## Usage

The gem is used for doing things. If you have an object that supports on of our doable methods then this can help you do them.
```ruby
irb(main):001:0> ThingDoer::DOABLE
=> [:do, :do_it, :start, :execute, :run, :main, :call]
```

Let say we have a class that supports one of our doable methods as well as some other methods
```ruby
class Foo
  def run(arg)
    puts "run with #{arg}"
  end

  def bar(arg)
    puts "bar with #{arg}"
  end  
end
```

We can use `ThingDoer::do_the_thing` to do the thing *that we're obviously trying to do*
```
irb(main):014:0> f = Foo.new
=> #<Foo:0x007f484d363a70>
irb(main):015:0> f.run("an argument")
run with an argument
=> nil
irb(main):016:0> ThingDoer::do_the_thing(f, "thingdoer")
run with thingdoer
=> nil
```

We can also encapsulate our object in a `ThingDoer::Thing` to facilitate doing the thing. Can't remember which doable method you used? Don't worry, all of them will work.
```
irb(main):018:0> thing = ThingDoer::Thing.new(f)
=> #<ThingDoer::Thing:0x007f484d33ea90 @thing=#<Foo:0x007f484d363a70>>
irb(main):019:0> thing.call("passes through")
run with passes through
=> nil
```

The best part about using a `ThingDoer::Thing` is that it will pass through methods it doesn't recognize to the underlying object. If the underlying object doesn't recognize it either, it raises an `UndoableError`.
```
irb(main):021:0> thing.bar("some argument")
bar with some argument
=> nil
irb(main):022:0> thing.not_a_method
ThingDoer::UndoableError: You can't do that
                          from /home/aidanfc/github/thingdoer/lib/thingdoer/thing.rb:16:in `method_missing'
                          from (irb):22
                          from bin/console:14:in `<main>'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/packrat386/thingdoer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

