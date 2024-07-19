class CacheLine:
    def __init__(self):
        self.valid = False  # Indicates if the cache line is valid
        self.tag = None     # Stores the tag for the cache line

class CacheSimulator:
    def __init__(self, cache_size: int, block_size: int):
        self.cache_size = cache_size
        self.block_size = block_size
        self.num_lines = cache_size // block_size  # Number of cache lines
        self.cache = [CacheLine() for _ in range(self.num_lines)]  # Initialize cache lines
        self.hits = 0
        self.misses = 0
    
    def _get_index_and_tag(self, address: int):
        index = (address // self.block_size) % self.num_lines  # Calculate index
        tag = address // (self.block_size * self.num_lines)    # Calculate tag
        return index, tag
    
    def read(self, address: int) -> bool:
        index, tag = self._get_index_and_tag(address)  
        cache_line = self.cache[index]
        
        if cache_line.valid and cache_line.tag == tag:
            self.hits += 1
            return True  # Cache hit
        else:
            self.misses += 1
            cache_line.valid = True
            cache_line.tag = tag
            return False  # Cache miss
    
    def write(self, address: int):
        index, tag = self._get_index_and_tag(address)  
        cache_line = self.cache[index]
        
        if cache_line.valid and cache_line.tag == tag:
            self.hits += 1  # Cache hit
        else:
            self.misses += 1  # Cache miss
            cache_line.valid = True
            cache_line.tag = tag
    
    def get_stats(self):
        return {'hits': self.hits, 'misses': self.misses}
    
    def reset_cache(self):
        self.cache = [CacheLine() for _ in range(self.num_lines)]  # Reset cache lines
        self.hits = 0
        self.misses = 0

# Test Cases
cache_sim = CacheSimulator(cache_size=1024, block_size=64)
print(cache_sim.read(0x0000))  # Expected output: miss (False)
print(cache_sim.read(0x0040))  # Expected output: miss (False)
print(cache_sim.read(0x0000))  # Expected output: hit (True)
cache_sim.write(0x0080)        # Expected output: miss
cache_sim.write(0x00C0)        # Expected output: miss
print(cache_sim.read(0x0080))  # Expected output: hit (True)
print(cache_sim.get_stats())   # Expected output: {'hits': 2, 'misses': 4}
