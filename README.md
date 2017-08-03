# Diatheke

## Description

This library is a wrapper of the
[diatheke command-line client](http://www.crosswire.org/wiki/Frontends:Diatheke) of the
[sword project](http://www.crosswire.org/sword/index.jsp).

## Installation

  gem install diatheke

## Examples

    # Get installed modules
    p Diatheke.mods

    # Get a passage
    puts Diatheke.passage('KJV', 'John 1').to_yaml

    # Search a phrase
    p Diatheke.search('KJV', 'with God', range:  'Joh 1')

    # Search with method "multi word"
    p Diatheke.search('KJV', %w(God Jesus), range:  'Joh 1')

    # Search with regular expression
    p Diatheke.search('KJV', /Jesus.+Jesus/, range:  'Joh 1')

## Author

Jan Friedrich <janfri26@gmail.com>

## Copyright / License

Copyright (c) 2012-2014 by Jan Friedrich

Licensed under terms of the GNU LESSER GENERAL PUBLIC LICENSE, Version 2.1,
February 1999 (see file COPYING for more details)
