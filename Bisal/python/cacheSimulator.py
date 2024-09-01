'''
 * ============================================================================================================
 * Filename:    cacheSimulator.py
 * Description: File consists of code to implement cache simulator for direct mapped cache using nested arrays
 * Author:      Bisal Saeed
 * Date:        7/19/2024
 * ============================================================================================================
 '''
import random

class CacheSimulator:

   def __init__(self, cache_size: int, block_size: int):
      self.cacheSize= cache_size
      self.blockSize= block_size
      self.Valid = True                                                   #initialize valid bit = 0 
      self.tag= None                                                      #set tag bits to none 
      #intitialize hit and miss as zero 
      self.hit = 0 
      self.miss = 0 
      # Define the number of cache lines 
      self.numberOfCacheLines= self.cacheSize // self.blockSize

      #generate cache line of fixed structure for direct mapped cache depending on block size 
      self.cache=[]
      for i in range(self.numberOfCacheLines):
         self.data=[random.randint(0, 100) for i in range(block_size)]       # Data as a list of random integers
         self.cache = self.cache + [[self.Valid,self.tag,self.data]]
      print("CACHE\n")
      for i in range(0,self.numberOfCacheLines):
         print(self.cache[i])   #printing cache 
      print()

   def read(self, address: int) -> bool:

      self.offset=address & 0x3f                                          #lower 6 bits
      self.index=(address>>6) & 0xffff                                    #lower 4 bits after shifting offset bits
      self.tag= (address>>10) & 0xffffff                                  #lower 6 bits after shifting tag and offset bits
      #print("BITS DURING READ OF,IN,TAG: ", {self.offset},{self.index},{self.tag})
      #intially cache miss as no data fetched from memory to cache when read first 
      if (self.Valid == True) and (self.tag == self.cache[self.index][1] ):
            self.hit += 1                                              #cache hit if tagbits are found
            print("HIT")
            print("Data value read from cache in given cache line",self.index," is: ",self.cache[self.index][2][self.offset])
      else:
         self.miss +=1                                                   #cache miss if tagbits are not found
         self.cache[self.index][1]=self.tag                              #set tagbits in cache after reading from memory 
         print("MISS")

      

   def write(self, address: int):
      self.offset=address & 0x3f                                          #lower 6 bits
      self.index=(address>>6) & 0xffff                                    #lower 4 bits after shifting offset bits
      self.tag= (address>>10) & 0xffffff                                  #lower 6 bits after shifting tag and offset bits
      #print("BITS DURING READ OF,IN,TAG: ", {self.offset},{self.index},{self.tag})

      if (self.Valid == True) and (self.tag == self.cache[self.index][1] ):
         self.hit +=1
         print("HIT")
      else:
         self.miss +=1
         self.cache[self.index][1]=self.tag                              #set tagbits in cache for writing to memory 
         self.cache[self.index][2][self.offset]= 1                       #write value in cache 
         print("MISS")


   def get_stats(self):
      print("Total HITS: ",self.hit)
      print("Total Misses: ",self.miss)



cache_sim = CacheSimulator(cache_size=1024, block_size=64)
cache_sim.read(0x0000) # Expected output: miss
print()
cache_sim.read(0x0040) # Expected output: miss
print()
cache_sim.read(0x0000) # Expected output: hit
print()
cache_sim.write(0x0080) # Expected output: miss
print()
cache_sim.write(0x00C0) # Expected output: miss
print()
cache_sim.read(0x0080) # Expected output: hit
print()
cache_sim.get_stats() # Expected output: {'hits': 2, 'misses': 4}