# -*- ruby -*-

require 'rubygems'
require 'hoe'
require 'hoe/signing'

Hoe.plugin :yard

Hoe.spec('static_paths') do
  self.rubyforge_name = 'static-paths'
  self.developer('Postmodern', 'postmodern.mod3@gmail.com')

  self.rspec_options += ['--colour', '--format', 'specdoc']

  self.yard_options += ['--protected']
  self.remote_yard_dir = '/'

  self.extra_dev_deps += [
    ['rspec', '>=1.2.9'],
    ['yard', '>=0.5.3']
  ]
end

# vim: syntax=ruby
