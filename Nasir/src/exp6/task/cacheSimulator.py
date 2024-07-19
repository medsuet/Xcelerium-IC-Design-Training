class CacheSimulator:
    def __init__(self, cacheSize: int, blockSize: int):
        """
        Initialize the Cache Simulator with given cache size and block size.

        Arguments:
        cacheSize (int): Total size of the cache in bytes.
        blockSize (int): Size of each block in bytes.

        Attributes:
        numberOfLines (int): Number of lines (blocks) in the cache.
        cache (list): List representing the cache, each entry is a dictionary with 'valid', 'tag', and 'data' fields.
        hits (int): Number of cache hits.
        misses (int): Number of cache misses.
        """
        self.cacheSize = cacheSize
        self.blockSize = blockSize
        self.numberOfLines = cacheSize // blockSize  # Calculate the number of cache lines
        self.cache = [{'valid': False, 'tag': None, 'data': None} for _ in range(self.numberOfLines)]  # Initialize cache
        self.hits = 0
        self.misses = 0

    def _get_cache_line(self, address: int) -> int:
        """
        Calculate the cache line index for a given address.

        Arguments:
        address (int): Memory address.

        Returns:
        int: Cache line index.
        """
        return (address // self.blockSize) % self.numberOfLines

    def _get_tag(self, address: int) -> int:
        """
        Calculate the tag for a given address.

        Arguments:
        address (int): Memory address.

        Returns:
        int: Tag for the address.
        """
        return address // (self.numberOfLines * self.blockSize)

    def read(self, address: int) -> bool:
        """
        Simulate a read operation on the cache.

        Arguments:
        address (int): Memory address to read.

        Returns:
        bool: True if it is a cache hit, False if it is a miss.
        """
        line = self._get_cache_line(address)  # Get the cache line index
        tag = self._get_tag(address)  # Get the tag

        if self.cache[line]['valid'] and self.cache[line]['tag'] == tag:
            self.hits += 1  # Increment hits if the cache line is valid and tags match
            return True
        else:
            self.misses += 1  # Increment misses if it's a cache miss
            self.cache[line] = {'valid': True, 'tag': tag, 'data': None}  # Update the cache line with new tag and mark as valid
            return False

    def write(self, address: int):
        """
        Simulate a write operation on the cache.

        Arguments:
        address (int): Memory address to write.
        """
        line = self._get_cache_line(address)  # Get the cache line index
        tag = self._get_tag(address)  # Get the tag

        if self.cache[line]['valid'] and self.cache[line]['tag'] == tag:
            self.hits += 1  # Increment hits if the cache line is valid and tags match
        else:
            self.misses += 1  # Increment misses if it's a cache miss

        self.cache[line] = {'valid': True, 'tag': tag, 'data': None}  # Update the cache line with new tag and mark as valid

    def get_stats(self):
        """
        Get the cache hit and miss statistics.

        Returns:
        dict: Dictionary with 'hits' and 'misses' counts.
        """
        return {'hits': self.hits, 'misses': self.misses}

# Test Cases
myCacheSimulator = CacheSimulator(cacheSize=1024, blockSize=64)

# Perform read and write operations and print results with expected outcomes
print("Read 0x0000:", "hit" if myCacheSimulator.read(0x0000) else "miss")  # Expected output: miss
print("Read 0x0040:", "hit" if myCacheSimulator.read(0x0040) else "miss")  # Expected output: miss
print("Read 0x0000:", "hit" if myCacheSimulator.read(0x0000) else "miss")  # Expected output: hit
print("Write 0x0080")
myCacheSimulator.write(0x0080)  # Expected output: miss
print("Write 0x00C0")
myCacheSimulator.write(0x00C0)  # Expected output: miss
print("Read 0x0080:", "hit" if myCacheSimulator.read(0x0080) else "miss")  # Expected output: hit

# Print final hit and miss statistics
print(myCacheSimulator.get_stats())  # Expected output: {'hits': 2, 'misses': 4}
