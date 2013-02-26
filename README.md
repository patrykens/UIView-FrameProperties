UIView-FrameProperties
======================

Why ?
-----

Because setting views straight from code is less error-prone than setting them from XIB or Storyboard - period.

And it's more fun.

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

<pre><code>
// Centering subviews which moves every one of them by the same amount
[self.view centerSubviews:[NSArray arrayWithObjects:self.label, self.button, nil] 
                   inRect:CGRectMake(0, 0, 268, self.view.height)];
</code></pre>

or

<pre><code>
// Aligning views horizontally which positions them in one line preserving equal space between them
[self.view alignSubviewsHorizontally:[NSArray arrayWithObjects:self.button1, self.button2, self.button3, nil] 
                                type:AlignmentTypeEqualSpace];
</code></pre>


That's it! Have fun :)
----



