""" Structure of Cache Line """
class CacheLine:
    def __init__(self):
        self.valid = False
        self.tag = None
        self.data = None

class CacheSimulator:
    def __init__(self, cache_size=1024, block_size=64):
        self.num_lines = cache_size // (block_size // 8)
        self.block_size = block_size
        self.cache = [CacheLine() for i in range(self.num_lines)]
        self.hits = 0
        self.misses = 0

    def _get_index_and_tag(self, address: int):
        index = int(address / self.block_size) % self.num_lines
        tag = int(address / (self.block_size * self.num_lines))
        return index, tag

    def read(self, address: int) -> bool:
        index, tag = self._get_index_and_tag(address)
        line = self.cache[index]
        if line.valid and line.tag == tag:
            self.hits += 1
            print("hit")
            return True
        else:
            self.misses += 1
            line.valid = True
            line.tag = tag
            print("miss")
            return False

    def write(self, address: int):
        self.read(address)  # For direct-mapped cache, write will be the same as read in terms of hit/miss

    def reset(self):
        self.cache = [CacheLine() for j in range(self.num_lines)]
        self.hits = 0
        self.misses = 0

    def get_stats(self):
        return {'hits': self.hits, 'misses': self.misses}

# Test Cases
cache_sim = CacheSimulator(cache_size=1024, block_size=64)
cache_sim.read(0x0000) # Expected output: miss
cache_sim.read(0x0040) # Expected output: miss
cache_sim.read(0x0000) # Expected output: hit
cache_sim.write(0x0080) # Expected output: miss
cache_sim.write(0x00C0) # Expected output: miss
cache_sim.read(0x0080) # Expected output: hit
print(cache_sim.get_stats()) # Expected output: {'hits': 2, 'misses': 4}
