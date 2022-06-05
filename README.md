# CSGO Send Images
Send images in CS:GO through Center Text.

*Note: Compiled in `SM 1.11.6882`*

# Command
`sm_img <image url>` *(Note: Image urls must end with `.jpg`,`.png`, or `.jpeg`)*

# Change Log
## 0.1
- Initial Commit
## 0.2
- Added a "workaround" for images not displaying by creating a timer to automatically resend the same message so the precached images is displayed
- Added `sm_images_resend` cvar to set how much time before the image is resent so the cached image shows up