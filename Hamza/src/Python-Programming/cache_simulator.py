class CacheSimulator:
    def __init__(self, cache_size: int, block_size: int):
        """
        Initialize the cache simulator.
        """
        # Calculate the number of cache lines
        self.cache_lines = cache_size // block_size
        self.block_size = block_size
        
        # Initialize the cache with 'valid', 'tag', and 'data' fields
        self.cache = [{'valid': False, 'tag': None, 'data': None} for _ in range(self.cache_lines)]
        
        # Initialize hit and miss counters
        self.hits = 0
        self.misses = 0

    def _get_index_and_tag(self, address: int):
        """
        Get the index and tag from the memory address.
        """
        index = (address // self.block_size) % self.cache_lines
        tag = address // (self.block_size * self.cache_lines)
        return index, tag

    def read(self, address: int) -> bool:
        """
        Simulate a read operation.
        """
        index, tag = self._get_index_and_tag(address)
        cache_line = self.cache[index]

        # Check if the cache line is valid and the tags match
        if cache_line['valid'] and cache_line['tag'] == tag:
            self.hits += 1
            return True  # Cache hit
        else:
            self.misses += 1
            cache_line['valid'] = True
            cache_line['tag'] = tag
            cache_line['data'] = 'data'  # Simulate data load
            return False  # Cache miss

    def write(self, address: int) -> bool:
        """
        Simulate a write operation.
        """
        index, tag = self._get_index_and_tag(address)
        cache_line = self.cache[index]

        # Check if the cache line is valid and the tags match
        if cache_line['valid'] and cache_line['tag'] == tag:
            self.hits += 1
            return True  # Cache hit
        else:
            self.misses += 1
            cache_line['valid'] = True
            cache_line['tag'] = tag

        cache_line['data'] = 'data'  # Simulate data write
        return False  # Cache miss

    def get_stats(self):
        """
        Get the statistics of cache hits and misses.
        """
        return {'hits': self.hits, 'misses': self.misses}

    def reset(self):
        """
        Reset the cache simulator to its initial state.
        """
        # Reinitialize the cache and reset the counters
        self.cache = [{'valid': False, 'tag': None, 'data': None} for _ in range(self.cache_lines)]
        self.hits = 0
        self.misses = 0

# Test Cases
cache_sim = CacheSimulator(cache_size=1024, block_size=64)
print(cache_sim.read(0x0000))  # Expected output: miss (False)
print(cache_sim.read(0x0040))  # Expected output: miss (False)
print(cache_sim.read(0x0000))  # Expected output: hit (True)
print(cache_sim.write(0x0080))  # Expected output: miss (False)
print(cache_sim.write(0x00C0))  # Expected output: miss (False)
print(cache_sim.read(0x0080))  # Expected output: hit (True)
print(cache_sim.get_stats())    # Expected output: {'hits': 2, 'misses': 4}
