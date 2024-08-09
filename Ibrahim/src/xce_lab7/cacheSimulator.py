class CacheSimulator:
    def __init__(self, cache_size: int, block_size: int):
        # Initialize the cache simulator with given cache size and block size
        self.cache_lines = cache_size // block_size  # Number of cache lines
        self.block_size = block_size  # Size of each cache block
        
        # Create a list of cache lines, each initialized with valid = False and tag = None
        self.cache = [{'valid': False, 'tag': None, 'data': None} for _ in range(self.cache_lines)]
        
        # Initialize counters for cache hits and misses
        self.hits = 0
        self.misses = 0

    def _get_index_and_tag(self, address: int):
        # Compute the cache line index and tag for a given memory address
        index = (address // self.block_size) % self.cache_lines  
        tag = address // (self.block_size * self.cache_lines)  
        return index, tag

    def read(self, address: int) -> bool:
        # Simulate a read operation for the given address
        # Get index and tag for the address
        index, tag = self._get_index_and_tag(address) 
        
        # Access the cache line at the computed index
        cache_line = self.cache[index]  

        # Check if the cache line is valid and the tag matches
        if cache_line['valid'] and cache_line['tag'] == tag:
            self.hits += 1  # Increment hit counter
            return True  # hit
        else:
            self.misses += 1  # Increment miss counter
            # Update the cache line with the new tag and mark it as valid
            self.cache[index] = {'valid': True, 'tag': tag, 'data': None}
            return False  # miss

    def write(self, address: int):
        # Simulate a write operation for the given address
        # Get index and tag for the address
        index, tag = self._get_index_and_tag(address)  
        # Access the cache line at the computed index
        cache_line = self.cache[index]  

        # Check if the cache line is valid and the tag matches
        if cache_line['valid'] and cache_line['tag'] == tag:
            self.hits += 1  # Increment hit counter
            # No need to return anything for a write hit
        else:
            self.misses += 1  # Increment miss counter
            # Update the cache line with the new tag and mark it as valid
            self.cache[index] = {'valid': True, 'tag': tag, 'data': None}
            # No need to return anything for a write miss

    def get_stats(self):
        # Return cache hits and misses
        return {'hits': self.hits, 'misses': self.misses}

# Test Cases
cache_sim = CacheSimulator(cache_size=1024, block_size=64)
print(cache_sim.read(0x0000))  # Expected output: miss (False) - First access to this address
print(cache_sim.read(0x0040))  # Expected output: miss (False) - First access to this address
print(cache_sim.read(0x0000))  # Expected output: hit (True) - Address 0x0000 is now in cache
print(cache_sim.write(0x0080)) # Expected output: miss (False) - First access to this address
print(cache_sim.write(0x00C0)) # Expected output: miss (False) - First access to this address
print(cache_sim.read(0x0080))  # Expected output: hit (True) - Address 0x0080 was written to cache
print(cache_sim.get_stats())   # Expected output: {'hits': 2, 'misses': 4} - Summary of cache performance
