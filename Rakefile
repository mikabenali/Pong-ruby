require 'rubygems'
require 'bundler/setup' # Releasy requires require that your application uses bundler.
require 'releasy'

Releasy::Project.new do
    name "Pong"
    version "1.0.0"
    verbose # Can be removed if you don't want to see all build messages.

    executable "main.rb"
    files "*.rb"
    exclude_encoding # Applications that don't use advanced encoding (e.g. Japanese characters) can save build size with this.

    # Create a variety of releases, for all platforms.
    add_build :osx_app do
        url "com.github.my_application"
        wrapper "gosu-mac-wrapper-0.7.41.tar.gz" # Assuming this is where you downloaded this file.
        icon "media/icon.icns"
        add_package :tar_gz
    end

    add_build :source do
        add_package :"7z"
    end

    add_deploy :local # Only deploy locally.
end
