#! /usr/bin/env python
# Python script to generate test data

# Configurables

outfile_count = 1			# Number of files to write
outfile_size = 10 * 1024 * 1024		# Size of each file
outfile_block_size = 128 * 1024		# Size of each block in file
outfile_basename = 'outfile_'		# Suffix of output file names
infile_name = 'data.tgz'		# Data file to use as input

########################################

import random

# Globals

infile = 0
seq_start_str = '10000000'
seq_start = int(seq_start_str)
seq_end = int(seq_start_str + '0') - 1
seq_size = len(seq_start_str)


def generate_block():
    '''Read a block from input file and add sequence at the start'''
   
    try: 
        while 1:
            data = infile.read(outfile_block_size - seq_size)
            if (len(data) != outfile_block_size - seq_size):
                infile.seek(0, 0)
                continue
            
            seq = str(random.randint(seq_start, seq_end))
            return seq + data

    except:
        print "Error reading from file \'%s\'" % infile_name
        raise


def generate_files():
    '''Generate outfile_count number of files'''

    try:
        file_count = 1 
        while file_count <= outfile_count:

            outfile = open(outfile_basename + str(file_count), 'wb')

            block_count = 0
            while block_count < outfile_size / outfile_block_size:
                outfile.write(generate_block())
                block_count += 1

            outfile.close()
            file_count += 1 

    except:
        print 'Error opening or writing to file \'%s\'' % (outfile_basename + str(file_count))
        raise


def main():

    global infile, oufile

    try:
        infile = open(infile_name, 'rb')

    except:
        print 'Error opening file \'%s\' for reading' % infile_name
        return 1

    generate_files()

    infile.close()
    return 0


if __name__ == '__main__':
    main()

