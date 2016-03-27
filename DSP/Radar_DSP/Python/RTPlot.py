import matplotlib.pyplot as pyplot
import numpy

import sampler

FREQUENCY_RESOLUTION = 4882.8

def main():
    s = sampler.SampleReader()
    while True:
        s.sampleFrame()
        while(s.hasNext()):
            s.sample()
        X = numpy.arange(0, sampler.FRAME_SIZE*FREQUENCY_RESOLUTION, FREQUENCY_RESOLUTION)
        Y = s.samples
        pyplot.plot(X,Y)
        pyplot.show()
        

if __name__ == '__main__':
    main()

