# RPxem

[![Build Status](https://travis-ci.org/wktk/rpxem.svg?branch=master)](https://travis-ci.org/wktk/rpxem)

RPxem is a Ruby implementation of [Pxem], an esoteric programming language that
enables you to create programs in 0-byte files.

[Pxem]: https://web.archive.org/web/20120605223423/http://cfs.maxn.jp/neta/pxem.php

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rpxem'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install rpxem
```

## Usage

### Using in Ruby

Require `RPxem`:

```ruby
require 'rpxem'
```

Open and execute your Pxem **file**:

```ruby
path_to_pxem_file = '~/Hello, world!.pxe'
RPxem.open(path_to_pxem_file) #=> Hello, world!
```

Execute your Pxem **code**:

```ruby
file_name = 'world!.fHello,.pxe'
file_cont = ' Pxem '
RPxem.run(file_name, file_cont) #=> Hello, Pxem world!
```

### Using from CLI

This program also runs as a command-line Pxem interpreter called `rpxem`:

```bash
$ touch "Hello, world!.pxe"
$ rpxem "Hello, world!.pxe"
Hello, world!
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright (c) 2012 wktk.  This software is distributed under the
MIT License.  See `MIT-LICENSE.txt` for details.

## See also

- Original resource: https://web.archive.org/web/20120605223423/http://cfs.maxn.jp/neta/pxem.php
- Esolang wiki: https://esolangs.org/wiki/Pxem
