"""
Name: cache_simulator.py
Date: 15-7-2024
Author: Muhammad Tayyab
Description: 
    A cache simulator to model the behavior of a direct-mapped cache.
    • 128 cache lines.
    • Read and write operations
    • Keeps track of hits and misses.
    • Fields for valid bits, tags, and data.
    • Checks for hits and misses.
    • Functions for read, write, reset and initialization.
    • Test the simulator with sequences of memory accesses and compare the results with expected cache behavior.
    • Tracks number of hits and misses

"""
from math import ceil, log2

class CacheSimulator:
    def __init__(self, cache_size: int, block_size: int):
        """
        Initializes / resets cache.
        Arguments:  cache_size (int): size of cache
                    block_size (int): size of data in a line/block
        Returns: None
        """
        # Get number of lines in cache
        num_lines =  ceil(cache_size / block_size)

        # Store cache parameters
        self.num_lines = num_lines
        self.len_offset_feild = ceil(log2(block_size))
        self.len_index_feild = ceil(log2(num_lines))

        # Initialize cache statistics
        self.number_hit = 0
        self.number_miss = 0

        # Initialize cache feilds as zero / None
        self.valid_bits = [0 for x in range(num_lines)]                # set all valid bits to 0
        self.tags = [None for x in range(num_lines)]                   # set all tags to None

        # Inner loop sets data in all feilds in a line/blocks to None.
        # Outer loop makes multiple lines/blocks
        self.data = [ [None for x in range(block_size)] for x in range(num_lines) ]
    
    def read(self, address: int) -> bool:
        """
        Check if a given memory address in cache is available to read.
        Hit only if valid bit is 1 and tag match.
        Arguments:  address (int): address of memory
        Returns: (bool) True if hit
                 (bool) False if miss
        """
        # Get tag, index, offset from address
        offset = address % self.len_offset_feild
        index = (address >> self.len_offset_feild) % self.len_index_feild
        tag = address >> (self.len_offset_feild + self.len_index_feild)

        # Check valid bit and tag at index
        # Hit only if valid bit is 1 and tag matches
        if ((self.valid_bits[index] == 1) and (self.tags[index] == tag)):
            hit = True
            self.number_hit += 1
            # Return data
        else:
            hit = False
            self.number_miss += 1
            # Load data from memory
            self.valid_bits[index] = 1
            self.tags[index] = tag
        
        return hit
    
    def write(self, address: int):
        """
        Check if a given memory address in cache is available to write.
        Hit only if valid bit is 1 and tag matches
        Arguments:  address (int): address of memory
        Returns: (bool) True if hit
                 (bool) False if miss
        """
        # Get tag, index, offset from address
        offset = address % self.len_offset_feild
        index = (address >> self.len_offset_feild) % self.len_index_feild
        tag = address >> (self.len_offset_feild + self.len_index_feild)

        # Check valid bit and tag at index
        # Hit only if valid bit is 1 and tag matches
        if ((self.valid_bits[index] == 1) and (self.tags[index] == tag)):
            hit = True
            self.number_hit += 1
            # Write data
        else:
            hit = False
            self.number_miss += 1
            # Store cache data to memory and then write
            # OR load data from memory and then write
            self.valid_bits[index] = 1
            self.tags[index] = tag

        self.valid_bits[index] = 1
        self.tags[index] = tag
        
        return hit
    
    def get_stats(self):
        """
        Gets statistics of number of times cache access was a hit or a miss
        Arguments:  address (int): address of memory
        Returns: (bool) True if hit
                 (bool) False if miss
        """
        return {'hits': self.number_hit, 'miss': self.number_miss}

# Test Cases
cache_sim = CacheSimulator(cache_size=1024, block_size=64)
print(
cache_sim.read(0x0000), # Expected output: miss
cache_sim.read(0x0040), # Expected output: miss
cache_sim.read(0x0000), # Expected output: hit
cache_sim.write(0x0080), # Expected output: miss
cache_sim.write(0x00C0), # Expected output: miss
cache_sim.read(0x0080), # Expected output: hit
sep="\n")
print(cache_sim.get_stats()) # Expected output: {'hits': 2, 'misses': 4