import serial

DEVICE = "/dev/ttyACM0"
BAUD = 9600
HEAD = 0xCC
MAX_Y = 2**12 # 12 bits depth
MAX_X = 10**6 # 10 MHz
FRAME_SIZE = 1024
BYTE_PER_SAMPLE = 2

class SampleReader:
    def __init__(self):
        opened = False
        while not opened:
            try:
                self.serial = serial.Serial(DEVICE, BAUD, timeout=None)
                opened = True
            except serial.serialutil.SerialException:
                continue
        self.count = 0
        self.samples = []

    def sampleFrame(self):
        val = None
        while val != HEAD:
            val = ord(self.serial.read(1))

        self.raw = self.serial.read(FRAME_SIZE*BYTE_PER_SAMPLE)
        
    
    def sample(self):
        c = self.count
        high = ord(self.raw[c*2])
        low = ord(self.raw[c*2+1])
        self.count += 1
        
        num = (high<< 8) + low
        self.samples.append(num)
        return num

    def hasNext(self):
        return self.count < FRAME_SIZE 

    def reset(self):
        self.count = 0
        self.samples = [] 

