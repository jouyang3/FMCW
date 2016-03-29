import matplotlib.pyplot as pyplot
import numpy

import animator
import sampler

def main():
    anim = animator.Animator(mode = sampler.FILE_MODE)
    anim.animate()
    anim.save()
    anim.show()
    while(True):
        pass

if __name__ == '__main__':
    main()

