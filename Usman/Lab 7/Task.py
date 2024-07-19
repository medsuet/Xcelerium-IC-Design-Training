import math
class CacheSimulator:
def __init__(self, cache_size: int, block_size: int):
# Your implementation here
         self.cache_size = cache_size
         self.block_size = block_size
         self.cache = [[0,0,0] for i in range (cache_size//block_size)]
         self.hit = 0
         self.miss = 0
         self.offset_bits = math.log2(block_size)
         self.index_bits =  math.log2(cache_size//block_size)

def read(self, address: int) -> bool:
# Your implementation here
        tag =  address >> (self.offset_bits + self.index.bits)
        index = address[:self.index_bits]
        offset = address[self.index_bits+1:self.offset_bits]
        self.cache[index][offset]  #reading cache
         
        valid = self.cache[index][0]
        tag_address   = self.cache[index][1]
        if ((valid == 1) & (tag_address == tag)):
                self.hit = self.hit +1
        else:
                self.miss = self.miss +1

def write(self, address: int):
# Your implementation here
def get_stats(self):
# Your implementation here
# Test Cases
cache_sim = CacheSimulator(cache_size=1024, block_size=64)
cache_sim.read(0x0000) # Expected output: miss
cache_sim.read(0x0040) # Expected output: miss
cache_sim.read(0x0000) # Expected output: hit
cache_sim.write(0x0080) # Expected output: miss
cache_sim.write(0x00C0) # Expected output: miss
cache_sim.read(0x0080) # Expected output: hit
print(cache_sim.get_stats()) # Expected output: {'hits': 2, 'misses': 4}

"""
import math

class CacheSimulator:
    def __init__(self, cache_size: int, block_size: int):
        self.cache_size = cache_size
        self.block_size = block_size
        self.num_lines = cache_size // block_size
        self.cache = [{'valid': 0, 'tag': None, 'data': None} for _ in range(self.num_lines)]
        self.hit = 0
        self.miss = 0
        self.offset_bits = int(math.log2(block_size))
        self.index_bits = int(math.log2(self.num_lines))

    def read(self, address: int) -> bool:
        index = (address >> self.offset_bits) & (self.num_lines - 1)
        tag = address >> (self.offset_bits + self.index_bits)
        
        if self.cache[index]['valid'] == 1 and self.cache[index]['tag'] == tag:
            self.hit += 1
            return True  # hit
        else:
            self.cache[index] = {'valid': 1, 'tag': tag, 'data': None}
            self.miss += 1
            return False  # miss

    def write(self, address: int):
        index = (address >> self.offset_bits) & (self.num_lines - 1)
        tag = address >> (self.offset_bits + self.index_bits)
        
        if self.cache[index]['valid'] == 1 and self.cache[index]['tag'] == tag:
            self.hit += 1
        else:
            self.cache[index] = {'valid': 1, 'tag': tag, 'data': None}
            self.miss += 1

    def get_stats(self):
        return {'hits': self.hit, 'misses': self.miss}

    def reset(self):
        self.cache = [{'valid': 0, 'tag': None, 'data': None} for _ in range(self.num_lines)]
        self.hit = 0
        self.miss = 0

# Test Cases
cache_sim = CacheSimulator(cache_size=1024, block_size=64)
assert cache_sim.read(0x0000) == False # Expected output: miss
assert cache_sim.read(0x0040) == False # Expected output: miss
assert cache_sim.read(0x0000) == True  # Expected output: hit
cache_sim.write(0x0080)                # Expected output: miss
cache_sim.write(0x00C0)                # Expected output: miss
assert cache_sim.read(0x0080) == True  # Expected output: hit
print(cache_sim.get_stats())           # Expected output: {'hits': 2, 'misses': 4}
"""