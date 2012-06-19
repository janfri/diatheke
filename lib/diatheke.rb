module Diatheke

  class << self

    def mods
      call('system', 'modulelistnames').split(/\n/)
    end

    def passage(book, key)
      call(book, key)
    end

    private

    def call book, key, opts={}
      opts_str = ''
      cmd = "diatheke -b #{book} #{opts_str} -k #{key}"
      `#{cmd}`
    end

  end

end
