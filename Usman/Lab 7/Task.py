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
