UIView-FrameProperties
======================

Why ?
-----

This category was designed with purpose of making it easier to position views in relation to other views, when designing view layout without Auto Layout.

Also it provides easy way to add multiple subviews at once with centering

Warning!

This category should be used with caution when dealing with transformed views as it accesses and overwrites frame of a view.

Setup
-------

Just drag & drop files to your project.
You can either add UIView+FrameProperties.h directly in a file, or - for convenience - in pch file.

Usage
------

Most methods should be self explanatory.

You can find basic accessors for UIView frame properties as well as methods for more advanced aligning.

There are two kinds of methods:
* those, which help to position UIView instance (or any other subclass) in regards to other siblings

<pre><code>[self.label alignToTopWithMargin:20 centered:NO];
[self.label centerHorizontalyInRect:CGRectMake(0, 0, 268, self.view.height)];
[self.button placeBelowView:self.label withMargin:10 centered:YES];
</code></pre>

* those, which help to position child views in parent view

<pre><code>// Centering subviews which moves every one of them by the same amount
[self.view centerSubviews:@[self.label, self.button] 
                   inRect:CGRectMake(0, 0, 268, self.view.height)];
</code></pre>

or

<pre><code>// Aligning views horizontally which positions them in one line preserving equal space between them
[self.view alignSubviewsHorizontally:@[self.button1, self.button2, self.button3] 
                                type:AlignmentTypeEqualSpace];
</code></pre>


That's it! Have fun :)
----



