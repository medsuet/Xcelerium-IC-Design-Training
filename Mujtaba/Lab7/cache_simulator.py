#!/usr/bin/env python3

class CacheSimulator:
    def __init__(self, cache_size: int, block_size: int):
        self.cache_size = cache_size
        self.block_size = block_size
        # cache lines
        self.num_blocks = (int)(cache_size / (block_size/8))
        # cache memory
        self.cache = [None] * self.num_blocks
        self.hits = 0
        self.misses = 0
    
    def read(self, address: int) -> bool:
        # extracting or finding index to which the tag is placed
        block_index = (address >> 3) & 0x7f
        tag = (address >> 10) & 0x3f
        if self.cache[block_index] == tag:  
            self.hits += 1
            print("hit")
            return True
        else:
            self.misses += 1
            self.cache[block_index] = tag 
            print("miss")
            return False
    
    def write(self, address: int):
        # extracting or finding index to which the tag is placed 
        block_index = (address >> 3) & 0x7f
        tag = (address >> 10) & 0x3f

        if self.cache[block_index] == tag:  
            self.hits += 1
            print("hit")
        else:
            self.misses += 1
            self.cache[block_index] = tag 
            print("miss")
    
    def get_stats(self):
        return {'hits': self.hits, 'misses': self.misses}

# Test Cases
cache_sim = CacheSimulator(cache_size=1024, block_size=64)
cache_sim.read(0x0000)  # Expected output: miss
cache_sim.read(0x0040)  # Expected output: miss
cache_sim.read(0x0000)  # Expected output: hit
cache_sim.write(0x0080) # Expected output: miss
cache_sim.write(0x00C0) # Expected output: miss
cache_sim.read(0x0080)  # Expected output: hit
print(cache_sim.get_stats())  # Expected output: {'hits': 2, 'misses': 4}

 
