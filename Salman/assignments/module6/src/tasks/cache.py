
""" CACHE SIMULATOR """

import numpy as np

class CacheSimulator:
    def __init__(self, cache_size: int, block_size: int):
        # TODO: Initialize Cache
        self.cache_size = cache_size
        self.block_size = block_size//8             # converting size from bits to bytes
        self.cache_line = (cache_size//self.block_size)

        # Initializing cache
        self.hits = 0
        self.miss = 0

        # valid_bits initialized to 0
        self.valid_bits = [0 for i in range(self.cache_line)]

        # tags bits initialized to None
        self.tags = [None for i in range(self.cache_line)]

        # Inner loop - Sets data inside block to None
        # Outer loop - Creates a number of cache lines
        self.data = [ [None for i in range(self.block_size)] for j in range(self.cache_line) ]


    def address_decoder(self, address: int):
        # TODO: Decode address into offset, index and tag bits
        # Total address is of 16 bits
        offset_bits = 3      # Fixed w.r.t blocksize
        index_bits  = 7      # Fixed w.r.t num of cache lines

        # Decoding
        offset = address % self.block_size
        index = (address >> offset_bits) % self.cache_line
        tag   = address >> (offset_bits+index_bits)
        return offset, index, tag


    def read(self, address: int):
        # TODO: Simulate a read operation from the cache
        (offset, index, tag) = self.address_decoder(address)
        #print(offset, index, tag)

        # if valid bit is 1 and tag matches -- Simulate Cache hit
        if (self.valid_bits[index] == 1 ) and ( self.tags[index] == tag ):
            # Cache hit
            self.hits += 1
            print("Read Hit")
        else:
            # Simulate Cache miss
            self.miss += 1
            # Write into the address
            self.valid_bits[index] = 1
            self.tags[index] = tag
            print("Read Miss")
            w_data = int(input("Enter a byte (8-bit number) to write: "))
            w_data = np.int8(w_data)
            self.data[index][offset] = w_data

    def write(self, address: int):
        # TODO: Simulate a write operation to the cache
        (offset, index, tag) = self.address_decoder(address)
        #print(offset, index, tag)

        w_data = int(input("Enter a byte (8-bit number) to write: "))
        w_data = np.int8(w_data)
        # Write hit occurs when the data to be written is already present at that address
        if (self.data[index][offset] == w_data):
            # Write Hit: No need to write data again
            self.hits += 1
            # Setting up valid and tag bit
            self.valid_bits[index] = 1
            self.tags[index] = tag
            print("Write Hit")
        else:
            # Cache miss
            self.miss += 1
            # Set up valid and tag bits
            self.valid_bits[index] = 1
            self.tags[index] = tag
            # Write into that address
            self.data[index][offset] = w_data
            print("Write Miss")


    def get_stats(self):
        # Return the number of hits and miss
        return {'hits': self.hits, 'miss': self.miss}


# Test Cases
cache_sim = CacheSimulator(cache_size=1024, block_size = 64)
#print("cache line = ", cache_sim.cache_line)

cache_sim.read(0x0000)     # Expected output: miss
cache_sim.read(0x0040)     # Expected output: miss
cache_sim.read(0x0000)     # Expected output: hit
cache_sim.write(0x0080)    # Expected output: miss
cache_sim.write(0x00C0)    # Expected output: miss
cache_sim.read(0x0080)     # Expected output: hit

cache_sim.write(0x00C0)    # Expected output: hit if input is equal to prev input, otherwise miss

print(cache_sim.get_stats()) # Expected output: {'hits': 2, 'miss': 4}
