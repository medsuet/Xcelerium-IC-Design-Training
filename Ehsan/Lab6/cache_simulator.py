import math
class CacheSimulator:
    def __init__(self, cache_size: int, block_size: int):
        self.cache_size = cache_size   #cache total size
        self.cache_block_size = block_size   #block size
        self.cache_lines = cache_size // block_size   #no. of cache lines

        self.cache_offset_bits = int(math.log(block_size,2))  #no. of offset bits
        self.cache_index_bits = int(math.log(self.cache_lines,2))  #no. of index bits
        self.cache_tag_bits = 16 - self.cache_offset_bits - self.cache_index_bits  #no. of tag bits
        
        self.hits = 0    #no. of hits
        self.misses = 0  #no. of misses
        self.cache = []   #making cache
        for i in range (self.cache_lines): #building cache mempry   
            self.cache.append ([0,None])  #not_valid=0, valid=1, tag=none
          
    def read(self, address: int) -> bool:
        tag = address >> (self.cache_index_bits+self.cache_offset_bits)
        index = (address >> self.cache_offset_bits) & ((2**self.cache_index_bits) -1)
        
        if (self.cache[index][0] == 1 and self.cache[index][1] == tag):
            self.hits += 1
            print("hit")
        else:
            self.cache[index][0] = 1
            self.cache[index][1] = tag
            self.misses += 1
            print("miss")

    def write(self, address: int):
        tag = address >> (self.cache_index_bits+self.cache_offset_bits)
        index = (address >> self.cache_offset_bits) & ((2**self.cache_index_bits) -1)

        if(self.cache[index][0] == 1 and self.cache[index][1] == tag):
            self.hits += 1
            print("hit")

        else:
            self.cache[index][0] = 1
            self.cache[index][1] = tag
            self.misses += 1
            print("miss")

    def reset(self):
        #reseting cache by making valid = 0 and tag = None
        for i in range (self.cache_lines):
            self.cache[i][0] = 0
            self.cache[i][0] = None
        print("Cache reset")

    def get_stats(self):
        print("No. of hits :",self.hits,"No. of misses :",self.misses)


# Test Cases
cache_sim = CacheSimulator(cache_size=1024, block_size=8)
cache_sim.read(0x0000) # Expected output: miss
cache_sim.read(0x0040) # Expected output: miss
cache_sim.read(0x0000) # Expected output: hit
cache_sim.write(0x0080) # Expected output: miss
cache_sim.write(0x00C0) # Expected output: miss
cache_sim.read(0x0080) # Expected output: hit
cache_sim.get_stats() # Expected output: {'hits': 2, 'misses': 4}
cache_sim.reset() #Resting cache memory
