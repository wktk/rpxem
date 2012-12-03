# RPxem

[![Build Status](https://travis-ci.org/wktk/rpxem.png)](https://travis-ci.org/wktk/rpxem)

RPxem is a Ruby implementation of [Pxem], a esoteric programming language that
enables you to create programs in 0-byte files.
[Pxem]: http://cfs.maxn.jp/neta/pxem.php

## Installation

Add this line to your application's Gemfile:

    gem 'rpxem'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rpxem

## Usage

### Using in Ruby

Require `RPxem`:

    require 'rpxem'

Open and execute your Pxem **file**:

    path_to_pxem_file = '~/Hello, world!.pxe'
    RPxem.open(path_to_pxem_file) #=> Hello, world!

Execute your Pxem **code**:

    file_name = 'world!.fHello,.pxe'
    file_cont = ' Pxem '
    RPxem.run(file_name, file_cont) #=> Hello, Pxem world!

### Using from CLI

This program also runs as a command-line Pxem interpreter called `rpxem`:

    $ touch "Hello, world!.pxe"
    $ rpxem "Hello, world!.pxe"
    Hello, world!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright (c) 2012 wktk.  This software is distributed under the
MIT License.  See `MIT-LICENSE.txt` for details.
