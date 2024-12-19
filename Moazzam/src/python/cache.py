import numpy as np

class CacheSimulator:
    def __init__(self, cache_size: int, block_size: int):
        # Your implementation here
        self.cache_size = cache_size                # size in bytes  8
        self.block_size = block_size//8             # size in bytes  1024
        self.cache_line = (cache_size//self.block_size)  # lenght of cache 128

        # initialize the cache #
        self.reset_cache()


    def _get_offset_index_and_tag(self, address: int):
        # Calculate the cache line index and tag for a given address
        offset_bits = 3      # fix wrt block_size
        index_bits  = 7      # fix wrt cache_line

        # obtain offset, index, tag
        offset = address % self.block_size
        index = (address >> offset_bits) % self.cache_line
        tag   = address >> (offset_bits+index_bits)
        return offset, index, tag

        
    def read(self, address: int):
        # Simulate a read operation from the cache
        offset, index, tag = self._get_offset_index_and_tag(address)
        #print(offset, index, tag)
        
        if (self.valid_bits[index] == 1 ) and ( self.tags[index] == tag ):
            # Cache hit
            self.hits += 1
            return True
        else:
            # Cache miss
            self.miss += 1
            self.valid_bits[index] = 1
            self.tags[index] = tag
            #self.data[index] =          # ignore to it data want to write in it
            return False

    def write(self, address: int):
        # Simulate a write operation to the cache
        offset, index, tag = self._get_offset_index_and_tag(address)
        #print(offset, index, tag)

       
        if (self.valid_bits[index] == 1 ) and ( self.tags[index] == tag ):
            # Cache hit
            self.hits += 1
            return True
        else:
            # Cache miss
            self.miss += 1
            self.valid_bits[index] = 1
            self.tags[index] = tag
            #self.data[index] =            # ignore to it data want to write in it
            return False

        
    def get_stats(self):
        # Return the number of hits and miss
        return {'hits': self.hits, 'miss': self.miss}

    def reset_cache(self):
        self.hits = 0
        self.miss = 0

        # Initialize cache valid_bit as zero & tags as None
        self.valid_bits = [0 for x in range(self.cache_line)]
        self.tags = [None for x in range(self.cache_line)]

        # Inner loop sets data in all feilds in a line/blocks to None.
        # Outer loop makes multiple lines/blocks
        self.data = [ [None for x in range(self.block_size)] for x in range(self.cache_line) ]




# Test Cases
cache_sim = CacheSimulator(cache_size=1024, block_size = 64)
#print("cache line = ", cache_sim.cache_line)
print(
cache_sim.read(0x0000) ,# Expected output: miss
cache_sim.read(0x0040) ,# Expected output: miss
cache_sim.read(0x0000) ,# Expected output: hit
cache_sim.write(0x0080), # Expected output: miss
cache_sim.write(0x00C0), # Expected output: miss
cache_sim.read(0x0080), # Expected output: hit
sep="\n")
print(cache_sim.get_stats()) # Expected output: {'hits': 2, 'miss': 4}