import matplotlib.pyplot as pyplot
import matplotlib.animation as animation
import numpy

import sampler

FREQUENCY_RESOLUTION = 195.31 

class Animator:
    def __init__(self, mode = sampler.SERIAL_MODE):
        self.sampler = sampler.SampleReader(mode)
        self.figure = pyplot.figure()
        xmin = -100e3
        xmax = xmin+sampler.FRAME_SIZE*FREQUENCY_RESOLUTION
        ymin = 0
        ymax = 2**12
        self.X = numpy.arange(xmin, xmax, FREQUENCY_RESOLUTION)
        self.axis = pyplot.axes(xlim = (xmin, xmax), ylim = (ymin, ymax))
        self.line, = self.axis.plot([],[],lw=2)

    def animate(self, delay = 50):
        self.animation = animation.FuncAnimation(self.figure, self.updateFrame, frames = 30, init_func = self.initFrame, interval = delay, blit = True)

    def initFrame(self):
        self.line.set_data([],[])
        return self.line, 

    def updateFrame(self, i):
        # This function shall block, so the plot will stay static if no data present
        self.sampler.sampleFrame()
        while(self.sampler.hasNext()):
            self.sampler.sample()
        X = self.X
        Y = self.sampler.samples
        self.line.set_data(X,Y)
        self.sampler.reset()
        return self.line,

    def save(self):
        self.animation.save('basic_animation.mp4', fps=30)

    def show(self):
        pyplot.show()
