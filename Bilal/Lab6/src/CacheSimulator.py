class CacheSimulator:
    def __init__(self, cache_size: int, block_size: int):
        """
        Initialize the CacheSimulator with a given cache size and block size.
        
        Args:
            cache_size (int): The total size of the cache in bytes.
            block_size (int): The size of each block in bytes.
        """
        self.cache_size = cache_size
        self.block_size = block_size
        self.num_lines = cache_size // block_size
        self.cache = [{"valid": False, "tag": None, "data": None} for _ in range(self.num_lines)]
        self.hits = 0
        self.misses = 0

    def _get_index_and_tag(self, address: int) -> tuple[int, int]:
        """
        Compute the index and tag for a given address.
        
        Args:
            address (int): The memory address to calculate index and tag for.
        
        Returns:
            tuple[int, int]: The index and tag for the given address.
        """
        index = (address // self.block_size) % self.num_lines
        tag = address // self.cache_size
        return index, tag

    def read(self, address: int) -> bool:
        """
        Read from the cache at a specific address.
        
        Args:
            address (int): The memory address to read from.
        
        Returns:
            bool: True if the read was a hit, False if it was a miss.
        """
        index, tag = self._get_index_and_tag(address)
        if self.cache[index]["valid"] and self.cache[index]["tag"] == tag:
            self.hits += 1
            return True
        else:
            self.cache[index] = {"valid": True, "tag": tag, "data": None}
            self.misses += 1
            return False

    def write(self, address: int) -> None:
        """
        Write to the cache at a specific address.
        
        Args:
            address (int): The memory address to write to.
        """
        index, tag = self._get_index_and_tag(address)
        if self.cache[index]["valid"] and self.cache[index]["tag"] == tag:
            self.hits += 1
        else:
            self.cache[index] = {"valid": True, "tag": tag, "data": None}
            self.misses += 1

    def get_stats(self) -> dict[str, int]:
        """
        Get the cache statistics.
        
        Returns:
            dict[str, int]: A dictionary with hit and miss statistics.
        """
        return {"hits": self.hits, "misses": self.misses}


# Example usage
cache_sim = CacheSimulator(cache_size=1024, block_size=64)

# Testing read and write operations
print("Read 0x0000:", "Hit" if cache_sim.read(0x0000) else "Miss")  # Expected output: Miss
print("Read 0x0040:", "Hit" if cache_sim.read(0x0040) else "Miss")  # Expected output: Miss
print("Read 0x0000:", "Hit" if cache_sim.read(0x0000) else "Miss")  # Expected output: Hit
print("Write 0x0080:", "Hit" if cache_sim.write(0x0080) else "Miss")  # Expected output: Miss
print("Write 0x00C0:", "Hit" if cache_sim.write(0x00C0) else "Miss")  # Expected output: Miss
print("Read 0x0080:", "Hit" if cache_sim.read(0x0080) else "Miss")  # Expected output: Hit
print(cache_sim.get_stats())  # Expected output: {'hits': 2, 'misses': 4}
