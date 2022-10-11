
# CSGO Send Images

Send images in CS:GO via either center text or the middle HTML-supported HUD element. *Compiled in SM 1.11.6906*

## Dependency

- kxnrl's [CSGO-HtmlHud](https://github.com/Kxnrl/CSGO-HtmlHud) plugin

## Commands

*(Note: Image urls must end with `.jpg`, `.png`, or other supported formats)*
`sm_img <url>` - Send via Center Text
`sm_img2 <url>` - Send via middle HUD element

## Changelog

- 0.5
  - Removed `csgocolors_fix` dependency
  - Changed hud plugin to kxnrl's public plugin instead of my fork
  - Removed unneeded changehook
