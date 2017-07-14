
# Terminal Cancer
# BASED ON Touch Bär

Terminal Cancer has the same license as Touch Bär.

by @f4bul1z3r

pls be careful i dont guarantee this shit even works



![](screenshot.png)

Touch Bär uses **undocumented, private API** to add a Touch Bar button to the Control Strip on the right-band side of the keyboard.

```objc
DFRElementSetControlStripPresenceForIdentifier(NSString *, BOOL);
DFRSystemModalShowsCloseBoxWhenFrontMost(BOOL);

+[NSTouchBarItem addSystemTrayItem:]
+[NSTouchBar presentSystemModalFunctionBar:systemTrayItemIdentifier:]
```

## # Terminal-CancerAuthor

Alexsander Akers, me@a2.io

## License

Touch Bär is available under the MIT license. See the LICENSE file for more info.


