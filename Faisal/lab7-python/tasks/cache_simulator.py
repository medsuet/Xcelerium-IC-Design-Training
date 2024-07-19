class CacheSimulator:
    def __init__(self, cache_size: int, block_size: int):
        self.cache_size = cache_size
        self.block_size = block_size
        self.num_lines = cache_size // block_size  # cache lines = cache size/ block size
        # initializes the cache as a list of dictionaries, where each dictionary represents a cache line
        self.cache = [{'valid': False, 'tag': None, 'data': None} for _ in range(self.num_lines)] # initialize the cache memory
        self.hits = 0
        self.misses = 0

    def _get_cache_line(self, address: int) -> int:
        # calculate cache lines index
        return (address // self.block_size) % self.num_lines

    def _get_tag(self, address: int) -> int:
        # claculate tag 
        return address // (self.block_size * self.num_lines)

    def read(self, address: int) -> bool:
        # read the data in cache
        line = self._get_cache_line(address) # get index 
        tag = self._get_tag(address)         # get tag
        # check if index and tag match or not
        if self.cache[line]['valid'] and self.cache[line]['tag'] == tag:
            self.hits += 1
            return True
        else:
            self.misses += 1
            self.cache[line] = {'valid': True, 'tag': tag, 'data': None}
            return False

    def write(self, address: int):
        # write the data in cache 
        line = self._get_cache_line(address)
        tag = self._get_tag(address)

        if self.cache[line]['valid'] and self.cache[line]['tag'] == tag:
            self.hits += 1
        else:
            self.misses += 1
            self.cache[line] = {'valid': True, 'tag': tag, 'data': None}

    def get_stats(self):
        return {'hits': self.hits, 'misses': self.misses}

    def reset(self):
        self.cache = [{'valid': False, 'tag': None, 'data': None} for _ in range(self.num_lines)]
        self.hits = 0
        self.misses = 0

# Test Cases
cache_sim = CacheSimulator(cache_size=1024, block_size=64)
print("Read 0x0000:", "hit" if cache_sim.read(0x0000) else "miss")  # Expected output: miss
print("Read 0x0040:", "hit" if cache_sim.read(0x0040) else "miss")  # Expected output: miss
print("Read 0x0000:", "hit" if cache_sim.read(0x0000) else "miss")  # Expected output: hit
cache_sim.write(0x0080)  # Expected output: miss
cache_sim.write(0x00C0)  # Expected output: miss
print("Read 0x0080:", "hit" if cache_sim.read(0x0080) else "miss")  # Expected output: hit
print(cache_sim.get_stats())  # Expected output: {'hits': 2, 'misses': 4}
