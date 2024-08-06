class CacheSimulator:
    def __init__(self, cache_size: int, block_size: int):
        self.cache={}
        self.cache_size=cache_size
        self.block_size=block_size
        self.hit_count=0
        self.miss_count=0
        index_size=cache_size//block_size
        tag=None
        for i in range(0,index_size):
            self.cache[i]=[1,tag,[0 for x in range(self.block_size)]]
        #print(self.cache)
        
    def read(self, address: int) -> bool:
        mem_tag=(address>>10)&0xffff
        index=(((address<<6)&0xffff)>>12)&0xffff
        offset=(address&0x003f)
        print("Tag is",mem_tag)
        print("Offset is",offset)
        print("Index is",index)
        if ((mem_tag==self.cache[index][1])&(self.cache[index][0]==1)):
            read_data=self.cache[index][2][offset]
            self.hit_count = self.hit_count+1
            return True
        else:
            self.cache[index][1]=mem_tag
            self.cache[index][2]=[x for x in range(self.block_size)]
            self.miss_count = self.miss_count+1
            return False         

    def write(self, address: int):
        mem_tag=(address>>10)&0xffff
        index=(((address<<6)&0xffff)>>12)&0xffff
        offset=(address&0x003f)
        print("Tag is",mem_tag)
        print("Offset is",offset)
        print("Index is",index)
        if ((mem_tag==self.cache[index][1])&(self.cache[index][0]==1)):
            self.cache[index][2][offset]=index
            self.hit_count = self.hit_count+1
            return True
        else:
            self.cache[index][1]=mem_tag
            self.cache[index][2]=[x**2 for x in range(self.block_size)]
            self.miss_count = self.miss_count+1
            return False
 # Your implementation here
    def get_stats(self):
        print("Number of hits",self.hit_count)
        print("Number of misses",self.miss_count)
        
 # Your implementation here
# Test Cases
cache_sim = CacheSimulator(cache_size=1024, block_size=64)
print("---------------------------")
print(cache_sim.read(0x0000)) # Expected output: miss
print("---------------------------")
print(cache_sim.read(0x0040)) # Expected output: miss
print("---------------------------")
print(cache_sim.read(0x0000)) # Expected output: hit
print("---------------------------")
print(cache_sim.write(0x0080)) # Expected output: miss
print("---------------------------")
print(cache_sim.write(0x00C0)) # Expected output: miss
print("---------------------------")
print(cache_sim.read(0x0080)) # Expected output: hit
print("---------------------------")
cache_sim.get_stats()# Expected output: {'hits': 2, 'misses': 4}