# Clean Start Tiles
** Remove all pinned tiles in the Start Menu **

![Harry Tuttle](https://goo.gl/d5PY5U)

## Overview

While Windows 10 is an improvement in many ways, Microsoft has seen fit to spam every new install with tons of 'live tiles' and pinned apps, with no gui-based way to remove them in mass.

The average user does not need or want these tiles, and they get in the way of tiles actually pinned by the user.

Thanks to apparently prolific work of some German dude, copious copypasta exists to tackle the issue.  Unfortunately, this tends to involve:

* a properly configured Powershell, in advance,
* familiarity with ad-hoc Powershell development,
* the user explicitly naming each tile to be removed (without a hint of how to identify the proper id.
* the shameless violation of DRY as magic stings are plastered across conditionals.  

All of which is fine for building system images, but it in no way meets the needs of the highly mobile admistrator who actually works with normal consumer systems outside the ivory tower of enterprise (e.g. the Harry Tuttle).

This is my attempt to solve that crisis, so that users might survive the oversight and hubris of both Microsoft and the tech community at large.

Go forth and be free.

## Usage

* Ensure powershell scripts [have permission to run](#permission-helpers).
* Have the `.ps1` (cli-script) and `.psm1` (module-library) in the same folder.
* Run the `.ps1` file with powershell.
  * e.g. right-click file menu -> `Run with Powershell`.
  * e.g. terminal -> `powershell ./clean-start-tiles.ps1`
  * etc.

## Permission Helpers

Powershell does not have permission to execute scripts by default (on most systems).

To use this tool, you need to make sure script permission is enabled.

`.bat` scripts are included to enable and disable script permission at the *user level*.

* Run `ps.scripts.enable.bat` to **enable powershell script execution.**
* Run `ps.scripts.disable.bat` to **disbale powershell script execution.**

## Known Issues

* Only works with tiles registered under the COM Application clsid. Other types of tiles exist, but their location / clsid is currently unknown.

* Only works in english (by default).  To localize, change the `$UNPIN_LABEL` in the module file to whatever the right-click option to unpin from start says.
