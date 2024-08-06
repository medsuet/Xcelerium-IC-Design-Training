class Cache:
    def __init__(self):
        self.valid = False
        self.tag = None
        self.data = None

class CacheSimulator:
    def __init__(self, cache_size: int, block_size: int):
        self.num_lines = cache_size // block_size
        self.cache = [Cache() for _ in range(self.num_lines)]
        self.block_size = block_size
        self.cache_size = cache_size
        self.hits = 0
        self.misses = 0

    def get_index_and_tag(self, address: int):
        # Calculate block offset, index and tag
        block_offset_bits = self.block_size.bit_length() - 1
        index_bits = self.num_lines.bit_length() - 1
        index = (address >> block_offset_bits) & ((1 << index_bits) - 1)
        tag = address >> (block_offset_bits + index_bits)
        return index, tag

    def read(self, address: int) -> bool:
        index, tag = self.get_index_and_tag(address)
        line = self.cache[index]

        if line.valid and line.tag == tag:
            self.hits += 1
            return True  # Hit
        else:
            self.misses += 1
            line.valid = True
            line.tag = tag
            line.data = address  
            return False  # Miss

    def write(self, address: int):
        index, tag = self.get_index_and_tag(address)
        line = self.cache[index]

        if line.valid and line.tag == tag:
            self.hits += 1
        else:
            self.misses += 1
            line.valid = True
            line.tag = tag
            line.data = address  

    def get_stats(self):
        return {'hits': self.hits, 'misses': self.misses}

    def reset_cache(self):
        self.cache = [Cache() for _ in range(self.num_lines)]
        self.hits = 0
        self.misses = 0

# Test Cases
cache_sim = CacheSimulator(cache_size=1024, block_size=64)
print(cache_sim.read(0x0000))  # Expected output: miss -> False
print(cache_sim.read(0x0040))  # Expected output: miss -> False
print(cache_sim.read(0x0000))  # Expected output: hit -> True
cache_sim.write(0x0080)        # Expected output: miss
cache_sim.write(0x00C0)        # Expected output: miss
print(cache_sim.read(0x0080))  # Expected output: hit -> True
print(cache_sim.get_stats())   # Expected output: {'hits': 2, 'misses': 4}
