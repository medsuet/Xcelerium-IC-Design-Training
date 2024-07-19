import numpy as np
class CacheSimulator:
    def __init__(self, cache_size: int, block_size: int):
        # Your implementation here
        self.cache_size=cache_size
        self.block_size=block_size
        self.Cache=[[0,0,0,0] for i in range(self.cache_size)]
        for i in range(0,self.cache_size):
            self.Cache[i][2]=i
        Block_Track=[0]*self.block_size
        self.Main_Memory=[[0,0] for i in range(1024)]
        self.Main_Memory=np.array(self.Main_Memory)
        for i in range(0,1024):
            self.Main_Memory[i][0]=i
            self.Main_Memory[i][1]=20*i
        self.num_hits=0
        self.num_misses=0
        self.Stats=[[0,"x"] for i in range(50)]
        self.N=0
        
    def read(self, address: int) -> bool:
        # Your implementation here
        Index=address&(0b1111111)
        Tag=(address&(0xffffff80))>>7
        if self.Cache[Index][0]==1:
            if self.Cache[Index][1]==Tag:
                print("Hit")
                self.Stats[self.N][0]=address
                self.Stats[self.N][1]="Hit"
                self.num_hits+=1
            else:
                print("Miss")
                self.Stats[self.N][0]=address
                self.Stats[self.N][1]="Miss"
                self.Cache[Index][1]=Tag
                self.Cache[Index][3]=self.Main_Memory[Index][1]
                self.Cache[Index][0]=1
                self.num_misses+=1
                
        else:
            print("Miss")
            self.Stats[self.N][0]=address
            self.Stats[self.N][1]="Miss"
            self.Cache[Index][1]=Tag
            self.Cache[Index][3]=self.Main_Memory[Index][1]
            self.Cache[Index][0]=1
            self.num_misses+=1
        self.N+=1
 
    def write(self, address: int): 
        # Your implementation here
        Index=address&(0b1111111)
        Tag=(address&(0xffffff80))>>7
        if self.Cache[Index][0]==1:
            if self.Cache[Index][1]==Tag:
                print("Hit")
                self.Stats[self.N][0]=address
                self.Stats[self.N][1]="Hit"
                self.num_hits+=1
            else:
                print("Miss")
                self.Stats[self.N][0]=address
                self.Stats[self.N][1]="Miss"
                self.Cache[Index][1]=Tag
                self.Cache[Index][3]=self.Main_Memory[Index][1]
                self.Cache[Index][0]=1
                self.num_misses+=1
                
        else:
            print("Miss")
            self.Stats[self.N][0]=address
            self.Stats[self.N][1]="Miss"
            self.Cache[Index][1]=Tag
            self.Cache[Index][3]=self.Main_Memory[Index][1]
            self.Cache[Index][0]=1
            self.num_misses+=1
        self.N+=1 
    def get_stats(self): 
        # Your implementation here
        x= "{'hits': "+str(self.num_hits)+", 'misses': "+str(self.num_misses)+"}"
        #print(self.Stats)
        return x

# Test Cases
cache_sim = CacheSimulator(cache_size=1024, block_size=64)
cache_sim.read(0x0000)  # Expected output: miss
cache_sim.read(0x0040)  # Expected output: miss
cache_sim.read(0x0000)  # Expected output: hit
cache_sim.write(0x0080,) # Expected output: miss
cache_sim.write(0x00C0) # Expected output: miss
cache_sim.read(0x0080)  # Expected output: hit
print(cache_sim.get_stats())  # Expected output: {'hits': 2, 'misses': 4}