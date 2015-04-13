require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require

$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'lorem_app'

use Rack::ShowExceptions
use Rack::Static,
  :urls => ["/images", "/js", "/css"],
  :root => "public"

run Lorem::App.new
