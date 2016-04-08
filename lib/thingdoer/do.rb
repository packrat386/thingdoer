# ThingDoer does things
module ThingDoer
  DOABLE = [:do, :do_it, :start, :execute, :run, :main, :call].freeze

  def self.do_the_thing(thing, *args)
    yield(*args) && return if block_given?
    DOABLE.each do |doable|
      return thing.send(doable, *args) if thing.respond_to?(doable)
    end
    raise(UndoableError, "You can't do that")
  end
end
