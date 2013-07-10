So far, ConOnRails is the product of one coder, one UI designer, one "idea guy" and, since it's now been used for two CONvergence conventions, the reports of the various people who have used it.

The good news is, it does most of what we intend it to do, and does it reasonably well.

The bad news is, there are some ugly corners of the code most of which date back to when I was initially learning Rails -- this project was my first Rails project and an early Ruby project for me.

Also, while it's always been our intention that this code be useful for others, there are still some hard-coded 'CONvergence' assumptions in terms of both structure and occasionally text.

Returning to the good news: these things are fixable, and we would like to fix them, either ourselves, or with help!

So:

  * Yes, please fork if you're interested!
  * Yes, we will take pull requests!
  * Yes, we will retain credit for any contributed code we merge in via pull request.
  * If you see something that REALLY doesn't make sense, ask!

Our basic goals:

  * TDD is good. We like tests. Test stuff!
  * Clean code is good. I did a lot of cleanup with the help of Code Climate's free trial period. I'm thinking of actually paying for it, because it's a good watchdog.
  * Don't create **new** con-specific things. Make things configurable wherever possible.

The near-term road-map:

  * Fix bugs discovered during CONvergence 2013, especially radio management bugs!
  * Enhance Lost and Found interface based on CVG2013 suggestions.
  * Fix main page so that Merge Mode and other temporary states don't vanish on a Javascript auto-refresh.

After this, we may be taking a bit of a break from this project to tackle a new, related challenge: a scheduling system for volunteer operations like a convention. CONvergence has tried a couple of different solutions that proved inadequate in various ways. We don't doubt that the problem is hard...but we think we might be able to lick it.

That said, we want to support people who might be using this for other conventions. If there's a feature you **need** and don't think you would be able to add yourself, please let us know and we'll see what we can do for you!

Michael Shappe <mshappe@camelopard-consulting.com>
Software Guy, ConOnRails

