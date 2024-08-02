
"""
============================================================================
 * Filename:   Direct_Mapping_Cache.py
 * Description: Simple code for the imlepmentation of cache
 * Author:      Hira Firdous
 * Date:        19/07/2024
 * ===========================================================================

"""

#Helper Function:
def power_of_two(num):
    """
    :param num: even number
    :return: exponent of two
    """
    if num <= 0 or num % 2 != 0:
        raise ValueError("The input number must be a positive even number.")
    exponent = 0
    while num % 2 == 0:
        num //= 2
        exponent += 1
    return exponent



class address:
    """
    decode the address into
        - tag
        - offset
        - index
    PRE-DEFINED THINGS:
        - Address Bus
        - Tag size
        - Index Size
    """
    def __init__(self, address,address_bus,tag_size,index_size):
        """
        :param address: Takes the x value
                initialize the value of attributes
                    - tag
                    - offset
                    - index
        """

        temp=bin(address)[2:].zfill(address_bus)
        self.tag= int(temp[0:tag_size], 2)
        self.index=int(temp[tag_size:(tag_size+index_size)], 2)
        self.offset=int(temp[(tag_size+tag_size):], 2)

    def __str__(self):
        """
        :return: prints the value of attributes
        """
        print("Value in tag is",bin(self.tag)[2:].zfill(tag_size))
        print("Value in offset is", bin(self.offset)[2:].zfill(offset_size))
        print("Value in index is", bin(self.index)[2:].zfill(index_size))

    def get_tag(self):
        """
        :return: value of tag
        """
        return self.tag


    def get_index(self):
        """
        :return: value of index
        """
        return self.index


    def get_offset(self):
        """
        :return: value of offset
        """
        return self.offset






class CacheSimulator:
    def __init__(self, cache_size: int, block_size: int):
        """
        :param cache_size: Size of the cache
        :param block_size: No. of blocks specified

        DEFINES:
        - Address Bus
        - Tag size
        - Index Size
        - offset Size
        """
        self.offset_size=power_of_two(block_size)
        self.index_size=power_of_two(cache_size)-power_of_two(block_size)
        self.address_bus=16
        self.tag_size=self.address_bus-(self.index_size+self.offset_size)


        #{index1:[NONE,value],index2:[NONE,value],index3:[NONE,value]}
        self.cache={i: [None, [0]*block_size] for i in range(self.index_size)}               #initialize the dictionary
        self.Miss=0
        self.Hit=0


        """
            The variable will hold the data
            This variable is for now is kept undefined
            since there is no memory integration.
            However, this variable will then use in
            read and write operations to hold the 
            data at that specific offset
        """
        #self.data


    def read(self, in_address: int):
        """
        :param in_address: input the hex of address
        :Print: Print either hit or a miss
        :return: NONE
        """
        temp = address(in_address,self.address_bus,self.tag_size,self.index_size)
        if (self.cache[temp.get_index()][0] == temp.get_tag()):
            self.Hit=self.Hit+1
            print("its a hit")
        else:
            self.Miss=self.Miss+1
            self.cache[temp.get_index()][0]=temp.get_tag()           #tag
            self.cache[temp.get_index()][1][temp.get_offset()]=1      #data
            print("its a Miss")


    def write(self, in_address: int):
        """
        :param in_address: Input the hex of address
        :Print: Print either hit or a miss
        :return: NONE
        """
        temp = address(in_address,self.address_bus,self.tag_size,self.index_size)
        if (self.cache[temp.get_index()][0] == temp.get_tag()):
            self.Hit = self.Hit + 1
            self.cache[temp.get_index()][1][temp.get_offset()]=1      #data For now have been initialized to 1
            print("Hit")
        else:
            self.Miss = self.Miss + 1
            self.cache[temp.get_index()][0] = temp.get_tag()  # tag
            self.cache[temp.get_index()][1][temp.get_offset()] = 1  # data For now have been initialized to 1
            print("its a Miss")

    def __str__(self):
        """
        Print the cache
        :return: NONE
        """
        for key, value in self.cache.items():
            print(key, value)


    def get_stats(self):
        """
        Prints the number of hit and Miss of the Cache
        :return: Number of Hit and Miss
        """
        print("Number of hits: ", self.Hit," Number of Miss ", self.Miss)

def main():
    # Test Cases
    cache_sim = CacheSimulator(cache_size=1024, block_size=64)
    cache_sim.read(0x0000)  # Expected output: miss
    cache_sim.read(0x0040)  # Expected output: miss
    cache_sim.read(0x0000)  # Expected output: hit
    cache_sim.write(0x0080)  # Expected output: miss
    cache_sim.write(0x00C0)  # Expected output: miss
    cache_sim.read(0x0080)  # Expected output: hit
    print(cache_sim.get_stats())  # Expected output: {'hits': 2, 'misses': 4}
    #cache_sim.__str__()


if __name__ == "__main__":
    main()