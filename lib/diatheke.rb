require 'shellwords'

module Diatheke

  class << self

    def mods
      call('system', 'modulelistnames').split(/\n/)
    end

    def passage(mod, key)
      call(mod, key)
    end

    def search(mod, key, opts={})
      search_type = :phrase
      search_key = key
      case key
      when Regexp
        search_type = :regex
        search_key = key.inspect.sub(%r(^/)).sub(%r(/$))
      when Array
        search_type = :multiword
        search_key = key.join(' ')
      end
      opts[:search_type] = search_type
      call(mod, search_key, opts)
    end

    private

    def call(mod, key, opts={})
      args = []
      if s = opts[:search_type]
        args << '-s' << s
      end
      if r = opts[:range]
        args << '-r' << r
      end
      cmd = "diatheke -b #{mod} #{args.map {|a| Shellwords.escape(a.to_s)}.join(' ')} -k #{key}"
      puts cmd
      `#{cmd}`
    end

  end

end
