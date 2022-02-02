cc-lib
======

A loosely-coupled AS3 game development library
------

This ActionScript 3 library is a collection of classes which can be used independently of one another, but are also designed to work together to provide a foundation for utilizing GPU rendering mode and bitmap-based graphics. The AssetMap class provides a simple API for rasterizing vector assets at runtime and caching them for later use. Only one instance of each graphic is ever created, which is the key to effective utilization of the GPU.

The library also includes some custom display objects that are designed to work with the cached bitmaps, making it easy to create animated sprites directly from AssetMap. Also included are general helper classes, such as a performance-optimized A-Star pathfinding helper, and a touch helper for working with mobile device input.
