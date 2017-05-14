#!/usr/bin/env python
#
# **************************************************************
#               Convert text to multiple echos
# **************************************************************
#
# Author: Nick Aliferopoulos
# aliferopoulos@icloud.com
#

from argparse import ArgumentParser, ArgumentDefaultsHelpFormatter

class TextToEcho(object):
	def __init__(self, prefix, suffix):
		self.prefix = prefix
		self.suffix = suffix
	
	def convert(self):
		print("Type away! :)")
		
		final = ""
		print "\t",
		text = raw_input()
	
		while(text != ""):
			final = final + self.prefix + text + self.suffix + "\n"			
			print "\t",			
			text = raw_input()

		print("Done! Here are your echos!")
		print("")
		print(final)

def main():
    parser = ArgumentParser(description='Text to Echo', formatter_class = ArgumentDefaultsHelpFormatter)
    parser.add_argument('-v', '--version', action = 'version', version = '%(prog)s 1.0')
    parser.add_argument('-p', '--prefix', default = 'echo \"', required = False, help = 'Line prefix')
    parser.add_argument('-s', '--suffix', default = "\"", required = False, help = 'Line suffix')
    args = parser.parse_args()

    tte = TextToEcho(args.prefix, args.suffix)
    tte.convert()

if __name__ == '__main__':
    main()
