
class CacheSimulator:
    def  __init__(self, cache_size:int, block_size:int):
        self.cache_size = cache_size
        self.block_size = block_size
        #calculating the number oof lines 
        self.num_lines = cache_size // block_size
        #Initilaizing the cache by using  the list consisting of dictiinories
        # dictionary  contains the valid bit , tag bits , data 
        self.cache = [{"valid":False,"tag ":None,"data":None} for _ in range(self.num_lines)]
        # Taking record of the hits and the misses
        self.hits = 0
        self.misses = 0

    def _get_index_and_tag(self,address:int):
        #calculating the index
        index = (address // self.block_size) % self.num_lines
        #calculating the tag
        tag = address // self.cache_size
        return index, tag

    def read(self,address:int)-> bool:
        # Calculating index and tag fromm the  address
        index ,tag = self._get_index_and_tag(address)
        #checking at the given index whether the valid  bit  is 1 and the tag bit matches the tag
        if self.cache[index]["valid"] and self.cache[index]["tag"] == tag:
            self.hits += 1
            return True
        else:
            #store the given information at the index of the list
            self.cache[index] = {"valid":True,"tag":tag,"data":None}
            self.misses += 1
            return False

    def write(self,address:int):
         # Calculating index and tag fromm the  address
        index ,tag = self._get_index_and_tag(address)
        #checking at the given index whether the valid  bit  is 1 and the tag bit matches the tag
        if self.cache[index]["valid"] and self.cache[index]["tag"] == tag:
            self.hits += 1
        else:
            #store the given information at the index of the list
            self.cache[index] = {"valid":True,"tag":tag,"data":None}
            self.misses += 1
    
    def get_stats(self):
        return {f'Hits : {self.hits} , Miss : {self.misses}' }



cache_sim = CacheSimulator(cache_size=1024,block_size=64)
print("Read 0x0000:", "Hit" if cache_sim.read(0x0000) else "Miss")  # Expected output: miss
print("Read 0x0040:", "Hit" if cache_sim.read(0x0040) else "Miss")  # Expected output: miss
print("Read 0x0000:", "Hit" if cache_sim.read(0x0000) else "Miss")  # Expected output: hit
print("Write 0x0080:", "Hit" if cache_sim.write(0x0080) else "Miss")  # Expected output: miss
print("Write 0x00C0:", "Hit" if cache_sim.write(0x00C0) else "Miss")  # Expected output: miss
print("Read 0x0080:", "Hit" if cache_sim.read(0x0080) else "Miss")  # Expected output: hit
print(cache_sim.get_stats())  # Expected output: {'hits': 2, 'misses': 4}
