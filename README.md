cc-lib
======

A loosely coupled AS3 game development library
------

This ActionScript 3 library is a collection of classes which can be used independently of one another, but are also designed to work together to provide a foundation for utilizing Flash GPU rendering mode with bitmap graphics. The AssetMap class provides an API for rasterizing vector assets to bitmaps at runtime and caching them for later use. Only one instance of each bitmap is ever created, which is the key to effective utilization of GPU rendering in Flash.

The library also includes some custom display objects that are designed to work with the cached bitmaps, making it easy to create animated sprites directly from AssetMap. Also included are helper classes, such as an optimized A-Star pathfinding helper, a touch helper for working with mobile device input, and more general math and color helpers.
