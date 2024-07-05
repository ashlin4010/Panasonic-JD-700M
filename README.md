# Panasonic JD-700M #

This repository contains notes and test applications I am using to fix a Panasonic JD-700M

### What's Wrong with the System ###
the system has a fault in the RAS and CAS lines. One or more of them are stuck and the system is only able to access a small portion of memory.

A certain region of memory keeps repeating itself about 12 times.

### What needs to be done ###
The fix should be relatively simple, I need to identify the fault in the address decoding logic and replace the the faulty components.

One way to do this is to simply replace every chip, another is to write some assembly to exercise specific portions of the memory and identify the faulty components.