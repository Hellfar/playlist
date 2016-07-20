#!/usr/bin/env ruby

require 'gtk3'

class Glade < Gtk::Builder
	def initialize gladeStruct, rootObject = "window1", filename = true
		super()

		if filename
			fromFile gladeStruct
		else
			fromString gladeStruct
		end

		self[rootObject].signal_connect('destroy') { Gtk.main_quit }
		self[rootObject].show_all
		self.connect_signals{ |handler| method(handler) }
	end
	def fromFile gladeFile
		self.add_from_file(gladeFile)
	end
	def fromString gladeString
		self.add_from_string(gladeString)
	end

	def button_clicked w
		case w.label
			when 'quit'
				Gtk::main_quit
			else
				puts "# button_clicked : " + w.label
		end
	end
end

if __FILE__ == $0

	require 'optparse'

	options = {}
	OptionParser.new do | opts |
	  opts.banner = "Usage: example.rb [options]"

	  opts.on("-v", "--[no-]verbose", "Run verbosely") do | v |
	    options[:verbose] = v
	  end
	end.parse!

	builder = Glade.new("account.glade")
	Gtk.main

end
