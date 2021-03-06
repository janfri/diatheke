# encoding: utf-8

#
# Diatheke
#
# This library is a wrapper of the diatheke command-line client of the sword project.
# http://www.crosswire.org/sword/index.jsp
#
# Copyright (C) 2012-2014 by Jan Friedrich <janfri26@gmail.com>
# Licensed under the GNU LESSER GENERAL PUBLIC LICENSE,
# Version 2.1, February 1999
#
require 'shellwords'

module Diatheke

  VERSION = '0.2.2'

  class << self

    def mods
      call('system', 'modulelistnames').split(/\n/)
    end

    def passage(mod, key, **opts)
      s = call(mod, key, **opts)
      parse_passage s
    end

    def search(mod, key, **opts)
      search_type = :phrase
      search_key = key
      case key
      when Regexp
        search_type = :regex
        search_key = key.source
      when Array
        search_type = :multiword
        search_key = key.join(' ')
      end
      opts[:search_type] = search_type
      s = call(mod, search_key, **opts)
      parse_search s
    end

    private

    def call(mod, key, **opts)
      args = []
      if f = opts[:format]
        args << '-f' << f
      end
      if s = opts[:search_type]
        args << '-s' << s
      end
      if r = opts[:range]
        args << '-r' << r
      end
      cmd = "diatheke -b #{mod} #{args.map {|a| Shellwords.escape(a.to_s)}.join(' ')} -k #{key}"
      `#{cmd}`
    end

    def parse_passage(s)
      a = s.split(/^(?=\w+ +\d+:\d+:)/)
      a.last.sub!(/\(\w+\)$/, '')
      a.map do |v|
        v.strip!
        k, t = v.split(': ', 2)
        Verse.new k, t
      end
    end

    def parse_search(s)
      a = s.split(/\s*--\s*/)
      if a.size == 3
        return a[1].split(/\s*;\s*/)
      else
        return []
      end
    end

  end

  Verse = Struct.new(:key, :text)

end
