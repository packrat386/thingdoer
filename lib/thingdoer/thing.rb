module ThingDoer
  class UndoableError < StandardError
  end

  # Thing is a thing that you might want to do a thing
  class Thing
    attr_accessor :thing

    def initialize(thing)
      self.thing = thing
    end

    def method_missing(method, *args, &block)
      return thing.send(method, *args, &block) if thing.respond_to?(method)
      return ThingDoer.do_the_thing(thing, *args, &block) if DOABLE.include?(method)
      raise(UndoableError, "You can't do that")
    end
  end
end
