class CacheSimulator:
    def __init__(self, cache_size : int,block_size:int):
        self.cache_size = cache_size
        self.block_size = block_size
        self.num_lines  = self.cache_size // self.block_size
        
        #now i want to make an empty cache
        self.cache = []
        for i in range(self.num_lines):
            cache_lines = {"valid":True,"tag":None,"data":None}
            self.cache.append(cache_lines)
        self.hits = 0
        self.misses = 0
    def _get_index_and_tag(self, address: int):
        # Calculate the cache line index and tag for a given address
        tag = address //(self.block_size * self.num_lines)
        index = (address // self.block_size) % self.num_lines
        return index, tag
    def read(self, address:int):
        index,tag = self._get_index_and_tag(address)
        #now i want to find specific line in my cache memory at what line this addres is present
        cache_line = self.cache[index]
        if cache_line["valid"] and cache_line["tag"] == tag:
            self.hits = self.hits + 1
            return True
        else:
            self.misses = self.misses + 1
            cache_line['valid'] = True
            cache_line['tag'] = tag
            cache_line['data'] = f"Data at address {address}"
            return False
    def write( self, address:int):
        index,tag = self._get_index_and_tag(address)
        #now i want to find specific line in my cache memory at what line this addres is present
        cache_line = self.cache[index]
        if cache_line["valid"] and cache_line["tag"] == tag:
            self.hits = self.hits + 1
            return True
        else:
            self.misses = self.misses + 1
            cache_line['valid'] = True
            cache_line['tag'] = tag
        cache_line['data'] = f"Data at address {address}"
    def get_status(self):
        return {'hits': self.hits, 'misses': self.misses}
    def reset_cache(self, address:int):
        # Reset and initialize the cache
        self.cache = []
        for i in range(self.num_lines):
            cache_line = {'valid': False, 'tag': None, 'data': None}
            self.cache.append(cache_line)
        self.hits = 0
        self.misses = 0

cache_sim = CacheSimulator(cache_size = 1024, block_size = 64)       
print(cache_sim.read(0x0000))  # Expected output: False (miss)
print(cache_sim.read(0x0040))  # Expected output: False (miss)
print(cache_sim.read(0x0000))  # Expected output: True (hit)
print(cache_sim.write(0x0080)) # Expected output: None (miss)
print(cache_sim.write(0x00C0)) # Expected output: None (miss)
print(cache_sim.read(0x0080))  # Expected output: True (hit)
print(cache_sim.get_status())  # Expected output: {'hits': 2, 'misses': 4}
 
            
        
        
        