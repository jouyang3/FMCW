import serial

SERIAL_MODE = 0x0
FILE_MODE = 0x1
DEVICE = "/dev/ttyACM0"
SRC_FILE = "FFT_Sweep"
BAUD = 9600
HEAD = 0xCC
MAX_Y = 2**12 # 12 bits depth
MAX_X = 10*10**6/8 # 10/8 MHz
FRAME_SIZE = 1024
BYTE_PER_SAMPLE = 2

class SampleReader:
    def __init__(self, mode = SERIAL_MODE): 
        self.count = 0
        self.samples = []
        self.mode = mode
        if mode == SERIAL_MODE:
            self.__openSerial__()
        elif mode == FILE_MODE:
            self.__openFile__()
    
    def __openSerial__(self):
        opened = False
        while not opened:
            try:
                self.fid = serial.Serial(DEVICE, BAUD, timeout=None)
                opened = True
            except serial.serialutil.SerialException:
                continue

    def __openFile__(self):
        print 'FILE_MODE'
        self.fid = open(SRC_FILE,'r')
         
    def sampleFrame(self):
        if self.mode == SERIAL_MODE:
            val = None
            while val != HEAD:
                val = ord(self.fid.read(1))

        self.raw = self.fid.read(FRAME_SIZE*BYTE_PER_SAMPLE)
        
    
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

    def close(self):
        self.fid.close()
