#!/usr/bin/python
""" prints the musical notation of a sound frequency """

from math import log2, pow
import sys

A4 = 440
C0 = A4*pow(2, -4-9/12)
sigla = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]

def tom(frequencia):
    """ return musical pitch """
    semitom = round(12*log2(frequencia/C0))
    oitava = semitom // 12
    nota = semitom % 12

    return f"{sigla[nota]}{str(oitava)}"


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Please inform just one argument.\nUsage: python pitch.py 739")
    else:
        frequency = float(sys.argv[1])
        result = tom(frequency)
        print(result)
